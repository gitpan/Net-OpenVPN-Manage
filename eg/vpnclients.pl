#!/usr/bin/perl

use strict;
use warnings;
use Net::OpenVPN::Manage;
use 5.010;

my $vpn = Net::OpenVPN::Manage->new({
        host => shift || 'localhost',
        port => shift || 5000
});

unless ($vpn->connect()) {
    say $vpn->{error_msg};
    exit 2;
}

my $sref = $vpn->status_ref();
my $lref = $vpn->load_stats_ref();

if ( $lref->{nclients} > 0 ) {
    for (my $i = 0; $i < $lref->{nclients}; $i++) {
        printf("%2s %-16s: %-29s\n","",
            ${$sref->{HEADER}{CLIENT_LIST}}[0],
            ${$sref->{CLIENT_LIST}}[$i][0]);
        printf("%2s %-16s: %-29s\n","",
            ${$sref->{HEADER}{CLIENT_LIST}}[2],
            ${$sref->{CLIENT_LIST}}[$i][2]);
        printf("%2s %-16s: %-29s\n","",
            ${$sref->{HEADER}{CLIENT_LIST}}[1],
            ${$sref->{CLIENT_LIST}}[$i][1]);
        printf("%2s %-16s: %-29s\n","",
            ${$sref->{HEADER}{CLIENT_LIST}}[5],
            ${$sref->{CLIENT_LIST}}[$i][5]);
        printf("%2s %-16s: %-29s\n","",
            ${$sref->{HEADER}{ROUTING_TABLE}}[3],
            ${$sref->{ROUTING_TABLE}}[$i][3]);
        print "\n";
    }
}
else {
    print "No clients are currently connected.\n";
    exit 1;
}

