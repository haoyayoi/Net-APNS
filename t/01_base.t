use strict;
use warnings;
use Test::More tests => 15;
use Net::SSLeay;
use_ok 'Net::APNS';

my $apns = Net::APNS->new;
$apns->loadconf;
is ($apns->cert, 'certs/client-cert.pem');
$apns->cert("certs/cert.pem");
is ($apns->cert, 'certs/cert.pem');

is ($apns->key,  'certs/client-key.pem');
$apns->key("certs/key.pem");
is ($apns->key,  'certs/key.pem');

is ($apns->passwd, undef);
$apns->passwd("test");
is ($apns->passwd, "test");

is ($apns->conf, 'APNS_CONF.yaml');
is ($apns->type_pem, &Net::SSLeay::FILETYPE_PEM);
is ($apns->sock, undef);
is ($apns->apple_serv_params, undef);
is ($apns->host, undef);
is ($apns->port, undef);
is ($apns->ctx, undef);
is ($apns->ssl, undef);
