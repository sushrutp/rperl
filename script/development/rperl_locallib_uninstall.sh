#!/bin/bash

cd ~/perl5/lib/perl5
rm -Rf RPerl* rperl* *rperl
cd ~/perl5/bin
rm -f rperl*
cd ~/perl5/man/man1
rm -f rperl*
cd ~/perl5/man/man3
rm -f RPerl*

cd ~/perl5/lib/perl5/x86_64-linux-gnu-thread-multi/auto
rm -Rf RPerl*
cd ~/perl5/lib/perl5/x86_64-linux-gnu-thread-multi/.meta/
rm -Rf RPerl*

cd ~/perl5/lib/perl5/x86_64-linux/auto
rm -Rf RPerl*
cd ~/perl5/lib/perl5/x86_64-linux/.meta/
rm -Rf RPerl*


