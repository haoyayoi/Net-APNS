use strict;
use warnings;
use Test::More tests => 1;
use Net::SSLeay;
use_ok 'Net::APNS';

my $apns = Net::APNS->new;
my $notify = $apns->notify;
