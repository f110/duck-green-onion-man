package App::Onion::Watcher::Web;
use strict;
use warnings;
use 5.010;
use Mouse;
use Encode;

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
    isa => 'App::Onion::Options',
);
has cv => (
    is => 'ro',
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
        $self->cv->send("Connection Lost!!");
        return;
    }
    my $parser = App::Onion::Parser->build(
        target => "list_message",
        content => $res->decoded_content,
    );
    my @new_message_ids = $parser->get_message_ids;

    my @Ronly = calc_new_message_ids($self->db->fetch_id_list, \@new_message_ids);

    # 新規メッセージがないなら終了
    return if scalar @Ronly == 0;
    # 以下新規メッセージがある場合の処理

    foreach my $id (@Ronly) {
        my ($hour, $min, $sec) = Date::Calc::Now();
        say "--------------------";
        say "New Message!";
        say sprintf("%02d:%02d:%02d", $hour, $min, $sec);
        say "--------------------";

        my $url = $self->site->clone;
        $url->path("view_message.pl");
        $url->query_form({
            box       => "inbox",
            thread_id => $id,
        });

        my $res = $self->mech->get($url);
        my $parser = App::Onion::Parser->build(
            target => "view_message",
            content => $res->decoded_content,
        );
        my $messages = $parser->parse;

        my $message = pop @{$messages->{message}};
        my $sender_name = ($message->{sender} =~ /^\d+/) ? $messages->{member}->{$message->{sender}} : $message->{sender};
        my $sender_id = $message->{sender};
        my $message_id = $message->{id};
        my $message_body = $message->{body};
        my $message_send_date = $message->{timestamp};

        if (defined $sender_name and defined $sender_id and defined $message_id) {
            say "From: ".Encode::encode_utf8($sender_name);
            say "Sender ID: $sender_id";
            say "Body: ".Encode::encode_utf8($message_body);

            $self->db->create_message({
                id          => $message_id,
                sender      => $sender_id,
                sender_name => $sender_name,
                send_date   => $message_send_date,
                body        => $message_body,
            });
        } else {
            warn "something wrong. unable to get sender name and id";
        }
        say "";
        say "="x30;

        # open a browser when after write message detail to db
        # because web server using it
        if ($self->opt->message_open && !$self->opt->no_web) {
            my $view_message_url = sprintf("http://localhost:%d/message?id=%d", $self->opt->port, $id);
            system qq#open "$view_message_url"#;
        }
    }

    # push notification
    if ($self->opt->notify) {
        for my $notifier (@{$self->opt->notifies}) {
            $notifier->call;
        }
    }
}

sub BUILD {
    my ($self) = @_;

    my $res = $self->mech->get($self->site->path("list_message.pl"));
    unless ($res) {
        $self->cv->send("Connection Lost!!");
        return;
    }
    my $parse = App::Onion::Parser->build(
        target => "list_message",
        content => $res->decoded_content,
    );
    my @new_message_ids = $parse->get_message_ids;

    my @Ronly = calc_new_message_ids($self->db->fetch_id_list, \@new_message_ids);
    return if scalar @Ronly < 1;

    #for my $id (@Ronly) {
        #$self->db->create_message({
            #$id => $id,
        #});
    #}
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
