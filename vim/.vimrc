set number              " show line numbers

set textwidth=100       " break lines when line length increases

colorscheme elflord     " desert is another good choice that's built-in
syntax enable           " enable syntax processing

set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in TAB when editing
set expandtab           " tabs are spaces
set smarttab            " insert spaces for alignment on the fly

set autoindent          " copy indent from current line when starting newline
set smartindent         " do the right thing in context
set cindent             " stricter rules for C programs

set showcmd             " show command in bottom bar

set cursorline          " highlight current line

filetype indent on      " load filetype-specific indent files

set wildmenu            " visual automcomplete for command menu

set lazyredraw          " redraw only when we need to

set showmatch           " highlight matching braces [{()}] 

set dictionary=/usr/share/dict/words
set ignorecase      " case insensitive search
set smartcase       " use case if any caps used
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight with spacebar in command mode
nnoremap <leader><space> :nohlsearch<CR>

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds; za folds around current block
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

