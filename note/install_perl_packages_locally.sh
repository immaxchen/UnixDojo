
wget somepackage.tar.gz

tar -xz -f somepackage.tar.gz

cd somepackage

perl -I/path/to/include Makefile.PL PREFIX=/path/to/install

make

make install

# use lib '/path/to/install/share/perl5';

