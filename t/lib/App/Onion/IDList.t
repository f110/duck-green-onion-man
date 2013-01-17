use strict;
use warnings;
use Test::More;
use OAuth::Lite2::Client::WebServer;

BEGIN {
    use_ok "App::Onion::IDList";
}

my $conf = do './config.pl';
my $tokens = do "./access_token.pl";

my $oauth_client = OAuth::Lite2::Client::WebServer->new(
    id => $conf->{consumer_key},
    secret => $conf->{consumer_secret},
    authorize_uri => $conf->{authorize_uri},
    access_token_uri => $conf->{access_token_uri},
);

my $new_token = $oauth_client->refresh_access_token(refresh_token => $tokens->{refresh_token});
my $access_token = $new_token->{access_token};

subtest 'id_to_team' => sub {
    my %id_to_team;
    $conf->{id_list_worksheet_id} = 'od6';
    $conf->{id_list_spreadsheet_id} = 'tn5EhEG3jRKknegUIsf0Epg';
    %id_to_team = App::Onion::IDList->id_to_team($conf, $access_token);

    is_deeply \%id_to_team, +{
        123 => 'A',
        124 => 'A',
        125 => 'A',
        126 => 'B',
        127 => 'B',
        128 => 'B',
        129 => 'C',
        130 => 'D',
    };
};
done_testing;
