package Net::APNS;

use Any::Moose;
use Net::APNS::Notification;
our $VERSION = '0.02';

sub notify {
    my ( $self, $args ) = @_;
    return Net::APNS::Notification->new(
        cert   => $args->{cert},
        key    => $args->{key},
        passwd => $args->{passwd},
    );
}

__PACKAGE__->meta->make_immutable;
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

=head1 METHOD

=over 2

=item notify()

Return push client. Need specify parameters.

=back

=head2 PARAMETERS

=over 4

=item Cert

Server certification file. 

=item Key

Server certification key file.

=item passwd

certification password. (option)

=back

=head2 PUSH

Payload contains message, badge and more.

  $APNS->devicetoken($devicetoken);
  $APNS->write({
      sandbox => $sandbox,
      message => $message,
      badge   => $badge,
  });

or

  $APNS->devicetoken($devicetoken);
  $APNS->sandbox($sandbox);
  $APNS->message($message);
  $APNS->badge($badge);
  $APNS->write;

=head1 AUTHOR

haoyayoi E<lt>st.hao.yayoi@gmail.comE<gt>

=head1 SEE ALSO

L<Net::APNS::Notification>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
