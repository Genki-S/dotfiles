# Dotfiles

My setting files.

This document is organized with requirement -> rules approach.

## Install these
* the_silver_searcher
* hub

## Install vendor applications

```
vim -u ~/dotfiles/vendor/neovendor.vim
```

Installs in `~/vendor`.

## Vim

### Plugin Management

#### Requirement

* Easy settings

#### Rules

* Use NeoBundle
* Define bundles and NeoBundle options in yaml

### Switch.vim

#### Requirement

* Easy settings

#### Rules

* Define switch definitions in yaml
* definitions are organized as follows

```yaml
filetype1,filetype2:
  -
    - a
    - b
    - c
  -
    'regexp': 'switched'
```
