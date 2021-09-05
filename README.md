# Dotfiles
Repo for storing configuration files for my machine. Some I now use very often (vim for example), some I don't (i3, now I use KDE with grid-tiling).

## Installation
The configuration files can be easily install with [GNU stow](https://www.gnu.org/software/stow/).

First and foremost, install this repo and also recursively install the dependency/submodule.

To install configuration for thing in 1 folder, just `cd` to this repo's root and then use the following command.

```sh
> stow <folder-name>
```
