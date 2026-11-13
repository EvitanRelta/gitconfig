#!/usr/bin/perl
# Wraps git-graph's (already coloured) output to the terminal width.
#
# Usage: git-graph ... | perl git-graph-wrap.pl <columns>
#
# - Continuation lines are indented so the text lines up with the start of the
#   commit message (the part after "<hash> - (<date>) "), or with the start of
#   the text if the line doesn't look like that.
# - The graph is continued on those lines: a column gets a vertical line if the
#   row above connects downwards there AND the row below connects upwards.
# - Colours active at a wrap point are closed, then reopened on the next line.
# - Lines whose graph leaves too little room for text are left unwrapped.
use strict;
use warnings;
no warnings 'utf8';
use utf8;
binmode STDIN,  ':encoding(UTF-8)';
binmode STDOUT, ':encoding(UTF-8)';

my $cols     = ($ARGV[0] // 80) =~ /^\d+$/ ? $ARGV[0] : 80;
my $MIN_TEXT = 20;    # don't wrap if less room than this is left for text

my $ESC   = qr/\e\[[0-9;]*[A-Za-z]/;
my $GRAPH = qr/[ ●○│─┼└┌┐┘┤├┴┬<>╰╭╮╯┃━╋┗┏┓┛┫┣┻┳║═╬╚╔╗╝╣╠╩╦*o|\-+'.]/;
# Graph characters (all styles) that connect to the row below / above.
my %DOWN = map { $_ => 1 } split //, '│┃║┼╋╬┌╭┏╔┐╮┓╗┤┫╣├┣╠┬┳╦●○|+.*o';
my %UP   = map { $_ => 1 } split //, '│┃║┼╋╬└╰┗╚┘╯┛╝┤┫╣├┣╠┴┻╩●○|+\'*o';
my $VERT;    # vertical line for the graph style in use, detected below

# Split a line into tokens: [raw text, visible char or '' for escape codes].
sub tokens {
    my @t;
    for (split /($ESC)/, $_[0]) {
        next if $_ eq '';
        if (/^$ESC$/) { push @t, [ $_, '' ] }
        else          { push @t, [ $_, $_ ] for split // }
    }
    return \@t;
}

sub width {
    my $c = shift;
    return 0 if $c eq '' || $c =~ /\p{Mn}/;
    return $c =~ /[\p{East_Asian_Width=Wide}\p{East_Asian_Width=Fullwidth}]/ ? 2 : 1;
}

# Parse a line into its graph cells and its text tokens.
sub parse {
    my $toks = tokens($_[0]);
    my (@cells, $colour);
    my $i = 0;
    while ($i < @$toks) {
        my ($raw, $vis) = @{ $toks->[$i] };
        if ($vis eq '') { $colour = $raw =~ /^\e\[0?m$/ ? undef : $raw; $i++; next }
        last unless $vis =~ /^$GRAPH$/;
        push @cells, [ $vis, $colour ];
        $VERT //= $vis =~ /[┃━╋┗┏┓┛┫┣┻┳]/ ? '┃'
                : $vis =~ /[║═╬╚╔╗╝╣╠╩╦]/ ? '║'
                : $vis =~ /[│─┼└┌┐┘┤├┴┬╰╭╮╯]/ ? '│'
                : $vis =~ /[|\-+'.*o]/ ? '|'
                : undef;
        $i++;
    }
    # Escape codes just before the text belong to the text.
    $i-- while $i > 0 && $toks->[ $i - 1 ][1] eq '' && $toks->[ $i - 1 ][0] !~ /^\e\[0?m$/;
    my @text = @{$toks}[ $i .. $#$toks ];
    return { cells => \@cells, text => \@text };
}

# Graph prefix for continuation lines between rows $a and $b.
sub continuation {
    my ($a, $b) = @_;
    my $out = '';
    for my $j (0 .. $#{ $a->{cells} }) {
        my ($ca, $cola) = @{ $a->{cells}[$j] };
        my ($cb, $colb) = $b && $b->{cells}[$j] ? @{ $b->{cells}[$j] } : (' ', undef);
        if ($DOWN{$ca} && $UP{$cb}) {
            # Current row's colour: a junction below (e.g. ┴) takes the
            # colour of the branch joining from the side
            my $col = $cola // $colb;
            my $v = $VERT // '│';
            $out .= defined $col ? "$col$v\e[0m" : $v;
        }
        else { $out .= ' ' }
    }
    return $out;
}

sub emit {
    my ($row, $next) = @_;
    my $prefix_w = @{ $row->{cells} };
    my $raw_prefix = join '', map { defined $_->[1] && $_->[0] ne ' ' ? "$_->[1]$_->[0]\e[0m" : $_->[0] } @{ $row->{cells} };
    my @text  = @{ $row->{text} };
    my $plain = join '', map { $_->[1] } @text;
    my $avail = $cols - $prefix_w;

    my $indent = $plain =~ /^([0-9a-f]{7,} - \([^)]*\) )/ ? length $1 : 0;
    my $text_w = 0;
    $text_w += width($_->[1]) for @text;

    if ($text_w <= $avail || $avail - $indent < $MIN_TEXT) {
        print $raw_prefix, (join '', map { $_->[0] } @text), "\n";
        return;
    }

    # Group tokens into words and runs of spaces.
    my @groups;    # [is_space, [tokens], width]
    my $author;    # inside the dim "- Author" span from bin/git-graph's format?
    for my $t (@text) {
        $author = $t->[0] eq "\e[2;37m" ? 1 : $t->[0] =~ /^\e\[0?m$/ ? 0 : $author;
        # Escape codes count as part of a word; don't break inside author names
        my $sp = $t->[1] eq ' ' && !$author ? 1 : 0;
        push @groups, [ $sp, [], 0 ] if !@groups || $groups[-1][0] != $sp;
        push @{ $groups[-1][1] }, $t;
        $groups[-1][2] += width($t->[1]);
    }
    # Keep a lone "-" with the word after it ("- Author"), and "->" with the
    # words on both sides ("HEAD -> main")
    my $vis = sub { join '', map { $_->[1] } @{ $_[0][1] } };
    my $join = sub {    # merge groups $k, $k+1 (a space) and $k+2
        my $k = shift;
        push @{ $groups[$k][1] }, map { @{ $_->[1] } } @groups[ $k + 1, $k + 2 ];
        $groups[$k][2] += $groups[ $k + 1 ][2] + $groups[ $k + 2 ][2];
        splice @groups, $k + 1, 2;
    };
    for (my $k = 0; $k + 2 < @groups; $k++) {
        $join->($k--) if !$groups[$k][0] && $vis->($groups[$k]) =~ /^->?$/;
    }
    for (my $k = 0; $k + 2 < @groups; $k++) {
        $join->($k--) if !$groups[$k][0] && $vis->($groups[ $k + 2 ]) =~ /^->/;
    }

    my $cont   = continuation($row, $next);
    my $active = '';    # SGR codes in effect, re-emitted after a wrap
    my $out    = $raw_prefix;
    my $limit  = $avail;
    my $used   = 0;
    my $pending;        # space run waiting to see if the next word fits

    my $newline = sub {
        $out .= "\e[0m\n$cont" . (' ' x $indent) . $active;
        $limit = $avail - $indent;
        $used  = 0;
        undef $pending;
    };
    my $put = sub {
        my $t = shift;
        if ($t->[1] eq '') { $active = $t->[0] =~ /^\e\[0?m$/ ? '' : $active . $t->[0] }
        $out .= $t->[0];
        $used += width($t->[1]);
    };

    for my $g (@groups) {
        my ($sp, $toks, $w) = @$g;
        if ($sp) { $pending = $g; next }
        my $pw = $pending && $used ? $pending->[2] : 0;
        if ($used && $used + $pw + $w > $limit) { $newline->() }
        elsif ($pending && $used) { $put->($_) for @{ $pending->[1] } }
        undef $pending;
        for my $t (@$toks) {    # hard-break words longer than a whole line
            $newline->() if $t->[1] ne '' && $used + width($t->[1]) > $limit && $used;
            $put->($t);
        }
    }
    print $out, "\n";
}

my ($prev, $line);
while ($line = <STDIN>) {
    $line =~ s/\r?\n$//;
    my $row = parse($line);
    emit($prev, $row) if $prev;
    $prev = $row;
}
emit($prev, undef) if $prev;
