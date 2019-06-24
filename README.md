# ide.vim

This project is discontinued. I have moved to my own dotfiles wich contain full setup for VIM and not only: 
https://github.com/run2cmd/dotfiles

Bring IDE experiance to VIM

VIM configuration to bring IDE experiance out of the box for VIM 7.4 and above.
Works with Vundle Plugin Manager only. For other plugin managers you need to tweak vimrc file

## Requirements
- [Git](https://git-scm.com/downloads)
- [ViFM](https://vifm.info/downloads.shtml)
- Lint and syntax checkers you need for [ALE](https://github.com/w0rp/ale)

## Installation
For basic sourcing
```
let custom_config_file = '~/.vim/bundle/ide.vim/vimrc'
exe 'source' custom_config_file
```

Put below into your source vimrc for automatinc download
```
cd $HOME
let i_have_ide_vim=1
let ide_vim_readme=expand('.vim/bundle/ide.vim/README.md')
if !filereadable(ide_vim_readme)
  echo "Installing IDE VIM.."
  echo ""
  silent !mkdir -p .vim/bundle
  silent !git clone https://github.com/run2cmd/ide.vim .vim/bundle/ide.vim
  let i_have_ide_vim=0
endif
let custom_config_file = '~/.vim/bundle/ide.vim/vimrc'
exe 'source' custom_config_file
```

## Author
Piotr Bugała <piotr.bugala@gmail.com>
