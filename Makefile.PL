use inc::Module::Install;
name 'Net-APNS';
all_from 'lib/Net/APNS.pm';

requires 'Any::Moose' => '0.10';
requires 'JSON::XS' => '2.25';
requires 'Net::SSLeay' => '1.35';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
build_requires 'Test::Class';
build_requires 'Test::Moose';
use_test_base;
auto_include;
WriteAll;
