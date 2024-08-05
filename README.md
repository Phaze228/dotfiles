Just as a reminder for yourself,
gpg -d dotfiles.tar.gpg > dotfiles.tar
remmeber your password

tar -xf dotfiles.tar && mv dotfiles/* ../
for i in *; stow -S $i
