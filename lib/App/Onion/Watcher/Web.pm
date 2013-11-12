package App::Onion::Watcher::Web;
use strict;
use warnings;
use Mouse;

with 'App::Onion::Watcher::Base';

has mech => (
    is  => 'ro',
    isa => 'App::Onion::Mechanize',
);
has site => (
    is  => 'ro',
    isa => 'URI',
);
has opt => (
    is  => 'ro',
    isa => 'App::Onion::Watcher::Options',
);

no Mouse;

use Carp;
use List::Compare;
use Date::Calc;

use App::Onion::MechanizeFactory;
use App::Onion::Parser;
use App::Onion::Notify::Growl;

sub timer_callback {
    my ($self) = @_;

    my $res = $self->mech->get($self->site->path("list_message.pl"));
    unless ($res) {
        $cv->send("Connection Lost!!");
        return;
    }
    my $parse = App::Onion::Parser->new($res->decoded_content);
    my @new_message_ids = $parse->get_message_ids;

    my @Ronly = calc_new_message_ids(\@{$self->{message_ids}}, \@new_message_ids);

    # 新規メッセージがないなら終了
    return if scalar @Ronly == 0;
    # 以下新規メッセージがある場合の処理

    $self->store_new_messages(@Ronly);

    # notification
    if ($growl_notify) {
        App::Onion::Notify::Growl->call;
    }

    # push notification
    if ($self->opt->notify) {
        for $notifier (@{$self->notifies}) {
            $notifier->call;
        }
    }

    foreach my $id (@Ronly) {
        my ($hour, $min, $sec) = Date::Calc::Now();
        say "--------------------";
        say "New Message!";
        say $hour.":".$min.":".$sec;
        say "--------------------";

        my $url = $self->site->clone;
        $url->path("view_message.pl");
        $url->query_form({
            id => $id,
            box => "inbox",
        });

        {
            my $res = $self->mech->get($url);
            my $decoded_content = $res->decoded_content;
            my $parse = App::Onion::Parser->new($res->decoded_content);
            my ($sender_name, $sender_id) = $parse->get_sender;
            my $message_send_date = $parse->get_send_date;
            my $message_title = $parse->get_title;
            my $message_body = $parse->get_body;
            if (defined $sender_name and defined $sender_id) {
                say "From: $sender_name";
                say "Sender ID: $sender_id";
                say "Title: $message_title";
                say "Body: $message_body";

                $messages_detail->{$id}->{sender} = $sender_id;
                $messages_detail->{$id}->{sender_name} = $sender_id;
                $messages_detail->{$id}->{send_date} = $message_send_date;
                $messages_detail->{$id}->{title} = $message_title;
                $messages_detail->{$id}->{body} = $message_body;
            } else {
                warn "something wrong. unable to get sender name and id";
            }
        }
        say "";
        say "====================";

        # notify to browser when after write message detail
        # because web server using it
        if ($self->message_open) {
            my $view_message_url = $uri_object->as_string;
            say $view_message_url;
            $view_message_url = "http://localhost:$port/message?id=$id" unless $no_web;
            system qq#open "$view_message_url"#;
        }
    }
}

sub calc_new_message_ids {
    my $message_ids = shift;
    my $new_message_ids = shift;

    if (ref $message_ids eq "DBM::Deep::Array") {
        $message_ids = dbm_array_to_array_ref($message_ids);
    }

    my $lc = List::Compare->new($message_ids, $new_message_ids);
    my @Ronly = $lc->get_Ronly;

    return wantarray ? @Ronly : \@Ronly;
}

sub dbm_array_to_array_ref {
    my $dbm_array = shift;

    my @normal_array = @$dbm_array;

    return \@normal_array;
}

sub store_new_messages {
    my ($self) = @_;
    my @new_message_ids = @_;

    # add message list db
    push @{$self->{message_ids}}, @new_message_ids;

    # initialize entry in message detail db
    foreach my $message_id (@new_message_ids) {
        $self->{messages_detail}->{$message_id} = {
            sender => "",
            sender_name => "",
            send_date => "",
            title => "",
            body => "",
            mark => 0,
        };
    }
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Watcher::Web -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
