{
    login_mail => '',
    login_password => '',
    im_kayac_username => '',
    notifo_username => '',
    notifo_apisecret => '',
    hosts => {
        "localhost" => "127.0.0.1",
    },
    consumer_key => '',
    consumer_secret => '',
    authorize_uri => 'https://accounts.google.com/o/oauth2/auth',
    access_token_uri => 'https://accounts.google.com/o/oauth2/token',
    scope => 'https://spreadsheets.google.com/feeds https://docs.google.com/feeds',
    redirect_uri => 'http://localhost:5000',
    access_token_file => './access_token.pl',
}
