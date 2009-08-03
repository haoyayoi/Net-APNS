package Net::APNS;

use Moose;
use Net::APNS::Notification;

extends 'Net::APNS::Base';

sub Build {
    my $self = shift;
    $self->loadconf;
}

sub notify {
    my $self = shift;
    return Net::APNS::Notification->new;
}

1;
__END__

=head1 NAME

Net::APNS - Apple Push Notification Service for perl.

=head1 SYNOPSIS

  use Net::APNS;

=head1 DESCRIPTION

Net::APNS is

=head1 AUTHOR

haoyayoi E<lt>st.hao.yayoi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
