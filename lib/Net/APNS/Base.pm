package Net::APNS::Base;

use Moose;
use Net::SSLeay;

has 'cert' => (
    is      => 'rw',
    isa     => 'Str',
    default => 'certs/client-cert.pem',
);

has 'key' => (
    is      => 'rw',
    isa     => 'Str',
    default => 'certs/client-key.pem',
);

has 'passwd' => (
    is      => 'rw',
    isa     => 'Str',
);

has 'sandbox' => (
    is      => 'rw',
    isa     => 'Int',
    default => 1,
);

sub notify_host {
    my $self = shift;
    my $host;
    if ($self->sandbox) {
        $host = 'gateway.sandbox.push.apple.com';
    } else {
        $host = 'gateway.push.apple.com';
    }
    return $host;
};

sub feedback_host {
    my $self = shift;
    my $host;
    if ($self->sandbox) {
        $host = 'feedback.sandbox.push.apple.com';
    } else {
        $host = 'feedback.push.apple.com';
    }
    return $host;
}

1;
