" Vim syntax file
" Language:     Dot
" Filenames:    *.dot
" Maintainer:   Markus Mottl  <markus.mottl@gmail.com>
" URL:          http://www.ocaml.info/vim/syntax/dot.vim
" Last Change:  2011 May 17 - improved identifier matching + two new keywords
"               2001 May 04 - initial version

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Errors
syn match    dotParErr     ")"
syn match    dotBrackErr   "]"
syn match    dotBraceErr   "}"

" Enclosing delimiters
syn region   dotEncl transparent matchgroup=dotParEncl start="(" matchgroup=dotParEncl end=")" contains=ALLBUT,dotParErr
syn region   dotEncl transparent matchgroup=dotBrackEncl start="\[" matchgroup=dotBrackEncl end="\]" contains=ALLBUT,dotBrackErr
syn region   dotEncl transparent matchgroup=dotBraceEncl start="{" matchgroup=dotBraceEncl end="}" contains=ALLBUT,dotBraceErr

" Comments
syn region   dotComment start="//" end="$" contains=dotComment,dotTodo
syn region   dotComment start="/\*" end="\*/" contains=dotComment,dotTodo
syn keyword  dotTodo contained TODO FIXME XXX

" Strings
syn region   dotString    start=+"+ skip=+\\\\\|\\"+ end=+"+

" General keywords
syn keyword  dotKeyword  digraph node edge subgraph

" Graph attributes
syn keyword  dotType center layers margin mclimit name nodesep nslimit
syn keyword  dotType ordering page pagedir rank rankdir ranksep ratio
syn keyword  dotType rotate size

" Node attributes
syn keyword  dotType distortion fillcolor fontcolor fontname fontsize
syn keyword  dotType height layer orientation peripheries regular
syn keyword  dotType shape shapefile sides skew width

" Edge attributes
syn keyword  dotType arrowhead arrowsize arrowtail constraint decorateP
syn keyword  dotType dir headclip headlabel headport labelangle labeldistance
syn keyword  dotType labelfontcolor labelfontname labelfontsize
syn keyword  dotType minlen port_label_distance samehead sametail
syn keyword  dotType tailclip taillabel tailport weight

" Shared attributes (graphs, nodes, edges)
syn keyword  dotType color

" Shared attributes (graphs and edges)
syn keyword  dotType bgcolor label URL

" Shared attributes (nodes and edges)
syn keyword  dotType fontcolor fontname fontsize layer style

" Special chars
syn match    dotKeyChar  "="
syn match    dotKeyChar  ";"
syn match    dotKeyChar  "->"

" Identifier
syn match    dotIdentifier /\<\w\+\(:\w\+\)\?\>/

" Synchronization
syn sync minlines=50
syn sync maxlines=500

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_dot_syntax_inits")
  if version < 508
    let did_dot_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink html            Title

  HiLink dotParErr	 Error
  HiLink dotBraceErr	 Error
  HiLink dotBrackErr	 Error

  HiLink dotComment	 Comment
  HiLink dotTodo	 Todo

  HiLink dotParEncl	 Keyword
  HiLink dotBrackEncl	 Keyword
  HiLink dotBraceEncl	 Keyword

  HiLink dotKeyword	 Keyword
  HiLink dotType	 Type
  HiLink dotKeyChar	 Keyword

  HiLink dotString	 String
  HiLink dotIdentifier	 Identifier

  delcommand HiLink
endif

let b:current_syntax = "dot"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              HTML-like label                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

" tags
syn match   htmlTagN     contained +<[-a-zA-Z0-9]\++hs=s+1 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
syn match   htmlTagN     contained +</[-a-zA-Z0-9]\++hs=s+2 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster


" HTML-like label tag names
syn keyword htmlTagName contained BR FONT I B U O SUB SUP S
syn keyword htmlTagName contained HR VR IMG
syn keyword htmlTagName contained TABLE TR TD

" HTML-like label arg names
syn keyword htmlArg contained ALIGN BGCOLOR BORDER CELLBORDER CELLPADDING CELLSPACING COLOR COLUMNS
syn keyword htmlArg contained FIXEDSIZE GRADIENTANGLE HEIGHT HREF ID PORT ROWS SIDES STYLE
syn keyword htmlArg contained TARGET TITLE TOOLTIP VALIGN WIDTH

" The default highlighting.
if version >= 508 || !exists("did_html_syn_inits")
  if version < 508
    let did_html_syn_inits = 1
  endif
  HtmlHiLink htmlTag                     Function
  HtmlHiLink htmlEndTag                  Identifier
  HtmlHiLink htmlArg                     Type
  HtmlHiLink htmlTagName                 htmlStatement
  HtmlHiLink htmlSpecialTagName          Exception
  HtmlHiLink htmlValue                   String
  HtmlHiLink htmlSpecialChar             Special
  
  HtmlHiLink htmlPreStmt            PreProc
  " HtmlHiLink htmlPreError           Error
  HtmlHiLink htmlPreProc            PreProc
  HtmlHiLink htmlPreAttr            String
  HtmlHiLink htmlPreProcAttrName    PreProc
  " HtmlHiLink htmlPreProcAttrError   Error
  HtmlHiLink htmlSpecial            Special
  HtmlHiLink htmlSpecialChar        Special
  HtmlHiLink htmlString             String
  HtmlHiLink htmlStatement          Statement
  HtmlHiLink htmlComment            Comment
  HtmlHiLink htmlCommentPart        Comment
  HtmlHiLink htmlValue              String
  " HtmlHiLink htmlCommentError       htmlError
  " HtmlHiLink htmlTagError           htmlError
  HtmlHiLink htmlEvent              javaScript
  " HtmlHiLink htmlError              Error
  
  HtmlHiLink javaScript             Special
  HtmlHiLink javaScriptExpression   javaScript
  HtmlHiLink htmlCssStyleComment    Comment
  HtmlHiLink htmlCssDefinition      Special
endif

delcommand HtmlHiLink

" vim: ts=8
