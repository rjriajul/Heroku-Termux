pkg install wget tar gzip nodejs -y

# Download and extract Heroku CLI
wget https://cli-assets.heroku.com/channels/stable/heroku-linux-arm.tar.gz -O heroku.tar.gz
tar -xvzf heroku.tar.gz

# Move files to Termux lib directory
mkdir -p $PREFIX/lib/heroku
mv heroku/* $PREFIX/lib/heroku
rm -rf heroku heroku.tar.gz

# Create symlink to make `heroku` accessible
ln -sf $PREFIX/lib/heroku/bin/heroku $PREFIX/bin/heroku

# Fix Node path for Termux
cd $PREFIX/lib/heroku/bin
rm -f node
ln -s $PREFIX/bin/node node

# Optional: Add Heroku CLI to PATH permanently
echo 'export PATH="$PREFIX/lib/heroku/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Run Heroku CLI
heroku --version
