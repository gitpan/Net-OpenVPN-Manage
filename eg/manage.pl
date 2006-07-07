#!/usr/local/bin/perl

use Net::OpenVPN::Manage;
use strict;

# This is a very simple comand line tool
# using the Net::OpenVPN::Mange modules
# to control an OpenVPN process via it's management interface.

my $vpn = Net::OpenVPN::Manage->new({host=>'10.250.8.2', port=>'1195', password=>'password', timeout=>5});
unless ($vpn->connect()){
  print $vpn->{error_msg}."\n\n";
  exit 0;
}

my $cmd = $ARGV[0];
my $arg = $ARGV[1];
my $return;

# Here is the if block to process the method desired with the argument.
if ( $cmd eq 'auth-retry' ){
  $return = $vpn->auth_retry($arg);
} elsif ( $cmd eq 'echo' ){
  $return = $vpn->echo($arg);
} elsif (($cmd eq 'help')||($cmd eq '')){
  $return = $vpn->help();
} elsif ( $cmd eq 'hold' ){
  $return = $vpn->hold($arg);
} elsif ( $cmd eq 'kill' ){
  $return = $vpn->kill($arg);
} elsif ( $cmd eq 'log' ){
  $return = $vpn->log($arg);
} elsif ( $cmd eq 'mute' ){
  $return = $vpn->mute($arg);
} elsif ( $cmd eq 'signal' ){
  $return = $vpn->signal($arg);
} elsif ( $cmd eq 'state' ){
  $return = $vpn->state($arg);
} elsif ( $cmd eq 'status' ){
  $return = $vpn->status($arg);
} elsif ( $cmd eq 'test' ){
  $return = $vpn->test($arg);
} elsif ( $cmd eq 'verb' ){
  $return = $vpn->verb($arg);
} elsif ( $cmd eq 'version' ){
  $return = $vpn->version();
}

# The Net::OpenVPN::Manage methods return false or '0' on any error.
# Catch the false return, and print the returned error message from the object.
if ($return){
  print $return;
} else {
  print $vpn->{error_msg}."\n\n";
  exit 0;
}