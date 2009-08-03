use inc::Module::Install;
name 'Net-APNS';
all_from 'lib/Net/APNS.pm';

requires 'Moose';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
