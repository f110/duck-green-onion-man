package App::Onion::Web;
use strict;
use warnings;
use Sys::Hostname;
use DBM::Deep;
use Mojolicious::Lite;
use App::Onion::Scoreboard;
use Net::Google::Spreadsheets::Worksheet;
use Net::Google::Spreadsheets::Spreadsheet;
use Data::Dumper;

my $conf = {};

my $messages_detail = DBM::Deep->new(
    file => "message.db",
    type => DBM::Deep->TYPE_HASH,
    autoflush => 1,
);

my $message_ids = DBM::Deep->new(
    file => "message_list.db",
    type => DBM::Deep->TYPE_ARRAY,
    autoflush => 1,
);

get '/' => sub {
    my $self = shift;

    my @messages;
    foreach my $id (reverse @$message_ids) {
        push @messages, $messages_detail->{$id};
    }

    $self->stash->{messages} = \@messages;
    $self->render('message_list');
};

get '/update' => sub {
    my $self = shift;

    my $team = $self->param("team");
    my $question = $self->param("q_number");
    my $point = $self->param("point");

    my $model = App::Onion::Scoreboard->new(
        worksheet => Net::Google::Spreadsheets::Worksheet->new(
            id => $conf->{scoreboard_worksheet_id},
            spreadsheet => Net::Google::Spreadsheets::Spreadsheet->new(
                id => $conf->{scoreboard_spreadsheet_id},
            ),
        ),
        conf => $conf,
    );

    my $result = $model->update_score($team, $question, $point);

    return $self->redirect_to("/");
};

sub to_app {
    my $class = shift;
    $conf = shift;

    app->secret(hostname());
    app->start("psgi");
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Web -

=head1 DESCRIPTION

=head1 SYNOPSIS

    use Plack::Builder;
    use Plack::Loader;

    my $app = builder {
        App::Onion::Web->to_app;
    };

    my $loader = Plack::Loader->load(
        'Starlet',
        port => 8000,
        host => 0,
        max_workers => 1,
    );
    $loader->run($app);

=head1 DEPENDENCIES

=head1 METHOD

=head2 to_app

returning psgi application(CODEREF)

Mojolicious::Lite

=cut
