#!/usr/bin/perl

use strict;
use warnings;
use open qw(:std :utf8);
use LWP::Simple;
use YAML::Tiny;
use JSON;
use URI;
use Device::SerialPort::Arduino;
use utf8;

my $access_token = 'YOUR_ACCESS_TOKEN';

my $arduino = Device::SerialPort::Arduino->new(
    port     => "/dev/tty.xxxxx", # set the using serial port on Arduino IDE.
    baudrate => 115200,           # set the bit rate on Arduino.
    databits => 8,
    parity   => "none",
);

my $temperature = $arduino->receive(1);
chomp $temperature;
print "$temperature\n";

# Fetch your News Feed from Facebook
my $resp = graph_api('me/home', { access_token => $access_token });

# Publish a new message to your own wall
graph_api('me/feed', {
  access_token => $access_token,
  message      => "Hello! This post is sent from perl script. Now temperature of my room is $temperature C.",
  method       => 'post'
});

exit 0;

sub graph_api {
  my $uri = new URI('https://graph.facebook.com/' . shift);
  $uri->query_form(shift);
  my $resp = get("$uri");
  return defined $resp ? decode_json($resp) : undef;
}
