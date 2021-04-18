let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'c': '~/.config/i3/config' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'b': '~/.bashrc' },
            \ '~/Blog',
            \ '~/Code',
            \ '~/Pics',
            \ ]

let g:startify_custom_header = [
        \ '                  __ __                 _   ___    __',
        \ '  ___  ____ ___  / // / ____ _____     / | / / |  / /',
        \ ' / _ \/ __ `__ \/ // /_/ __ `/ __ \   /  |/ /| | / / ',
        \ '/  __/ / / / / /__  __/ /_/ / /_/ /  / /|  / | |/ /  ',
        \ '\___/_/ /_/ /_/  /_/  \__, /\____/  /_/ |_/  |___/   ',
        \ '                     /____/                          ',
        \]
