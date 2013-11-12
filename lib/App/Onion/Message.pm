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
    default => 0,
);
has sender => (
    is => 'ro',
    isa => 'Str',
    default => '',
);
has sender_name => (
    is => 'ro',
    isa => 'Str',
    default => '',
);
has body => (
    is => 'ro',
    isa => 'Str',
    default => '',
);
has title => (
    is => 'ro',
    isa => 'Str',
    default => '',
);
has send_date => (
    is => 'ro',
    isa => 'Str',
    default => '',
);

no Mouse;

sub to_plain {
    my ($self) = @_;

    return +{
        id          => $self->id,
        sender      => $self->sender,
        sender_name => $self->sender_name,
        body        => $self->body,
        title       => $self->title,
        send_date   => $self->send_date,
    };
}

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
