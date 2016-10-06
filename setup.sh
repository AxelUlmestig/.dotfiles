DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASHRC="$HOME/.bashrc"
VIM_RC="$HOME/.vimrc"
NVIM_RC="$HOME/.config/nvim/init.vim"

rm $BASHRC
ln -s $DIR/bashrc $BASHRC

rm $VIM_RC
ln -s $DIR/vimrc $VIM_RC

mkdir -p "$HOME/.config/nvim"
rm $NVIM_RC
ln -s $DIR/vimrc $NVIM_RC
