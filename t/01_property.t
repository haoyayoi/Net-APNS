use strict;
use warnings;
use Test::More tests => 13;
use Net::SSLeay;
use_ok 'Net::APNS';

my $apns = Net::APNS->new;

is ($apns->cert, 'certs/client-cert.pem');
$apns->cert("certs/cert.pem");
is ($apns->cert, 'certs/cert.pem');

is ($apns->key,  'certs/client-key.pem');
$apns->key("certs/key.pem");
is ($apns->key,  'certs/key.pem');

is ($apns->passwd, undef);
$apns->passwd("test");
is ($apns->passwd, "test");

$apns->sandbox(1);
is ($apns->notify_host, 'gateway.sandbox.push.apple.com');
is ($apns->feedback_host, 'feedback.sandbox.push.apple.com');
$apns->sandbox(0);
is ($apns->notify_host, 'gateway.push.apple.com');
is ($apns->feedback_host, 'feedback.push.apple.com');

is ($apns->conffile, 'APNS_CONF.yaml');
is ($apns->type_pem, &Net::SSLeay::FILETYPE_PEM);
