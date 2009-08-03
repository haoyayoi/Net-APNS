package Net::APNS::Feedback;

use Moose;

has port => (
    is      => 'ro',
    isa     => 'Int',
    default => 2196,
);

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
