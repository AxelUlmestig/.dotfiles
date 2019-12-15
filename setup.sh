DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )
BASHRC=$HOME/.bashrc
VIM_RC=$HOME/.vimrc
NVIM_RC=$HOME/.config/nvim/init.vim
GHCI=$HOME/.ghci

rm -f $BASHRC
ln -s $DIR/bashrc $BASHRC

rm -f $VIM_RC
ln -s $DIR/vimrc $VIM_RC

mkdir -p $HOME/.config/nvim
rm -f $NVIM_RC
ln -s $DIR/vimrc $NVIM_RC

rm -f $GHCI
ln -s $DIR/ghci $GHCI
