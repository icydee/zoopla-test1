#!/usr/bin/perl

use lib '/home/icydee/zoopla-server/lib';
use Log::Log4perl;

use Zoopla::App::Match;

Log::Log4perl->init('/home/icydee/zoopla-server/etc/log4perl.conf');

my $app = Zoopla::App::Match->new_with_options();

$app->run;

