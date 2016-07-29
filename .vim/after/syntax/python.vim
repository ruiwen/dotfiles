"
" Custom Python Syntax File
"

syn match pythonConstant   +\<[A-Z0-9_-]*\>+
syn match pythonList       +\[\|\]+
syn match pythonDict       +{\|}+
syn match pythonKwargs     +\v\w*\=+        contained
syn match pythonKwargsAssignment +\v\<\=\>+     contained
syn region pythonFunctionCall start=+\v\w*\s?\(+ end=+\v\)+ contains=pythonKwargs,pythonKwargsAssignment,pythonString,pythonConstant

hi link pythonConstant   Constant
hi link pythonList       Identifier
hi link pythonDict       Label
hi link pythonKwargs     Function
hi link pythonKwargsAssignment  String
