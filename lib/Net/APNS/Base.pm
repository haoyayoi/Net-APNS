package Net::APNS::Base;

use Moose;
use Net::SSLeay qw/die_now die_if_ssl_error/;
use YAML::Syck;
use Socket;

has cert => (
    is      => 'rw',
    isa     => 'Str',
    default => 'certs/client-cert.pem',
);

has key => (
    is      => 'rw',
    isa     => 'Str',
    default => 'certs/client-key.pem',
);

has passwd => (
    is      => 'rw',
    isa     => 'Str',
);

has sandbox => (
    is      => 'rw',
    isa     => 'Int',
    default => 1,
);

has type_pem => (
    is      => 'ro',
    default => &Net::SSLeay::FILETYPE_PEM,
);

has conf => (
    is      => 'ro',
    isa     => 'Str',
    default => 'APNS_CONF.yaml',
);

has sock => (
    is      => 'rw',
);

has apple_serv_params => (
    is      => 'rw',
);

has host => (
    is      => 'rw',
    isa     => 'Str',
);

has port => (
    is      => 'rw',
    isa     => 'Int',
);

has ctx => (
    is      => 'rw',
);

has ssl => (
    is      => 'rw',
);

sub new_sock {
    my $self = shift;
    my $packed_apple_host = inet_aton($self->host)
         or die "Cannot pack $self->host: $!";
    $self->apple_serv_params(sockaddr_in($self->port, $packed_apple_host))
         or die "Cannot pack $self->host:$self->port: $!";
    socket ($self->socket, PF_INET, SOCK_STREAM, getprotobyname('tcp')) or die "socket: $!";
    connect($self->socket, $self->apple_serv_params) or die "Connect: $!";
}

sub new_ctx {
    my $self = shift;

    $self->loadconf;

    Net::SSLeay::load_error_strings();
    Net::SSLeay::SSLeay_add_ssl_algorithms();
    Net::SSLeay::randomize();

    my $ctx = Net::SSLeay::CTX_new() or die_now("Failed to create SSL_CTX $!.");
    Net::SSLeay::CTX_set_options($ctx, &Net::SSLeay::OP_ALL);
    die_if_ssl_error("ssl ctx set options");
    Net::SSLeay::CTX_set_default_passwd_cb($ctx, sub { $self->passwd });
    Net::SSLeay::CTX_use_RSAPrivateKey_file($ctx, $self->key, $self->type_pem);
    die_if_ssl_error("private key");
    Net::SSLeay::CTX_use_certificate_file ($ctx, $self->cert, $self->type_pem);
    die_if_ssl_error("certificate");

    return $ctx;
}

sub new_ssl {
    my $self = shift;
    return Net::SSLeay::new($self->ctx);
}

sub loadconf {
    my $self = shift;
    if ( -e $self->conf) {
        my $load = LoadFile($self->conf);
        if ($load->{cert}) { $self->conf($load->{cert}); }
        if ($load->{key}) { $self->key($load->{key}); }
        if ($load->{passwd}) { $self->passwd($load->{passwd}); } 
    }
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;
