# Overview

This setting of vimrc provides vim editor with file system explorer on left pane by default and also provides IDE experience for C language and Golang.

# Installation Steps

1. Copy `.vimrc` file to home directory.
2. Run `go install golang.org/x/tools/gopls@latest` from command line to install `gopls` language server for golang.
3. Install Node JS.
4. Install `ccls` which is language server for C programming language. For macOS run `brew install ccls`.
5. Run `:PlugInstall` in vim editor to install all plugins.
6. Run `:GoInstallBinaries` in vim editor to install needed golang binaryies. Add `$GOPATH/bin` directory to `PATH` environment variable if needed.
7. Run `:CocConfig` and add below config.
```
{
	"languageserver": {
		"ccls": {
			"command": "ccls",
			"filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"],
			"rootPatterns": [".ccls", "compile_commands.json", ".git/", ".hg/"],
			"initializationOptions": {
				"cache": {
			        "directory": "/tmp/ccls"			          
				}				      
			}
						  
		},
		"golang": {
		    "command": "gopls",
		    "rootPatterns": ["go.mod"],
		    "filetypes": ["go"]
						  
		}
	}
}
```
8. Install [powerline fonts](https://github.com/powerline/fonts) and set terminal to use `Hack` font or any other powerline font.
