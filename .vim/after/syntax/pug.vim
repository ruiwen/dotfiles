
" Custom fixes for jade/pug highlighting
" Default pugAttributes region wasn't properly highlighting multiline
" attributes, and apparently htmlArg (from html.vim) was at fault so it was
" removed
syn region  pugAttributes matchgroup=pugAttributesDelimiter start="(" skip=+\n+ end=")" contained contains=@htmlJavascript,pugHtmlArg,htmlEvent,htmlCssDefinition nextgroup=@pugComponent
