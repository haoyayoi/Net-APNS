package Net::APNS;

use Moose;
use Net::APNS::Notification;
our $VERSION = '0.0101';

sub notify {
    my ($self, $args) = @_;
    return Net::APNS::Notification->new(
        cert        => $args->{cert},
        key         => $args->{key},
        passwd      => $args->{passwd},
    );
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;
__END__

=head1 NAME

Net::APNS - Apple Push Notification Service for perl.

=head1 SYNOPSIS

  use Net::APNS;
  my $APNS = Net::APNS->new;
  my $Notifier = $APNS->notify({
      cert   => "cert.pem",
      key    => "key.pem",
      passwd => "pass"
  });
  $Notifier->devicetoken("....");
  $Notifier->message("message");
  $Notifier->badge(4);
  $Notifier->write;
=head1 DESCRIPTION

Net::APNS is Apple Push Notification Service.
Push message to iPhone and get unavalble-devicetoken.

=head1 AUTHOR

haoyayoi E<lt>st.hao.yayoi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
