"vimrc
" '!' をつけると、CommandやFunctionの定義が上書き定義。Reloadableな定義となる
" set backupdir& backupdir+=/foo
" 変数もこのようにDefaultを明示してReloadableにしよう
colorscheme default

filetype plugin on

syntax on

"set verbose=9    "!!! for the debug of autocmd

setlocal omnifunc=syntaxcomplete#Complete
set nocompatible  "vim Defaultへ"
set number

set notitle
set hlsearch
set list  "非表示文字の表示。とその設定↓"
set listchars=eol:$,tab:>\ ,extends:<	

"set cursorcolumn
set smarttab
set expandtab
set tabstop=2
set softtabstop=2 "連続空白でのカーソルの移動数"
set shiftwidth=2 "自動インデントでずれる幅"
set autoindent  "改行時に前の行のインデントを継続する"
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する"
set smartcase   "検索時大文字入れたら大文字で検索？

set display=lastline
set pumheight=10
set showmatch "対括弧
set matchtime=1
set incsearch "incremental search"
set laststatus=2

" ステータスバー設定
"set statusline=%F         " filename  長いので、CommandLineへ
set statusline+=%r        " [ステータスバー]読み込み専用かどうか表示 
set statusline+=%=        " [ステータスバー]ここからツールバー右側
set statusline+=[FORMAT=%{&ff}]\    " [ステータスバー]ファイルフォーマット表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}] " [ステータスバー]文字コードの表示
set statusline+=[%l行,%v桁]         " [ステータスバー]列位置、行位置の表示
set statusline+=[%p%%]              " [ステータスバー]現在行が全体行の何%目か表示
set statusline+=[%{GetColumnName()}]       " [ステータスバー]現在のファイルの文字数をカウント
"set statusline+=[%{strlen(substitute(join(add(getline(1,line('.')-1),strpart(getline('.'),0,col('.')-1)),'.'),'.','.','g'))+1}] " Cursorまでの文字数

" <for debug>
" execute editing file
nnoremap <F5> :! bash %<CR>

" window 分割 : windows.txt
nnoremap s <Nop>
nnoremap ss :<C-u>sp<CR>          " window の水平分割
nnoremap sv :<C-u>vs<CR>          " 垂直分割
nnoremap sh <C-w>h                " window 間移動 左
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l                "               右
nnoremap sw <C-w>w                "               次へ
nnoremap sH <C-w>H                " window 自体を移動する。使わないかも？
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sr <C-w>r                "               回転
nnoremap so <C-w>_<C-w>\|         " ssize  maximize H&W
nnoremap s_ <C-w>_
nnoremap s= <C-w>=                "       same all
nnoremap sO <C-w>=                "       same all
nnoremap s< <C-w><
nnoremap s> <C-w>>
nnoremap s- <C-w>-
nnoremap s+ <C-w>+
" vim-submode: needed thus, they are currently disabled
"call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
"call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
"call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
"call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
"call submode#map('bufmove', 'n', '', '>', '<C-w>>')
"call submode#map('bufmove', 'n', '', '<', '<C-w><')
"call submode#map('bufmove', 'n', '', '+', '<C-w>+')
"call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" tab
nnoremap st :<C-u>tabnew<CR>      " new tab
nnoremap sn gt                    " next tab
nnoremap sp gT                    " previous tab
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap sq :<C-u>q<CR>           " close window
nnoremap sQ :<C-u>bd<CR>          " close buffer
" the followings need 'unite.vim'
"nnoremap sT :<C-u>Unite tab<CR>
"nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
"nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
" tab pages 上のがいいと感じたので、以下のTab関係はやめ
"nnoremap <C-t>  <Nop>
"nnoremap <C-t>n  :<C-u>tabnew<CR>
"nnoremap <C-t>w  :<C-u>tabclose<CR>
"nnoremap <C-t>o  :<C-u>tabonly<CR>
"nnoremap <C-t>j  :<C-u>execute 'tabnext' 1 + (tabpagenr() + v:count1 - 1) % tabpagenr('$')<CR>
"nnoremap <C-t>k  gT

" tags-and-searches
nnoremap t  <Nop>
nnoremap tt  <C-]>           「飛ぶ」
nnoremap tj  :<C-u>tag<CR>   「進む」
nnoremap tk  :<C-u>pop<CR>   「戻る」
nnoremap tl  :<C-u>tags<CR>  履歴一覧

" help: を楽に
nnoremap <C-h>  :<C-u>help<Space>

" +/- でNumericalのIncrement/Decrement"
nnoremap + <C-a>
nnoremap - <C-x>
" Y: Yを行末までのヤンクにする
nnoremap Y y$


"検索時に、いつも\v を付けることで、自然な正規表現を使えるように
" /v /V /m /M 
nmap / /\v

" start to edit vimrc
nnoremap <Space>.
\        :<C-u>edit $MYVIMRC<CR>



" AutoCommand は以下のようにGroup化し、上書きにする
"augroup MyAutoCmd
"  autocmd!
"  autocmd BufEnter *  ...
"  autocmd BufLeave *  ...
"  ...
"augroup

