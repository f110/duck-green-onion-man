# お手軽認可取得アプリ
use strict;
use warnings;
use 5.010;
use Plack::Request;
use Plack::Response;
use File::Basename;
use OAuth::Lite2::Client::WebServer;
use IO::File;
use IO::Handle;
use Data::Dumper;

my $config_file = dirname(__FILE__)."/config.pl";

my $conf = do $config_file or die;

my $oauth_client = OAuth::Lite2::Client::WebServer->new(
    id => $conf->{consumer_key},
    secret => $conf->{consumer_secret},
    authorize_uri => $conf->{authorize_uri},
    access_token_uri => $conf->{access_token_uri},
);

sub {
    my $req = Plack::Request->new(shift);

    my $res = Plack::Response->new;

    if ($req->param("code")) {
        # get access token
        my $token = $oauth_client->get_access_token(
            code => $req->param("code"),
            redirect_uri => $conf->{redirect_uri},
        );

        my $fh = IO::File->new($conf->{access_token_file}, "w") or die "cannot open file";
        {
            local $Data::Dumper::Purity = 1;
            local $Data::Dumper::Terse = 1;
            $fh->print(Dumper {
                expires_in => $token->{expires_in},
                access_token => $token->{access_token},
                refresh_token => $token->{refresh_token},
            });
        }
        $fh->close;

        $res->status(200);
        $res->headers({
            'Content-Type' => 'text/plain',
        });
        $res->body("got access token!");
    } else {
        # redirect to authorize uri
        $res->redirect(
            $oauth_client->uri_to_redirect(
                redirect_uri => $conf->{redirect_uri},
                scope => $conf->{scope},
            )
        );
    }

    return $res->finalize;
};
