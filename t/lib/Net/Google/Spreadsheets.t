use strict;
use warnings;
use Test::More;
use OAuth::Lite2::Client::WebServer;
use Data::Dumper;
use Net::Google::Spreadsheets::Spreadsheet;
use Net::Google::Spreadsheets::Worksheet;
use Net::Google::Spreadsheets::Row;
use Net::Google::Spreadsheets::Cell;
use Net::Google::Spreadsheets::Request;

BEGIN {
    use_ok "Net::Google::Spreadsheets";
}

my $conf = do "./config.pl";
my $tokens = do "./access_token.pl";

my $oauth_client = OAuth::Lite2::Client::WebServer->new(
    id => $conf->{consumer_key},
    secret => $conf->{consumer_secret},
    authorize_uri => $conf->{authorize_uri},
    access_token_uri => $conf->{access_token_uri},
);

my $new_token = $oauth_client->refresh_access_token(refresh_token => $tokens->{refresh_token});
my $access_token = $new_token->{access_token};

subtest 'Retrieving a list of spreadsheets' => sub {
    my $spreadsheets = Net::Google::Spreadsheets->new(
        access_token => $access_token,
    );

    my @spreadsheet_list = $spreadsheets->get_list;
    warn Data::Dumper::Dumper \@spreadsheet_list;

    ok 1;
};

#subtest 'Retrieving infomation about worksheets' => sub {
    #my $api = Net::Google::Spreadsheets->new(
        #access_token => $access_token,
    #);

    #my $spreadsheet = Net::Google::Spreadsheets::Spreadsheet->new(
        #id => 'tWT6PD7zbSodzA_zA4np8sg',
    #);

    #my @worksheets = $api->get_worksheets($spreadsheet);
    #warn Data::Dumper::Dumper \@worksheets;

    #ok 1;
#};

#subtest 'Retrieving a list based feed' => sub {
    #my $api = Net::Google::Spreadsheets->new(
        #access_token => $access_token,
    #);

    #my $spreadsheet = Net::Google::Spreadsheets::Spreadsheet->new(
        #id => 'tn5EhEG3jRKknegUIsf0Epg',
    #);
    #my $worksheet = Net::Google::Spreadsheets::Worksheet->new(
        #id => 'od6',
        #spreadsheet => $spreadsheet,
    #);

    #my @rows = $api->get_rows($worksheet);
    #warn Data::Dumper::Dumper \@rows;

    #is ref $rows[0], "Net::Google::Spreadsheets::Row";
    #ok 1;
#};

#subtest 'Retrieving a cell based feed' => sub {
    #my $api = Net::Google::Spreadsheets->new(
        #access_token => $access_token,
    #);

    #my $spreadsheet = Net::Google::Spreadsheets::Spreadsheet->new(
        #id => 'tn5EhEG3jRKknegUIsf0Epg',
    #);
    #my $worksheet = Net::Google::Spreadsheets::Worksheet->new(
        #id => 'od6',
        #spreadsheet => $spreadsheet,
    #);

    #my @cells = $api->get_cells($worksheet);
    #warn Data::Dumper::Dumper \@cells;

    #is ref $cells[0], "Net::Google::Spreadsheets::Cell";
    #ok 1;
#};

#subtest 'Retrieving specific row' => sub {
    #my $api = Net::Google::Spreadsheets->new(
        #access_token => $access_token,
    #);

    #my $spreadsheet = Net::Google::Spreadsheets::Spreadsheet->new(
        #id => 'tn5EhEG3jRKknegUIsf0Epg',
    #);
    #my $worksheet = Net::Google::Spreadsheets::Worksheet->new(
        #id => 'od6',
        #spreadsheet => $spreadsheet,
    #);
    #my $row = Net::Google::Spreadsheets::Row->new(
        #id => 'cn6ca',
        #worksheet => $worksheet,
    #);

    #my $new_row = $api->get_row($row);

    #is ref $row, "Net::Google::Spreadsheets::Row";
    #is_deeply $new_row, $row;
    #ok 1;
#};

#subtest 'Retrieving specific cell' => sub {
    #my $api = Net::Google::Spreadsheets->new(
        #access_token => $access_token,
    #);

    #my $spreadsheet = Net::Google::Spreadsheets::Spreadsheet->new(
        #id => 'tn5EhEG3jRKknegUIsf0Epg',
    #);
    #my $worksheet = Net::Google::Spreadsheets::Worksheet->new(
        #id => 'od6',
        #spreadsheet => $spreadsheet,
    #);
    #my $cell = Net::Google::Spreadsheets::Cell->new(
        #worksheet => $worksheet,
        #row => 1,
        #col => 1,
    #);

    #my $new_cell = $api->get_cell($cell);

    #is ref $new_cell, "Net::Google::Spreadsheets::Cell";
    #is_deeply $new_cell, $cell;
    #ok 1;
#};

#subtest 'Updating a list row' => sub {
    #my $api = Net::Google::Spreadsheets->new(
        #access_token => $access_token,
    #);

    #my $spreadsheet = Net::Google::Spreadsheets::Spreadsheet->new(
        #id => 'tn5EhEG3jRKknegUIsf0Epg',
    #);
    #my $worksheet = Net::Google::Spreadsheets::Worksheet->new(
        #id => 'od6',
        #spreadsheet => $spreadsheet,
    #);
    #my $row = Net::Google::Spreadsheets::Row->new(
        #id => 'cn6ca',
        #worksheet => $worksheet,
    #);

    #$api->get_row($row);
    #$row->set_value("blank", "yes!");

    #$api->update($row);
    #ok 1;
#};

#subtest 'Changing contents of a cell' => sub {
    #my $api = Net::Google::Spreadsheets->new(
        #access_token => $access_token,
    #);

    #my $worksheet = Net::Google::Spreadsheets::Worksheet->new(
        #id => 'od6',
        #spreadsheet => Net::Google::Spreadsheets::Spreadsheet->new(
            #id => 'tn5EhEG3jRKknegUIsf0Epg',
        #),
    #);
    #my $cell = Net::Google::Spreadsheets::Cell->new(
        #id => 'R2C4',
        #worksheet => $worksheet,
    #);
    #$api->get_cell($cell);
    #$cell->set_value("NO!");

    #$api->update($cell);

    #ok 1;
#};

#subtest 'Create a new cell' => sub {
    #my $api = Net::Google::Spreadsheets->new(
        #access_token => $access_token,
    #);

    #my $worksheet = Net::Google::Spreadsheets::Worksheet->new(
        #id => 'od6',
        #spreadsheet => Net::Google::Spreadsheets::Spreadsheet->new(
            #id => 'tn5EhEG3jRKknegUIsf0Epg',
        #),
    #);
    #my $cell = Net::Google::Spreadsheets::Cell->new(
        #row => 9,
        #col => 4,
        #worksheet => $worksheet,
    #);
    #$cell->value("hoge");

    #$api->add($cell);

    #ok 1;
#};

done_testing;
