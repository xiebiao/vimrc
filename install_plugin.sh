#!/bin/sh

#--------------
# author:xiaog
#--------------

#
#   NOTE:Make sure you have INSTALLed git and ctags
#

_CURRENT_PATH=`pwd`
_TEMP_DIR=$_CURRENT_PATH/temp
_USER=`whoami`
_VIM_HOME=""
_VIMRC=""
_VIM_PLUGIN=""
_VIM_DOC=""
_VIM_FTPLUGIN=""

_DEBUG=$*

init()
{
    if [ ! -f "/usr/bin/git" ];then
        echo "WARN: You must install git"
        exit 0
    fi
    if [ "$_USER" = "root" ];then
        _VIM_HOME="/root/.vim"
    else
        _VIM_HOME="/home/"$_USER"/.vim"
        _VIMRC="/home/"$_USER"/.vimrc"
    fi
    rm -rf $_VIM_HOME/*
    _VIM_PLUGIN=$_VIM_HOME"/plugin"
    _VIM_DOC=$_VIM_HOME"/doc"
    _VIM_FTPLUGIN=$_VIM_HOME"/ftplugin"

    if [ ! -d "$_VIM_PLUGIN" ]; then
        echo "mkdir $_VIM_PLUGIN ..."
        mkdir $_VIM_PLUGIN
    fi
    if [ ! -d "$_VIM_FTPLUGIN" ]; then
        echo "mkdir $_VIM_FTPLUGIN ..."
        mkdir $_VIM_FTPLUGIN
    fi
    rm -rf $_TEMP_DIR
    if [ ! -d "$_TEMP_DIR" ]; then
        echo "mkdir $_TEMP_DIR ..."
        mkdir "$_TEMP_DIR"
    fi
}

# taglist.vim
taglist()
{
    if [ ! -f "/usr/bin/ctags" ];then
        echo "WARN: You must install ctags"
        exit 0
    fi
    _TAGLIST="taglist"
    echo "INSTALL $_TAGLIST start ..."
    echo "..."
    _TAGLIST_FILE="taglist.zip"

    if [ ! -d "$_TEMP_DIR/$_TAGLIST" ]; then
        echo "  mkdir $_TAGLIST ..."
        mkdir "$_TEMP_DIR/$_TAGLIST"
        git clone https://github.com/vim-scripts/taglist.vim.git \
        $_TEMP_DIR/$_TAGLIST
    fi
    cp -rf $_TEMP_DIR/$_TAGLIST/plugin $_VIM_HOME 
    cp -rf $_TEMP_DIR/$_TAGLIST/doc $_VIM_HOME
    echo "INSTALL $_TAGLIST success ..."
    echo "..."
}
#   INSTALL https://github.com/godlygeek/tabular.git
tabular()
{

    _TABULAR="tabular"
    echo "INSTALL $_TABULAR start ..."
    echo "..."
    if [ ! -d "$_TEMP_DIR/$_TABULAR" ]; then
        mkdir $_TEMP_DIR/$_TABULAR
        git clone https://github.com/godlygeek/tabular.git $_TEMP_DIR/$_TABULAR 
    fi
    cp -rf $_TEMP_DIR/$_TABULAR/plugin $_VIM_HOME 
    cp -rf $_TEMP_DIR/$_TABULAR/doc $_VIM_HOME
    echo "INSTALL $_TABULAR success ..."
    echo "..."

}
# NERDTree
nerdtree()
{
    _NERDTREE="nerdtree"
    echo "INSTALL $_NERDTREE start ..."
    echo "..."
    if [ ! -d "$_TEMP_DIR/$_NERDTREE" ]; then
        mkdir $_TEMP_DIR/$_NERDTREE
        git clone https://github.com/scrooloose/nerdtree.git $_TEMP_DIR/$_NERDTREE
    fi
    cp -rf $_TEMP_DIR/$_NERDTREE/plugin $_VIM_HOME
    cp -rf $_TEMP_DIR/$_NERDTREE/doc $_VIM_HOME
    echo "INSTALL $_NERDTREE success ..."
    echo "..." 
}
# a.vim
# A few of quick commands to swtich between source files and header files
# quickly. 
a(){
    _A="a.vim"
    echo "INSTALL $_A start ..."
    echo "..."
    wget -q -nd -O $_VIM_PLUGIN/$_A \
    http://www.vim.org/scripts/download_script.php?src_id=7218
    echo "INSTALL $_A success ..."
    echo "..."
}

# c.vim
# description
# Statement oriented editing of  C / C++ programs 
# Speed up writing new code considerably. 
# Write code und comments with a professional appearance from the beginning. 
# Use code snippets
c()
{
    _C_FILE="cvim"
    echo "INSTALL $_C_FILE start ..."
    echo "..."
    if [ ! -d "$_TEMP_DIR/$_C_FILE" ]; then
        mkdir "$_TEMP_DIR/$_C_FILE" 
        git clone https://github.com/vim-scripts/c.vim.git $_TEMP_DIR/$_C_FILE
    fi
    cp -rf $_TEMP_DIR/$_C_FILE/* $_VIM_HOME/
    echo "INSTALL $_C_FILE success ..."
    echo "..."
}

main()
{
    init;
    #a;
    c;
    nerdtree;
    taglist;
    #tabular;
}

main
./install_vimrc.sh

