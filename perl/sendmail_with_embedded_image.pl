#!/bin/env perl

use MIME::Lite;

my $msg = MIME::Lite->new(
    From    => 'johndoe@acme.com',
    To      => 'janedoe@acme.com',
    Subject => 'Hello',
    Type    => 'multipart/mixed'
);

$msg->attach(
    Type => 'text/html',
    Data => '<img src="cid:chart.png">'
);

$msg->attach(
    Type        => 'image/png',
    Path        => 'chart.png',
    Filename    => 'chart.png',
    ID          => 'chart.png',
    Disposition => 'attachment'
);

$msg->send;

