"
" Custom Python Syntax File
"

syn keyword pythonStatement 		False None True
syn match pythonConstant		"\<[A-Z0-9_-]*\>"
syn match pythonList			"\[\|\]"
syn match pythonDict			"{\|}"
syn match pythonKwargs			"\v\w+\="	contained
syn match pythonKwargsAssignment	"\v\<\=\>,"	contained
syn region pythonFunctionCall start="\v\w+\(" end="\v\)" contains=pythonKwargs,pythonKwargsAssignment,pythonString,pythonConstant,pythonComment,pythonList,pythonDict,pythonConstant,pythonStatement fold transparent

hi link pythonConstant   	Constant
hi link pythonList       	Identifier
hi link pythonDict       	Label
hi link pythonKwargs     	Function
hi link pythonKwargsAssignment  String
