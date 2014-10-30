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

    if !exists('g:ftcolor_last_colorscheme')
        let g:ftcolor_last_colorscheme = ''
    endif

    if !exists('g:ftcolor_last_background')
        let g:ftcolor_last_background = ''
    endif

    " check the color mapping when a buffer is loaded.
    au BufNewFile,BufEnter,BufReadPost,WinEnter * call ftcolor#MapColorScheme()
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
    if s:GetCurrentColourSchemeName() !=? a:colorscheme_name
        let cmd = 'colorscheme ' . a:colorscheme_name
        exec cmd
    endif
    let g:ftcolor_last_colorscheme = a:colorscheme_name
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
    if s:GetCurrentBackground() !=? a:bground_name
        if a:bground_name ==? 'dark' || a:bground_name ==? 'light'
            let cmd = 'set background=' . tolower(a:bground_name)
            exec cmd
        endif
    endif
    if a:bground_name !=? 'NONE'
        let g:ftcolor_last_background = a:bground_name
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

    if doit
        let target_scheme = get(g:ftcolor_color_mappings, &filetype, g:ftcolor_default_color_scheme)
        " the value of the key can be either a string, or a list,
        " like 'molokai' or ['molokai', 'dark']

        if &readonly
            unlet target_scheme
            let target_scheme = g:ftcolor_last_colorscheme
        endif
        if !&modifiable
            " call input('t1 ' . type(target_scheme))
            " call input('t2 ' . type(g:ftcolor_last_colorscheme))
            unlet target_scheme
            let target_scheme = g:ftcolor_last_colorscheme
        endif
        if &buftype!=#''
            unlet target_scheme
            let target_scheme = g:ftcolor_last_colorscheme
        endif
        if &buftype==#'nofile'
            unlet target_scheme
            let target_scheme = g:ftcolor_last_colorscheme
        endif
        if &buftype==#'quickfix'
            unlet target_scheme
            let target_scheme = g:ftcolor_last_colorscheme
        endif
        if &buftype==#'help'
            unlet target_scheme
            let target_scheme = g:ftcolor_last_colorscheme
        endif
        if &filetype==#'nerdree'
            unlet target_scheme
            let target_scheme = g:ftcolor_last_colorscheme
        endif

        " the value is expected to be a list,
        " such as ['molokai'] or ['molokai', 'dark']
        if type(target_scheme) == type('')
            call s:SetColorScheme(target_scheme)
        else
            call s:SetColorScheme(target_scheme[0])
        endif

        if type(target_scheme) == type([])
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
