use inc::Module::Install;
name 'Net-APNS';
all_from 'lib/Net/APNS.pm';

requires 'Moose';
requires 'JSON::XS';
requires 'Net::SSLeay';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
build_requires 'Test::Class';
use_test_base;
auto_include;
WriteAll;
