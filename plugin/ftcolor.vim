" -*- vim -*-
" FILE: ftcolor.vim
" PLUGINTYPE: utility
" DESCRIPTION: Changes colorschemes according to the buffer type.
" HOMEPAGE: https://github.com/caglartoklu/ftcolor.vim
" LICENSE: https://github.com/caglartoklu/ftcolor.vim/blob/master/LICENSE
" AUTHOR: caglartoklu


" References:
" http://stackoverflow.com/questions/2419624/how-to-tell-which-colorscheme-a-vim-session-currently-uses
" http://vim.wikia.com/wiki/Switch_color_schemes
" :help colors_name
" :help ft

if exists('b:ftcolor_loaded')
    " Do not load the plugin to the buffer if it
    " has been already loaded.
    finish
endif


function! s:SetDefaultSettings()
    " Sets the default settings for once.
    " If the user does not load the settings in vimrc,
    " these values will be used.

    if !exists('g:ftcolor_plugin_enabled')
        " enable/disable the plugin
        let g:ftcolor_plugin_enabled = 1
    endif

    if !exists('g:ftcolor_redraw')
        " after setting the color, redraw the screen
        let g:ftcolor_redraw = 1
    endif

    if !exists('g:ftcolor_default_color_scheme')
        " if there is no colorscheme mapping for the
        " filetype, this one will be used.
        if exists('g:colors_name')
            " there is already a defined color scheme,
            " use that as default.
            let g:ftcolor_default_color_scheme = g:colors_name
        else
            " no color scheme defined exists, so use
            " the 'default' as default.
            " 'default' is in vim bundle, so it will be
            " always available.
            let g:ftcolor_default_color_scheme = 'default'
        endif
    endif

    if !exists('g:ftcolor_color_mappings')
        " the colorscheme mappings.
        " the keys are filetypes, values are colorschemes.
        let g:ftcolor_color_mappings = {}
        " let g:ftcolor_color_mappings.basic = 'ibmedit'
        " let g:ftcolor_color_mappings.pas = 'borland'
        " let g:ftcolor_color_mappings.java = 'eclipse'
    endif

    " check the color mapping when a buffer is loaded.
    au BufNewFile,BufEnter,BufReadPost * call ftcolor#MapColorScheme()
endfunction


function! s:GetCurrentColourSchemeName()
    " Returns the name of the currently set color scheme.
    try
        let clr_name = g:colors_name
    catch
        let clr_name = ''
    endtry
    return clr_name
endfunction


function! s:SetColorScheme(colorscheme_name)
    " Sets the colorscheme if it is different than the current one.
    " Note that the comparison is case sensitive.
    " http://learnvimscriptthehardway.stevelosh.com/chapters/22.html
    if s:GetCurrentColourSchemeName() !=# a:colorscheme_name
        let cmd = 'colorscheme ' . a:colorscheme_name
        exec cmd
    endif
endfunction


function! s:GetCurrentBackground()
    " Returns the name of the currently set background.
    " Possible values are 'dark' and 'light'
    try
        let bground = &background
    catch
        let bground = ''
    endtry
    return bground
endfunction


function! s:SetBackground(bground_name)
    " Sets the background if it is different than the current one.
    " Note that the comparison is case insensitive.
    " http://learnvimscriptthehardway.stevelosh.com/chapters/22.html
    if s:GetCurrentBackground() !=# a:bground_name
        if a:bground_name ==? 'dark' || a:bground_name ==? 'light'
            let cmd = 'set background=' . tolower(a:bground_name)
            exec cmd
        endif
    endif
endfunction


" function! s:GetCurrentFileExtension()
"     " Returns the exact file extension of the current file
"     " on the buffer, such as 'py', or 'txt'.
"     return expand('%:e')
" endfunction


function! s:RedrawScreen()
    let cmd = 'redraw'
    exec cmd
endfunction


function! ftcolor#MapColorScheme()
    " Checks the current file type, and sets the color
    " according to the specified mapping.
    let doit = 1
    if !g:ftcolor_plugin_enabled
        let doit = 0
    endif
    " if &readonly
    "     let doit = 0
    " endif
    " if !&modifiable
    "     let doit = 0
    " endif
    " if &buftype!=#''
    "     let doit = 0
    " endif
    " if &buftype==#'nofile'
    "     let doit = 0
    " endif
    " if &buftype==#'quickfix'
    "     let doit = 0
    " endif
    " if &buftype==#'help'
    "     let doit = 0
    " endif
    " if &filetype==#'nerdree'
    "     let doit = 0
    " endif

    if winnr('$')!=1
        " This will avoid the change of the unwanted color changes.
        " If you have a buffer, let's say Python buffer, and use
        " a plugin that will internally open another buffer, such as
        " Fuzzy Finder or NERDTree, it would cause the color change
        " without this check.
        " http://stackoverflow.com/q/10224953
        let doit = 0
    endif

    if doit
        let target_scheme = get(g:ftcolor_color_mappings, &filetype, g:ftcolor_default_color_scheme)
        " the value of the key can be either a string, or a list,
        " like 'molokai' or ['molokai', 'dark']

        if type(target_scheme) == type('')
            " value is a string, such as 'molokai'
            " Decho 'target_scheme:' . target_scheme
            call s:SetColorScheme(target_scheme)
        else
            " the value is expected to be a list,
            " such as ['molokai'] or ['molokai', 'dark']
            call s:SetColorScheme(target_scheme[0])

            " safely get the 1st index, which will
            " 'dark' or 'light'.
            " If it does not exists, it will be 'NONE'
            let bground = get(target_scheme, 1, 'NONE')
            " Decho 'bground:' . bground
            call s:SetBackground(bground)
        endif

        if g:ftcolor_redraw == 1
            call s:RedrawScreen()
        endif
    endif
endfunction


" Set the settings once.
call s:SetDefaultSettings()
let b:ftcolor_loaded = 1
