package App::Onion::Parser;
use strict;
use warnings;
use Class::Load qw(load_class);
use Carp;
use Try::Tiny;

sub build {
    my ($class, %opt) = @_;

    croak 'target is required' unless defined $opt{target};
    my $target = $opt{target};
    $target =~ s/_(.)/\u$1/g;
    my $target_class = __PACKAGE__."::".ucfirst($target);

    try {
        load_class($target_class);
    } catch {
        croak 'target is not found';
    };

    return $target_class->new(content => $opt{content});
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Parser -

=head1 SYNOPSIS

=cut
