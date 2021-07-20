#!/bin/zsh

pushd /tmp

echo 'Downloading Fira Code distribution from Nerd Fonts...'

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip

echo 'Cleaning up unneeded font files...'

unzip FiraCode.zip
rm -f FiraCode/*Windows*
rm -f FiraCode/*.ttf

echo 'Installing Fira Code...'

mkdir -p $HOME/Library/Fonts
cp FiraCode/*.otf $HOME/Library/Fonts/

rm -rf FiraCode/ FiraCode.zip

popd