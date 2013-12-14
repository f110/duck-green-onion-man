package App::Onion::Web;
use strict;
use warnings;
use Sys::Hostname;
use DBM::Deep;
use Mojolicious::Lite;
use Mojo::ByteStream qw/b/;
use URI::Find;
use App::Onion::Scoreboard;
use App::Onion::IDList;
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

my @TEAM = qw(A B C D E F G H I);
my %SENDER_ID_TO_TEAM;

get '/' => sub {
    my $self = shift;

    my @messages;
    foreach my $id (reverse @$message_ids) {
        push @messages, +{
            id => $id,
            %{$messages_detail->{$id}},
            teams => [
                map {
                    +{
                        name => $_,
                        value => $_,
                        selected => _get_team_name_from_sender_id($messages_detail->{$id}->{sender}) eq $_ ? " selected" : "",
                    }
                } @TEAM
            ],
        };
    }

    $self->stash->{questions} = [ map {
        +{
            name => sprintf("Q%d", $_),
            value => $_,
        }
    } 1..10 ];
    $self->stash->{messages} = \@messages;
    $self->render('message_list');
};

get '/message' => sub {
    my $self = shift;

    my $message_id = $self->param('id') || undef;
    return $self->redirect_to("/") if not defined $message_id;

    my $all_info = $messages_detail->{$message_id};

    my $team_name = _get_team_name_from_sender_id($all_info->{sender});
    $self->stash->{id} = $message_id;
    $self->stash->{$_} = $all_info->{$_} || "unknown" for qw/sender sender_name send_date title body/;
    $self->stash->{teams} = [ map {
        +{
            name => $_,
            value => $_,
            selected => $team_name eq $_ ? " selected" : "",
        }
    } @TEAM];
    $self->stash->{questions} = [ map {
        +{
            name => sprintf("Q%d", $_),
            value => $_,
        }
    } 1..10 ];

    $self->stash->{body} = b(url_link($self->stash->{body}));
    return $self->render('message');
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

get '/refresh_list' => sub {
    my $self = shift;

    _refresh_user_list();

    return $self->redirect_to("/");
};

sub to_app {
    my $class = shift;
    $conf = shift;

    _refresh_user_list();

    app->secret(hostname());
    app->start("psgi");
}

sub _get_team_name_from_sender_id {
    my $sender_id = shift;

    return $SENDER_ID_TO_TEAM{$sender_id} || "";
}

sub _refresh_user_list {
    %SENDER_ID_TO_TEAM = App::Onion::IDList->id_to_team($conf);
}

sub url_link {
    my $text = shift;

    my $finder = URI::Find->new(sub {
        my($uri, $orig_uri) = @_;
        return qq|<a href="$uri">$orig_uri</a>|;
    });
    $finder->find(\$text);

    return $text;
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
