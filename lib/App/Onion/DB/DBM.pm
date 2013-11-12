package App::Onion::DB::DBM;
use strict;
use warnings;
use Mouse;

use DBM::Deep;
use constant {
    IDS_FILE => 'message_list.db',
    DETAIL_FILE => 'message.db',
};

with 'App::Onion::DB';

has ids => (
    is => 'ro',
    isa => 'DBM::Deep',
    default => sub {
        DBM::Deep->new(
            file => IDS_FILE,
            type => DBM::Deep->TYPE_ARRAY,
            autoflush => 1,
        );
    },
);

has detail => (
    is => 'ro',
    isa => 'DBM::Deep',
    default => sub {
        DBM::Deep->new(
            file => DETAIL_FILE,
            type => DBM::Deep->TYPE_HASH,
            autoflush => 1,
        );
    },
);

no Mouse;

use Carp;
use App::Onion::Message;

sub create_message {
    my ($self, $message) = @_;

    croak 'message is required id column' unless defined $message->{id};

    my $message_object = App::Onion::Message->new(%$message);
    push @{$self->ids}, $message_object->id;

    # initialize
    $self->detail->{$message_object->id} = $message_object->to_plain;

sub delete_message {
    my ($self, %args) = @_;

    croak 'not implement yet';
}

sub update_message {
    my ($self, $message) = @_;

    croak 'message is required id column' unless defined $message->{id};

    my $id = delete $message->{id};
    while (my ($key, $value) = each %$message) {
        $self->detail->{$id}->{$key} = $value;
    }

    return $self->find_message($id);
}

sub find_message {
    my ($self, $id) = @_;

    return App::Onion::Message->new(%{$self->detail->{$id}});
}

sub rows {
    my ($self) = @_;

    return scalar(@{$self->ids});
}

sub fetch_id_list {
    my ($self) = @_;

    return \@{$self->ids};
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::DB::DBM -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
