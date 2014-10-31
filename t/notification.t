use strict;
use warnings;

Test::Class->runtests;

package Test::Notification;
use base qw(Test::Class);
use Test::More;
use Test::Moose;
use Test::Mouse;
use Net::APNS::Notification;
use Net::SSLeay;

sub test_init_notificaion : Test(setup) {
    my $self = shift;
    $self->{notify} = Net::APNS::Notification->new(
         cert   => "cert.pem",
         key    => "key.pem",
         passwd => "passwd",
         devicetoken => "xxxxxxxx xxxx xxxx xxxx xxxxxxxx",
    );
}

sub notify_attribute : Tests(10) {
    my $Notify = shift->{notify};
    has_attribute_ok ($Notify, "port", "notifyport");
    has_attribute_ok ($Notify, "message", "message");
    has_attribute_ok ($Notify, "badge", "badge");
    has_attribute_ok ($Notify, "sound", "sound");
    has_attribute_ok ($Notify, "custom", "custom");
    has_attribute_ok ($Notify, "devicetoken", "devicetoken");
    has_attribute_ok ($Notify, "sandbox", "sandbox");
    has_attribute_ok ($Notify, "passwd", "passwd");
    has_attribute_ok ($Notify, 'ssl_version', 'ssl_version');
    has_attribute_ok ($Notify, 'ssl_trace_level', 'ssl_trace_level');
}

sub default_value : Tests(8) {
    my $notify = shift->{notify};
    is ($notify->type_pem, &Net::SSLeay::FILETYPE_PEM);
    is ($notify->message, '');
    is ($notify->badge, 0);
    is ($notify->sound, '');
    ok (scalar keys %{$notify->custom} == 0);
    is ($notify->sandbox, 0);
    is ($notify->ssl_version, 10);
    is ($notify->ssl_trace_level, 4);
}

1;
