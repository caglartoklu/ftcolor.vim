# ftcolor.vim

Switches colorschemes according to the file type.

Home page:
[https://github.com/caglartoklu/ftcolor.vim](https://github.com/caglartoklu/ftcolor.vim)

Vim.org page:
[http://www.vim.org/scripts/script.php?script_id=5028](http://www.vim.org/scripts/script.php?script_id=5028)

If you are in a position to work on more than one file type in a project (or several projects),
this plugin could be useful:
With this plugin, it is possible to map a file type to a color scheme.
It can mimic the color schemes of well known development environment colors to comply with your habits.


# Changelog

Please follow the
[commit log](https://github.com/caglartoklu/ftcolor.vim/commits/master)
for the full list.

- 0.0.1, 2014-10-05
  - First version.


# Installation

For [Vundle](https://github.com/gmarik/vundle) users:

    Plugin 'caglartoklu/ftcolor.vim'

For [Pathogen](https://github.com/tpope/vim-pathogen) users:

    cd ~/.vim/bundle
    git clone git://github.com/caglartoklu/ftcolor.vim

For all other users, simply drop the `ftcolor.vim` file to your
`plugin` directory.


# Requirements

- Vim (no `+Python` required)
- Various color schemes of your choice.
See the section **Color Schemes** for references to some color schemes used in the samples.


# Usage

The plugin is automatic.
It will automatically run for each buffer after it has been configured for chosen file types.
The following animation shows a few buffer changes:

![ftcolor_demo_20141005.gif](https://raw.githubusercontent.com/caglartoklu/ftcolor.vim/media/ftcolor_demo_20141005.gif)


To determine the file type of a buffer, type one of the following:

    :echo &filetype
    :echo &ft


# Configuration

## `g:ftcolor_plugin_enabled`
Enable/disable plugin.
The default is:

    let g:ftcolor_plugin_enabled = 1


## `g:ftcolor_redraw`
After setting the color, redraw the screen.
The default is:

    let g:ftcolor_redraw = 1


# `g:ftcolor_default_color_scheme`
If there is mapping for a file type, this color will be used.
For this setting, you can set a colorscheme you like most.
The default is:

    let g:ftcolor_default_color_scheme = 'default'


# `g:ftcolor_color_mappings`
These are the keys you need to set to use the plugin.
The default is empty, and it needs to be filled:

    let g:ftcolor_color_mappings = {}

After defining it, each file type must be defined separetely:

The format is

    let g:ftcolor_color_mappings.<file-type-here> = 'color-scheme-here'

Such as one of the following:

    let g:ftcolor_color_mappings.java = 'eclipse'
    let g:ftcolor_color_mappings.java = ['eclipse']

You can also define whether the background is dark or light, as in the following sample:

    let g:ftcolor_color_mappings.java = ['eclipse', 'light']


# Example configuration snippet for .vimrc

    let g:ftcolor_redraw = 1
    let g:ftcolor_default_color_scheme = ['molokai']
    let g:ftcolor_color_mappings = {}
    let g:ftcolor_color_mappings.basic = ['ibmedit']
    let g:ftcolor_color_mappings.vb = ['ibmedit']
    let g:ftcolor_color_mappings.pas = 'borland'
    let g:ftcolor_color_mappings.java = ['eclipse', 'light']
    let g:ftcolor_color_mappings.cs = ['blueshift']
    let g:ftcolor_color_mappings.vimwiki = ['molokai']
    let g:ftcolor_color_mappings.python = ['django']


# Color Schemes

The following is a list for the color schemes used in the samples in this document.

* [https://github.com/tomasr/molokai](https://github.com/tomasr/molokai)
* [https://github.com/vim-scripts/ibmedit.vim](https://github.com/vim-scripts/ibmedit.vim)
* [https://github.com/vim-scripts/borland.vim](https://github.com/vim-scripts/borland.vim)
* [https://github.com/vim-scripts/eclipse.vim](https://github.com/vim-scripts/eclipse.vim)
* [https://github.com/vim-scripts/Blueshift](https://github.com/vim-scripts/Blueshift)
* [https://github.com/django.vim--Ronacher](https://github.com/django.vim--Ronacher)


The [Vundle](https://github.com/gmarik/Vundle.vim) code snippet for the corresponding files are:

    Plugin 'tomasr/molokai'
    Plugin 'vim-scripts/ibmedit.vim'
    Plugin 'vim-scripts/borland.vim'
    Plugin 'vim-scripts/eclipse.vim'
    Plugin 'vim-scripts/Blueshift'
    Plugin 'django.vim--Ronacher'

For more, there are lots of (read: 428) color schemes with previews here:
[https://code.google.com/p/vimcolorschemetest/](https://code.google.com/p/vimcolorschemetest/)

For even more, see the full list of color scheme scripts on
[vim.org](http://www.vim.org/scripts/script_search_results.php?keywords=&script_type=color+scheme&order_by=creation_date&direction=descending&search=search)


# License

Licensed with
[2-clause license](https://en.wikipedia.org/wiki/BSD_licenses#2-clause_license_.28.22Simplified_BSD_License.22_or_.22FreeBSD_License.22.29)
("Simplified BSD License" or "FreeBSD License").
See the
[LICENSE](https://github.com/caglartoklu/ftcolor.vim/blob/master/LICENSE) file.


# Legal

All trademarks and registered trademarks are the property of their respective owners.
The color schemes referenced in this document are not part of the [ftcolor.vim](https://github.com/caglartoklu/ftcolor.vim)
plugin. See their individual licenses if necessary.


# Contact Info

You can find me on
[Google+](https://plus.google.com/108566243864924912767/posts)

Feel free to send bug reports, or ask questions.
