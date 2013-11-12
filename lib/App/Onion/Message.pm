package App::Onion::Message;
use strict;
use warnings;
use Mouse;

has raw => (
    is => 'ro',
    isa => 'Str'
);
has id => (
    is => 'ro',
    isa => 'Int',
);
has sender => (
    is => 'ro',
    isa => 'Str',
);
has body => (
    is => 'ro',
    isa => 'Str',
);
has title => (
    is => 'ro',
    isa => 'Str',
);
has send_date => (
    is => 'ro',
    isa => 'Str',
);

no Mouse;

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Message -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
