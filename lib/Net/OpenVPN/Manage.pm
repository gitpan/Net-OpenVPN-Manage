package Net::OpenVPN::Manage;

use strict;
use Net::Telnet;
use vars qw( $VERSION );

$VERSION = '0.01';

sub new {
#Net::OpenVPN::Manage->new({ 
#                    host => 'hostname.domain.com', 
#                    port => '7000' 
#                    password => 'password',
#                    timeout => 20
#                 });

  my $class = shift;
  my $self  = shift;

  # Check if required arguments were passed.
  if (! ( $self->{'host'} && $self->{'port'} )){
  	return 0;
  }
  
  bless ($self, $class);
  return ($self);
}

sub auth_retry {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  $telnet->cmd(String => 'auth-retry '.$arg,  Prompt => '/(SUCCESS:.*\n|ERROR:.*\n)/');
  unless ($telnet->last_prompt =~ /SUCCESS:.*/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  return $telnet->last_prompt();
}

sub echo {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  my @output = $telnet->cmd(String => 'echo '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n|END.*\n)/');
  unless ($telnet->last_prompt =~ /(SUCCESS:.*|END.*\n)/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  if ($telnet->last_prompt =~ /END.*\n/){
    return join('', @output);
  } else {
    return $telnet->last_prompt();
  }
}

sub help {
  my $self = shift;
  my $telnet = $self->{objects}{_telnet_};  
  my @output = $telnet->cmd(String => 'help', Prompt => '/(END.*\n|ERROR:.*\n)/');
  unless ($telnet->last_prompt =~ /END.*\n/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  return join('', @output);
}

sub hold {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  $telnet->cmd(String => 'hold '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n)/');
  unless ($telnet->last_prompt =~ /SUCCESS:.*/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  return $telnet->last_prompt();
}

sub kill {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  $telnet->cmd(String => 'kill '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n)/');
  unless ($telnet->last_prompt =~ /SUCCESS:.*/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  return $telnet->last_prompt();
}

sub log {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  my @output = $telnet->cmd(String => 'log '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n|END.*\n)/');
  unless ($telnet->last_prompt =~ /(SUCCESS:.*|END.*\n)/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  if ($telnet->last_prompt =~ /END.*\n/){
    return join('', @output);
  } else {
    return $telnet->last_prompt();
  }
}

sub mute {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  $telnet->cmd(String => 'mute '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n)/');
  unless ($telnet->last_prompt =~ /SUCCESS:.*/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  return $telnet->last_prompt();
}

sub password {
  return "password: command not implemented.\n";
}

sub signal {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  $telnet->cmd(String => 'signal '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n)/');
  unless ($telnet->last_prompt =~ /SUCCESS:.*/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  return $telnet->last_prompt();
}

sub state {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  my @output = $telnet->cmd(String => 'state '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n|END.*\n)/');
  unless ($telnet->last_prompt =~ /(SUCCESS:.*|END.*\n)/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  if ($telnet->last_prompt =~ /END.*\n/){
    return join('', @output);
  } else {
    return $telnet->last_prompt();
  }
}

sub status {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  my @output = $telnet->cmd(String => 'status '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n|END.*\n)/');
  unless ($telnet->last_prompt =~ /(SUCCESS:.*|END.*\n)/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  if ($telnet->last_prompt =~ /END.*\n/){
    return join('', @output);
  } else {
    return $telnet->last_prompt();
  }
}

sub test {
  return "test: command not implemented.\n";
}

sub username {
  return "username: command not implemented.\n";
}

sub verb {
  my $self = shift;
  my $arg  = shift;
  my $telnet = $self->{objects}{_telnet_};
  $telnet->cmd(String => 'verb '.$arg, Prompt => '/(SUCCESS:.*\n|ERROR:.*\n)/');
  unless ($telnet->last_prompt =~ /SUCCESS:.*/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  return $telnet->last_prompt();
}

sub version {
  my $self = shift;
  my $telnet = $self->{objects}{_telnet_};
  my @output = $telnet->cmd(String => 'version', Prompt => '/(END.*\n|ERROR:.*\n)/');
  unless ($telnet->last_prompt =~ /END.*/){
    $self->{error_msg} = $telnet->last_prompt();
    return 0;
  }
  return join('', @output);
}

sub connect {
  my $self = shift;
  my $telnet = Net::Telnet->new(Telnetmode => 0);
  
  # Set non-default timeout if one was specified when the object was created.
  if ( $self->{timeout} ){ $telnet->timeout($self->{timeout}); }
  
  # Set errormode to return so any timeout events don't die our script.
  $telnet->errmode('return');
  
  # Verify successful connection else error.
  unless ($telnet->open(Host => $self->{host}, Port => $self->{port})){
    $self->{error_msg} = 'Connection failed, verify host name/port and connectivity.';
    return 0;
  }
  
  # If a password was given, login to interface.
  if ( $self->{password} ){
    print $telnet->cmd(String => $self->{password}, Prompt => '/ENTER PASSWORD:/');
    unless ($telnet->last_prompt() =~ /ENTER PASSWORD/){
      $self->{error_msg} = 'Login failed, verify password and that management interface is not in use.';
      return 0;
    } else {
      # Remove extra lines returned from login that we don't want in later output.
      $telnet->getline();
      $telnet->getline();
    }
  }
  
  # If no password used verify connection using command.
  else {
    # Test if valid session by issuing the 'verb' command and checking response.
    # not a great way to validate, but it will work.
    $telnet->cmd(String => 'verb', Prompt => '/(SUCCESS:.*\n|ENTER PASSWORD:)/');
    unless ($telnet->last_prompt =~ /SUCCESS/){
      $self->{error_msg} = 'Invalid response from host, is a password expected, or the management interface in use?';
      return 0;
    }
  }
  
  $self->{objects}{_telnet_} = $telnet;
  return 1;
}

1;

__END__

=head1 NAME

Net::OpenVPN::Manage - Manage an OpenVPN process via it's management port

=head1 SYNOPSIS

  use Net::OpenVPN::Manage;

  my $vpn = Net::OpenVPN::Manage->new({ 
  		host=>'127.0.0.1', 
  		port=>'6000', 
  		password=>'password',
  		timeout=>10
  });
  
  # Error if unable to connect.
  unless($vpn->connect()){
    print $vpn->{error_msg}."\n";
    exit 0;
  }
  
  # Get the current status table in version 2 format from the process.
  my $status = $vpn->status(2);
  
  # If method returned false, print error message.
  # Otherwise print table to STDOUT.
  if ( ! $status ) {
    print $vpn->{error_msg};
    exit 0;
  } else {
    print $status."\n";
  }

=head1 DESCRIPTION

This module connects to the OpenVPN management interface, executes 
commands on the interface and returns the results or errors that result.

=head1 USING THE MODULE

All the methods in this module will return 0, or boolean false if there is any error.
In most cases an error message detailing the problem will be returned in $obj->{error_msg}.

=head1 METHODS

=over 4

=item $vpn = Net::OpenVPN::Manage->new({ host=>'', port=>'', password=>'', timeout=>20 });

Constructs a new Net::OpenVPN::Manage object to connect to the specified process's management interface.
The anonymous hash that is passed specifies the target hostname or IP address, TCP port, and an optional password.
If no password is configured for your OpenVPN process, just omit the password reference. Optionally, you can
change the network timeout value as well.

=item $vpn->connect();

The connect method has no arguments passed to it. This method connects to the remote host at the port specified, 
in the event that the host or port provided to the object are incorrect; or if there is already another network
session to this port (OpenVPN only supports a single management session at a time) this command will timeout.

For more extensive information on the use of the OpenVPN management commands referenced by these methods, see the
OpenVPN documentation (http://www.openvpn.net) or at least the management help screen (print $vpn->help();).


=item $vpn->auth_retry( $arg );

Changes the Auth failure retry mode. Arguments are: none, interact, or nointeract.

$vpn->auth_retry('none'); # Sets auth-retry mode to 'none'


=item $vpn->echo( $arg );

Returns messages from the echo buffer or changes echo state. Arguments are: on, off, all, or a integer designating number of lines to be returned.
The on and off arguments are really of no use here since it changes the state of the realtime management console echo messages and our session only connected for a brief time.

$vpn->echo('all'); # Returns entire echo buffer

=item $vpn->help();

Returns the help screen for the management command usage.

print $vpn->help(); # Prints the help screen to STDOUT

=item $vpn->hold( $arg );

If called without an argument it returns the current hold state; if called with an argument of: on, off, or release it changes the current hold state.

$vpn->hold('release'); # Releases the hold state on the OpenVPN process.

=item $vpn->kill( $arg );

Kills the VPN connection referenced. The argument may be either the common name of the connection or the real client IP:Port address.

$vpn->kill('jsmith'); # kills the connection with the common name of 'jsmith'

$vpn->kill('63.73.83.93:17023'); # kills the connection where the client is connecting from: '63.73.83.93:17023'

=item $vpn->log( $arg );

Returns messages from the log buffer or changes realtime log state. Arguments are: on, off, all, or an integer designating number of lines to be returned.
The on and off arguments are really of no use here since it changes the state of the realtime management console log messages and our session only connected for a brief time.

print $vpn->log('all'); # prints the entire log buffer.

=item $vpn->mute( $arg );

If no argument is given it will show the log mute level for recurring log messages; if called with an argument it will change the log mute level to the value given.

$vpn->mute( 10 ); # Sets the log mute level to 10.

=item $vpn->net();

This method has not been implemented. Only applicable on the Windows platform.

=item $vpn->password();

This method has not been implemented. Only of use when the management session is continuous - ours is not.

=item $vpn->signal( $arg );

Sends a signal to the OpenVPN daemon process. Arugments are: SIGHUP, SIGTERM, SIGUSR1, or SIGUSR2.
If the daemon is running under a non root or Administrator|System account it will not be able to restart
itself after a reset since it won't have the priveledges required to reopen the network interfaces.
See the OpenVPN HOWTO and the OpenVPN Management Interface documentation.

$vpn->signal('SIGHUP'); # Sends SIGHUP signal to the process.

=item $vpn->status( $arg );

Returns the active connection status information where the optional argument (either 1 or 2 at this time) specifies the output format version.

print $vpn->status(2); # Print the connection status page using the version 2 format.

=item $vpn->test();

This method is not implemented. No real need to test management console.

=item $vpn->username();

This method has not been implemented. Only of use when the management session is continuous - ours is not.

=item $vpn->verb( $arg );

If called without an argument it returns the log verbosity level; if called with an argument (any valid log level) it changes the verbosity setting to the given value.

$vpn->verb('1'); # Change verbosity level to 1.

=item $vpn->version();

Returns a string showing the processes version information as well as the management interface's version.

print $vpn->version(); # Prints the version information to STDOUT.

=back

=head1 VERSION

0.01

=head1 AUTHOR

Copyright (c) 2006 Aaron Meyer / MeyerTech.net

This module is free software; you can redistribute it or modify it under
the same terms as Perl itself.

=cut