" 'K' for man : http://haya14busa.com/reading-vim-help/
"augroup MyVimrc
"  autocmd!
"augroup END

" qでhelpを閉じる
"autocmd MyVimrc help nnoremap <buffer> q <C-w> c

" 一気に複数設定する場合
"function! s:init_help()
"  nnoremap <buffer> q <C-w> c
"  nnoremap <buffer> <Space><Space> <C-]>
"  " etc ...
"endfunction
"autocmd MyVimrc help call s:init_help()



" paste時、paste mode にして、indent爆発を起こさせないように
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" CTRL+X, CTRL+U ユーザー定義補完 
:setlocal completefunc=CompleteMCommands
function! CompleteMCommands(findstart, base)
  if a:findstart
    " 単語の始点を検索する
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    " "a:base" にマッチするWord探索
    let res = []
 for mcommand in split("maccum f= s=,mavg f=,mbest s=,mbucket f= n=,mcal a= c=,mcat,mchgnum f= R=,mchgstr c= f=,mchkcsv, mcombi a= f= n=,mcommon k= m=| i=,mcount a=,mcross f= s=,mcut f=,mdelnull f=,mdformat c= f=,mdup rec f=|n=,mfldname f=|n=,mfsort f=,mhashavg f=,mhashsum f=,mjoin k= m=| i=,mkeybreak k=,mmbucket f= n=,mmvavg s= k= f=,mmvsim f= c= a= -n,mmvstats f= c= -n,mnewnumber a=,mnewrand a=,mnewstr a=,mnjoi n k= m=| i=,mnormalize c= f=,mnrcommon R= r= m=| i=,mnullto f=,mnumber a=,mpadding f=,mpaste -n -N m=| i=,mproduct m=| i=,mrand a=,mrjoin r=,msed c= f= v=,msel c=,mselnum f= c=,mselrand c=|p=, msep d=,msetstr v= a=,mshare f=,mshuffle n=|v= d=,msim c= f=,mslide f= s=,msortf f=,msplit f= a=,ms tats c= f=,msum f=,msummary c= f=,mtee,mtonull f= v=,mtra f=,mtrafld a=,mtraflg a= f=,muniq k=,mvca t vf=item1 items2 a=catItems i=in.csv mvcommon vf= K= m=| i=,mvcount vf=,mvdelim vf= v=,mvdelnul l vf= i=,mvjoin vf= K= f= m=| i=,mvnullto vf= i=,mvreplace vf= K= f= m=| i=,mvsort vf=,mvuniq vf =,mwindow wk= t=", ",")
      if mcommand =~ '^' . a:base
        call add(res, mcommand)
      endif
    endfor
    return res
  endif
endfun




" csvファイルハイライト「:Csv [数値]」 と打つと、csvファイルでnカラム目のハイライトをしてくれる
function! CSVH(x)
   execute 'match Keyword /^\([^,]*,\)\{'.a:x.'}\zs[^,]*/'
   execute 'normal ^'.a:x.'f,'
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

" 「:Csvs」と打つと、現在のカラムをハイライトにしてくれる
command! Csvs :call CSVH(strlen(substitute(getline('.')[0:col('.')-1], "[^,]", "", "g")))

" 「:Csvn」と打つと、Csv系のコマンドのハイライトを消す
command! Csvn execute 'match none'

" 「:Csva」と打つと、リアルタイムに現在のカラムをハイライトにしてくれるもう一度打つと停止
function! CSVH_SAVE_CURSOR()
   let g:CsvaFlg = get(g:, 'CsvaFlg', 0)
   if g:CsvaFlg == 1
      execute 'match Keyword /^\([^,]*,\)\{'.strlen(substitute(getline('.')[0:col('.')-1], "[^,]", "", "g")).'}\zs[^,]*/'
   endif
endfunction
augroup CsvCursorHighlight
    autocmd!
    autocmd BufWinEnter,InsertLeave,CursorHold * call CSVH_SAVE_CURSOR() 
augroup END
function! CSVA()
   let g:CsvaFlg = get(g:, 'CsvaFlg', 0)
   if g:CsvaFlg == 0
      let g:CsvaFlg = 1
   else
      execute 'match none'
      let g:CsvaFlg = 0
   endif
endfunction
command! Csva :call CSVA()

" csvファイルを読み込んだ時に自動でCsvaコマンドを実行する
autocmd BufNewFile,BufRead *.csv execute'Csva'

" filepath をStatusではなく、command に表示する
augroup EchoFilePath
  autocmd!
  autocmd WinEnter * execute "normal! 1\<C-g>"
augroup END

" status bar でColumnName表示用
function! GetColumnName()
  let ret       = ""
  "let line_save = line(".")
  "let col_save  = col(".")
  let commaCount=strlen(substitute(getline('.')[0:col('.')-1], '[^,]', '', 'g'))
  let columns=split(getline(1), ',')
  let ret=get(columns, commaCount, 'notDetected')
"  let x=%s/./&/gn
  "g/^/let x+=strlen(substitute(getline('.'), '\w', '', 'g')) 
  return ret
endfunction

