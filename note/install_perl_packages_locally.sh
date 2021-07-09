
wget somepackage.tar.gz

tar -xz -f somepackage.tar.gz

cd somepackage

# Makefile.PL

perl -I/path/to/include Makefile.PL PREFIX=/path/to/install

make

make install

# Build.PL

perl -I/path/to/include Build.PL

./Build

./Build install --destdir /path/to/install

# use lib '/path/to/install/share/perl5';
