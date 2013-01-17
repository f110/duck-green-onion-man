package App::Onion::IDList;
use strict;
use warnings;
use Net::Google::Spreadsheets;
use Net::Google::Spreadsheets::Worksheet;
use Net::Google::Spreadsheets::Spreadsheet;

sub id_to_team {
    my $class = shift;
    my $conf = shift;
    my $access_token = shift;

    my $token = do $conf->{access_token_file};

    my $api = Net::Google::Spreadsheets->new(
        access_token => $access_token || $token->{access_token},
    );

    my $worksheet = Net::Google::Spreadsheets::Worksheet->new(
        id => $conf->{id_list_worksheet_id},
        spreadsheet => Net::Google::Spreadsheets::Spreadsheet->new(
            id => $conf->{id_list_spreadsheet_id},
        ),
    );

    my @rows;
    eval {
        my @cells = $api->get_cells($worksheet);

        foreach my $cell (@cells) {
            next if $cell->row == 1;
            $rows[($cell->row-2)*2+($cell->col-1)] = $cell->value;
        }
    };
    if ($@) {
        warn $@;
    }

    return @rows;
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::IDList -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
