# Install dependencies
pkg update -y
pkg install wget tar gzip nodejs bash -y

# Clean any previous broken Heroku install
rm -rf $PREFIX/lib/heroku
rm -f $PREFIX/bin/heroku

# Download Heroku CLI (ARM Linux build)
wget https://cli-assets.heroku.com/channels/stable/heroku-linux-arm.tar.gz -O heroku.tar.gz
tar -xvzf heroku.tar.gz

# Move Heroku files
mkdir -p $PREFIX/lib/heroku
mv heroku/* $PREFIX/lib/heroku
rm -rf heroku heroku.tar.gz

# Link CLI binary to $PREFIX/bin
ln -sf $PREFIX/lib/heroku/bin/heroku $PREFIX/bin/heroku

# Fix node binary path
cd $PREFIX/lib/heroku/bin
rm -f node
ln -s $PREFIX/bin/node node

# Add Heroku to PATH in .bashrc
if ! grep -q 'lib/heroku/bin' ~/.bashrc; then
  echo 'export PATH="$PREFIX/lib/heroku/bin:$PATH"' >> ~/.bashrc
fi

# Start Bash and load new PATH
exec bash

# Run Heroku CLI
heroku --version
