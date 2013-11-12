# == Class: maximum_awesome
#
# === Examples
#
#  include maximum_awesome
#
# === Authors
#
# Rickard von Essen <rickard.von.essen@gmail.com>
#
class maximum_awesome {

  $pkgs = ['the_silver_searcher', 'reattach-to-user-namespace', 'tmux', 'vim', 'ctags']
  package { $pkgs:
    ensure => latest,
  } ->

  repository { "/Users/${::boxen_user}/src/maximum-awesome/":
      source   => 'square/maximum-awesome',
      provider => 'git',
  } ->

  file { "/Users/${::boxen_user}/.vim":
    target  => "/Users/${::boxen_user}/src/maximum-awesome/vim",
  } ->
  file { "/Users/${::boxen_user}/.tmux.conf":
    target  => "/Users/${::boxen_user}/src/maximum-awesome/tmux.conf",
  } ->
  file { "/Users/${::boxen_user}/.vimrc":
    target  => "/Users/${::boxen_user}/src/maximum-awesome/vimrc",
  } ->
  file { "/Users/${::boxen_user}/.vimrc.bundles":
    target  => "/Users/${::boxen_user}/src/maximum-awesome/vimirc.bundles",
  } ->

  file { "/Users/${::boxen_user}/.vimrc.local":
    source  => "/Users/${::boxen_user}/src/maximum-awesome/vimrc.local",
    replace => false,
  } ->
  file { "/Users/${::boxen_user}/.vimrc.bundles.local":
    source  => "/Users/${::boxen_user}/src/maximum-awesome/vimrc.bundles.local",
    replace => false,
  } ->

  repository { "/Users/${::boxen_user}/.vim/bundle/vundle/":
    source => 'gmarik/vundle',
    provider => 'git',
  } ->

  exec { 'BundleInstall':
    command => 'vim -c "BundleInstall" -c "q" -c "q"',
    path => "/opt/boxen/homebrew/bin/", # TODO
  } ->

  exec { 'Set iTerm2 theme to Solarized Dark':
    command => "/usr/bin/open -a  /Applications/iTerm.app /Users/${::boxen_user}/src/maximum-awesome/iterm2-colors-solarized/Solarized\\ Dark.itermcolors",
  }
}
