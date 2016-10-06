DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASH_PROFILE="$HOME/.bash_profile"
VIM_RC="$HOME/.vimrc"
NVIM_RC="$HOME/.config/nvim/init.vim"

rm $BASH_PROFILE
ln -s $DIR/bash_profile $BASH_PROFILE

rm $VIM_RC
ln -s $DIR/vimrc $VIM_RC

mkdir -p "$HOME/.config/nvim"
rm $NVIM_RC
ln -s $DIR/vimrc $NVIM_RC
