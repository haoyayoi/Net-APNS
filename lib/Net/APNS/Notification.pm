package Net::APNS::Notification;

use Moose;
use Encode qw/encode decode/;
use JSON::XS;
use Net::SSLeay qw/die_now die_if_ssl_error/;

extends 'Net::APNS::Base';

has notify_port => (
    is      => 'ro',
    isa     => 'Int',
    default => 2195,
);

has message => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has badge   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has payload => (
    is      => 'rw',
    isa     => 'Str',
);

has devicetoken => (
    is      => 'rw',
    isa     => 'Str',
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
}

sub message_encode {
    my $self = shift;
    if ($self->message ne '') {
        $self->message(decode('utf8', $self->message));
        $self->message(encode('unicode', $self->message));
    }

}

sub new_payload {
    my $self = shift;
    my $jsonxs = JSON::XS->new->utf8(1)->encode({
        aps => {
            alert => $self->message_encode,
            badge => $self->badge,
        }
    });
    $jsonxs =~ s/("badge":)"([^"]+)"/$1$2/;
    $self->payload(chr(0).pack('n',32).pack('H*',$self->{devicetoken}).pack('n',length($jsonxs)).$jsonxs);
}

sub write_payload {
    my $self = shift;
    $self->port($self->notify_port);
    $self->host($self->notify_host);
    $self->ssl($self->new_ssl);
    Net::SSLeay::set_fd($self->ssl, fileno($self->sock));
    Net::SSLeay::connect($self->ssl) or die_now "Failed to connect SSL $!";
    Net::SSLeay::ssl_write_all($self->ssl, $self->payload) or die_if_ssl_error("ssl write");
    Core::shutdown($self->sock);
    Net::SSLeay::free($self->ssl);
    Net::SSLeay::CTX_free($self->ctx);
    close($self->sock);
}

1;
