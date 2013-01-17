package App::Onion::Scoreboard;
use Mouse;
use 5.010;

has worksheet => (
    is => 'ro',
    isa => 'Net::Google::Spreadsheets::Worksheet',
    required => 1,
);
has conf => (
    is => 'ro',
    isa => 'HashRef',
    required => 1,
);

__PACKAGE__->meta->make_immutable;
no Mouse;

use Net::Google::Spreadsheets;
use OAuth::Lite2::Client::WebServer;
use IO::File;
use IO::Handle;
use Data::Dumper;

sub update_score {
    my $self = shift;
    my $team = shift;
    my $question = shift;
    my $point = shift;
    my $count = shift || 0;

    my $token = do $self->conf->{access_token_file};

    my $api = Net::Google::Spreadsheets->new(
        access_token => $token->{access_token},
    );

    eval {
        my @cells = $api->get_cells($self->worksheet);

        my ($row, $col);
        foreach my $cell (@cells) {
            $row = $cell->row if ($cell->col == 1 and $cell->value eq $team);
            $col = $cell->col if ($cell->row == 1 and $cell->value eq $question);
            last if defined $row and defined $col;
        }

        foreach my $cell (@cells) {
            if ($cell->col == $col and $cell->row == $row) {
                $cell->set_value($point);
                $api->update($cell);
                last;
            }
        }
    };
    if ($@) {
        warn $@;
        given ($@) {
            when (/Invalid token/) {
                $self->token_refresh;
            }
        }
        if ($count < 1) {
            return $self->update_score($team, $question, $point, $count+1);
        }

        return -1;
    }

    return 1;
}

sub token_refresh {
    my $self = shift;

    my $token = do $self->conf->{access_token_file};

    my $oauth_client = OAuth::Lite2::Client::WebServer->new(
        id => $self->conf->{consumer_key},
        secret => $self->conf->{consumer_secret},
        authorize_uri => $self->conf->{authorize_uri},
        access_token_uri => $self->conf->{access_token_uri},
    );

    my $new_token = $oauth_client->refresh_access_token(refresh_token => $token->{refresh_token});

    my $fh = IO::File->new($self->conf->{access_token_file}, "w") or die "cannot open file";
    {
        local $Data::Dumper::Purity = 1;
        local $Data::Dumper::Terse = 1;
        warn $new_token->{access_token};
        $fh->print(Dumper {
            expires_in => $token->{expires_in},
            access_token => $new_token->{access_token},
            refresh_token => $token->{refresh_token},
        });
    }
    $fh->close;
}

1;
__END__
=pod

=encoding utf-8

=head1 NAME

App::Onion::Scoreboard -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHOD

=head1 AUTHOR

=cut
