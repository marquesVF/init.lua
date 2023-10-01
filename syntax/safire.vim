
syntax match   srNoise          /[:;]/
syntax match   srNoise          /,/ skipwhite skipempty nextgroup=@srExpression
syntax match   srDot            /\./ skipwhite skipempty nextgroup=srObjectProp,srFuncCall,srPrototype,srTaggedTemplate
syntax match   srObjectProp     contained /\<\K\k*/
syntax match   srFuncCall       /\<\K\k*\ze[\s\n]*(/
syntax match   srParensError    /[)}\]]/

" Program Keywords
" <foo> = 3 the next defines a variable
syntax keyword srStorageClass   skipwhite skipempty nextgroup=srDestructuringBlock,srDestructuringArray,srVariableDef  
syntax match   srVariableDef    contained /\<\K\k*/ skipwhite skipempty nextgroup=srFlowDefinition
syntax keyword srOperatorKeyword delete instanceof typeof void new in skipwhite skipempty nextgroup=@srExpression
syntax keyword srOf             of skipwhite skipempty nextgroup=@srExpression
syntax match   srOperator       "[-!|&+<>=%/*~^]" skipwhite skipempty nextgroup=@srExpression
syntax match   srOperator       /::/ skipwhite skipempty nextgroup=@srExpression
syntax keyword srBooleanTrue    true
syntax keyword srBooleanFalse   false

" Modules
syntax keyword srImport                       import skipwhite skipempty nextgroup=srModuleAsterisk,srModuleKeyword,srModuleGroup,srFlowImportType
syntax keyword srExport                       export skipwhite skipempty nextgroup=@srAll,srModuleGroup,srExportDefault,srModuleAsterisk,srModuleKeyword,srFlowTypeStatement
syntax match   srModuleKeyword      contained /\<\K\k*/ skipwhite skipempty nextgroup=srModuleAs,srFrom,srModuleComma
syntax keyword srExportDefault      contained default skipwhite skipempty nextgroup=@srExpression
syntax keyword srExportDefaultGroup contained default skipwhite skipempty nextgroup=srModuleAs,srFrom,srModuleComma
syntax match   srModuleAsterisk     contained /\*/ skipwhite skipempty nextgroup=srModuleKeyword,srModuleAs,srFrom
syntax keyword srModuleAs           contained as skipwhite skipempty nextgroup=srModuleKeyword,srExportDefaultGroup
syntax keyword srFrom               contained from skipwhite skipempty nextgroup=srString
syntax match   srModuleComma        contained /,/ skipwhite skipempty nextgroup=srModuleKeyword,srModuleAsterisk,srModuleGroup,srFlowTypeKeyword

" Strings, Templates, Numbers
syntax region  srString           start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ end=+$+  contains=srSpecial extend
syntax region  srTemplateString   start=+`+  skip=+\\`+  end=+`+     contains=srTemplateExpression,srSpecial extend
syntax match   srTaggedTemplate   /\<\K\k*\ze`/ nextgroup=srTemplateString
syntax match   srNumber           /\c\<\%(\d\+\%(e[+-]\=\d\+\)\=\|0b[01]\+\|0o\o\+\|0x\%(\x\|_\)\+\)n\=\>/
syntax keyword srNumber           Infinity
syntax match   srFloat            /\c\<\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%(e[+-]\=\d\+\)\=\>/

" Regular Expressions
syntax match   srSpecial            contained "\v\\%(x\x\x|u%(\x{4}|\{\x{4,5}})|c\u|.)"
syntax region  srTemplateExpression contained matchgroup=srTemplateBraces start=+${+ end=+}+ contains=@srExpression keepend
syntax region  srRegexpCharClass    contained start=+\[+ skip=+\\.+ end=+\]+ contains=srSpecial extend
syntax match   srRegexpBoundary     contained "\v\c[$^]|\\b"
syntax match   srRegexpBackRef      contained "\v\\[1-9]\d*"
syntax match   srRegexpQuantifier   contained "\v[^\\]%([?*+]|\{\d+%(,\d*)?})\??"lc=1
syntax match   srRegexpOr           contained "|"
syntax match   srRegexpMod          contained "\v\(\?[:=!>]"lc=1
syntax region  srRegexpGroup        contained start="[^\\]("lc=1 skip="\\.\|\[\(\\.\|[^]]\+\)\]" end=")" contains=srRegexpCharClass,@srRegexpSpecial keepend
syntax region  srRegexpString   start=+\%(\%(\<return\|\<typeof\|\_[^)\]'"[:blank:][:alnum:]_$]\)\s*\)\@<=/\ze[^*/]+ skip=+\\.\|\[[^]]\{1,}\]+ end=+/[gimyus]\{,6}+ contains=srRegexpCharClass,srRegexpGroup,@srRegexpSpecial oneline keepend extend
syntax cluster srRegexpSpecial    contains=srSpecial,srRegexpBoundary,srRegexpBackRef,srRegexpQuantifier,srRegexpOr,srRegexpMod

" Objects
syntax match   srObjectShorthandProp contained /\<\k*\ze\s*/ skipwhite skipempty nextgroup=srObjectSeparator
syntax match   srObjectKey         contained /\<\k*\ze\s*:/ contains=srFunctionKey skipwhite skipempty nextgroup=srObjectValue
syntax region  srObjectKeyString   contained start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=srSpecial skipwhite skipempty nextgroup=srObjectValue
syntax region  srObjectKeyComputed contained matchgroup=srBrackets start=/\[/ end=/]/ contains=@srExpression skipwhite skipempty nextgroup=srObjectValue,srFuncArgs extend
syntax match   srObjectSeparator   contained /,/
syntax region  srObjectValue       contained matchgroup=srObjectColon start=/:/ end=/[,}]\@=/ contains=@srExpression extend
syntax match   srObjectFuncName    contained /\<\K\k*\ze\_s*(/ skipwhite skipempty nextgroup=srFuncArgs
syntax match   srFunctionKey       contained /\<\K\k*\ze\s*:\s*fn\>/
syntax match   srObjectMethodType  contained /\<[gs]et\ze\s\+\K\k*/ skipwhite skipempty nextgroup=srObjectFuncName
syntax region  srObjectStringKey   contained start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=srSpecial extend skipwhite skipempty nextgroup=srFuncArgs,srObjectValue

exe 'syntax keyword srNull      null             '.(exists('g:safire_conceal_null')      ? 'conceal cchar='.g:javascript_conceal_null       : '')
exe 'syntax keyword srReturn    return contained '.(exists('g:safire_conceal_return')    ? 'conceal cchar='.g:javascript_conceal_return     : '').' skipwhite nextgroup=@srExpression'
exe 'syntax keyword srUndefined undefined        '.(exists('g:safire_conceal_undefined') ? 'conceal cchar='.g:javascript_conceal_undefined  : '')
exe 'syntax keyword srNan       NaN              '.(exists('g:safire_conceal_NaN')       ? 'conceal cchar='.g:javascript_conceal_NaN        : '')
exe 'syntax keyword srPrototype prototype        '.(exists('g:safire_conceal_prototype') ? 'conceal cchar='.g:javascript_conceal_prototype  : '')
exe 'syntax keyword srThis      this             '.(exists('g:safire_conceal_this')      ? 'conceal cchar='.g:javascript_conceal_this       : '')
exe 'syntax keyword srSuper     super  contained '.(exists('g:safire_conceal_super')     ? 'conceal cchar='.g:javascript_conceal_super      : '')

" Statement Keywords
syntax match   srBlockLabel              /\<\K\k*\s*::\@!/    contains=srNoise skipwhite skipempty nextgroup=srBlock
syntax match   srBlockLabelKey contained /\<\K\k*\ze\s*\_[;]/
syntax keyword srStatement     contained with yield debugger
syntax keyword srStatement     contained break continue skipwhite skipempty nextgroup=srBlockLabelKey
syntax keyword srConditional            if              skipwhite skipempty nextgroup=srParenIfElse
syntax keyword srConditional            else            skipwhite skipempty nextgroup=srCommentIfElse,srIfElseBlock
syntax keyword srConditional            switch          skipwhite skipempty nextgroup=srParenSwitch
syntax keyword srWhile                  while           skipwhite skipempty nextgroup=srParenWhile
syntax keyword srFor                    for             skipwhite skipempty nextgroup=srParenFor,srForAwait
syntax keyword srDo                     do              skipwhite skipempty nextgroup=srRepeatBlock
syntax region  srSwitchCase   contained matchgroup=srLabel start=/\<\%(case\|default\)\>/ end=/:\@=/ contains=@srExpression,srLabel skipwhite skipempty nextgroup=srSwitchColon keepend
syntax keyword srTry                    try             skipwhite skipempty nextgroup=srTryCatchBlock
syntax keyword srFinally      contained finally         skipwhite skipempty nextgroup=srFinallyBlock
syntax keyword srCatch        contained catch           skipwhite skipempty nextgroup=srParenCatch,srTryCatchBlock
syntax keyword srException              throw
syntax keyword srAsyncKeyword           async await
syntax match   srSwitchColon   contained /::\@!/        skipwhite skipempty nextgroup=srSwitchBlock

" Keywords
syntax keyword srGlobalObjects     ArrayBuffer Array BigInt BigInt64Array BigUint64Array Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray Boolean Buffer Collator DataView Date DateTimeFormat Function Intl Iterator JSON Map Set WeakMap WeakRef WeakSet Math Number NumberFormat Object ParallelArray Promise Proxy Reflect RegExp String Symbol Uint8ClampedArray WebAssembly console document fetch window
syntax keyword srGlobalNodeObjects  module exports global process __dirname __filename
syntax match   srGlobalNodeObjects  /\<require\>/ containedin=srFuncCall
syntax keyword srExceptions         Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError
syntax keyword srBuiltins           decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt uneval
" DISCUSS: How imporant is this, really? Perhaps it should be linked to an error because I assume the keywords are reserved?
syntax keyword srFutureKeys         abstract enum int short boolean interface byte long char final native synchronized float package throws goto private transient implements protected volatile double public

" DISCUSS: Should we really be matching stuff like this?
" DOM2 Objects
syntax keyword srGlobalObjects  DOMImplementation DocumentFragment Document Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction
syntax keyword srExceptions     DOMException

" DISCUSS: Should we really be matching stuff like this?
" DOM2 CONSTANT
syntax keyword srDomErrNo       INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
syntax keyword srDomNodeConsts  ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE

" DISCUSS: Should we really be special matching on these props?
" HTML events and internal variables
syntax keyword srHtmlEvents     onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize

" Code blocks
syntax region  srBracket                      matchgroup=srBrackets            start=/\[/ end=/\]/ contains=@srExpression,srSpreadExpression extend fold
syntax region  srParen                        matchgroup=srParens              start=/(/  end=/)/  contains=@srExpression extend fold nextgroup=srFlowDefinition
syntax region  srParenDecorator     contained matchgroup=srParensDecorator     start=/(/  end=/)/  contains=@srExpression extend fold
syntax region  srParenIfElse        contained matchgroup=srParensIfElse        start=/(/  end=/)/  contains=@srExpression skipwhite skipempty nextgroup=srCommentIfElse,srIfElseBlock,srReturn extend fold
syntax region  srParenWhile         contained matchgroup=srParensWhile         start=/(/  end=/)/  contains=@srExpression skipwhite skipempty nextgroup=srCommentRepeat,srRepeatBlock,srReturn extend fold
syntax region  srParenFor           contained matchgroup=srParensFor           start=/(/  end=/)/  contains=@srExpression,srStorageClass,srOf skipwhite skipempty nextgroup=srCommentRepeat,srRepeatBlock,srReturn extend fold
syntax region  srParenSwitch        contained matchgroup=srParensSwitch        start=/(/  end=/)/  contains=@srExpression skipwhite skipempty nextgroup=srSwitchBlock extend fold
syntax region  srParenCatch         contained matchgroup=srParensCatch         start=/(/  end=/)/  skipwhite skipempty nextgroup=srTryCatchBlock extend fold
syntax region  srFuncArgs           contained matchgroup=srFuncParens          start=/(/  end=/)/  contains=srFuncArgCommas,srComment,srFuncArgExpression,srDestructuringBlock,srDestructuringArray,srRestExpression,srFlowArgumentDef skipwhite skipempty nextgroup=srCommentFunction,srFuncBlock,srFlowReturn extend fold
syntax region  srClassBlock         contained matchgroup=srClassBraces         start=/{/  end=/}/  contains=srClassFuncName,srClassMethodType,srArrowFunction,srArrowFuncArgs,srComment,srGenerator,srDecorator,srClassProperty,srClassPropertyComputed,srClassStringKey,srAsyncKeyword,srNoise extend fold
syntax region  srFuncBlock          contained matchgroup=srFuncBraces          start=/{/  end=/}/  contains=@srAll extend fold
syntax region  srIfElseBlock        contained matchgroup=srIfElseBraces        start=/{/  end=/}/  contains=@srAll extend fold
syntax region  srTryCatchBlock      contained matchgroup=srTryCatchBraces      start=/{/  end=/}/  contains=@srAll skipwhite skipempty nextgroup=srCatch,srFinally extend fold
syntax region  srFinallyBlock       contained matchgroup=srFinallyBraces       start=/{/  end=/}/  contains=@srAll extend fold
syntax region  srSwitchBlock        contained matchgroup=srSwitchBraces        start=/{/  end=/}/  contains=@srAll,srSwitchCase extend fold
syntax region  srRepeatBlock        contained matchgroup=srRepeatBraces        start=/{/  end=/}/  contains=@srAll extend fold
syntax region  srDestructuringBlock contained matchgroup=srDestructuringBraces start=/{/  end=/}/  contains=srDestructuringProperty,srDestructuringAssignment,srDestructuringNoise,srDestructuringPropertyComputed,srSpreadExpression,srComment nextgroup=srFlowDefinition extend fold
syntax region  srDestructuringArray contained matchgroup=srDestructuringBraces start=/\[/ end=/\]/ contains=srDestructuringPropertyValue,srDestructuringNoise,srDestructuringProperty,srSpreadExpression,srDestructuringBlock,srDestructuringArray,srComment nextgroup=srFlowDefinition extend fold
syntax region  srObject             contained matchgroup=srObjectBraces        start=/{/  end=/}/  contains=srObjectKey,srObjectKeyString,srObjectKeyComputed,srObjectShorthandProp,srObjectSeparator,srObjectFuncName,srObjectMethodType,srGenerator,srComment,srObjectStringKey,srSpreadExpression,srDecorator,srAsyncKeyword,srTemplateString extend fold
syntax region  srBlock                        matchgroup=srBraces              start=/{/  end=/}/  contains=@srAll,srSpreadExpression extend fold
syntax region  srModuleGroup        contained matchgroup=srModuleBraces        start=/{/ end=/}/   contains=srModuleKeyword,srModuleComma,srModuleAs,srComment,srFlowTypeKeyword skipwhite skipempty nextgroup=srFrom fold
syntax region  srSpreadExpression   contained matchgroup=srSpreadOperator      start=/\.\.\./ end=/[,}\]]\@=/ contains=@srExpression
syntax region  srRestExpression     contained matchgroup=srRestOperator        start=/\.\.\./ end=/[,)]\@=/
syntax region  srTernaryIf                    matchgroup=srTernaryIfOperator   start=/?:\@!/  end=/\%(:\|}\@=\)/  contains=@srExpression extend skipwhite skipempty nextgroup=@srExpression
" These must occur here or they will be override by srTernaryIf
syntax match   srOperator           /?\.\ze\_D/
syntax match   srOperator           /??/ skipwhite skipempty nextgroup=@srExpression

syntax match   srGenerator            contained /\*/ skipwhite skipempty nextgroup=srFuncName,srFuncArgs,srFlowFunctionGroup
syntax match   srFuncName             contained /\<\K\k*/ skipwhite skipempty nextgroup=srFuncArgs,srFlowFunctionGroup
syntax region  srFuncArgExpression    contained matchgroup=srFuncArgOperator start=/=/ end=/[,)]\@=/ contains=@srExpression extend
syntax match   srFuncArgCommas        contained ','
syntax keyword srArguments            contained arguments
syntax keyword srForAwait             contained await skipwhite skipempty nextgroup=srParenFor

" Matches a single keyword argument with no parens
syntax match   srArrowFuncArgs  /\<\K\k*\ze\s*=>/ skipwhite contains=srFuncArgs skipwhite skipempty nextgroup=srArrowFunction extend
" Matches a series of arguments surrounded in parens
syntax match   srArrowFuncArgs  /([^()]*)\ze\s*=>/ contains=srFuncArgs skipempty skipwhite nextgroup=srArrowFunction extend

exe 'syntax match srFunction /\<fn\>/      skipwhite skipempty nextgroup=srGenerator,srFuncName,srFuncArgs,srFlowFunctionGroup skipwhite '.(exists('g:safire_conceal_function') ? 'conceal cchar='.g:javascript_conceal_function : '')
exe 'syntax match srArrowFunction /=>/           skipwhite skipempty nextgroup=srFuncBlock,srCommentFunction '.(exists('g:safire_conceal_arrow_function') ? 'conceal cchar='.g:javascript_conceal_arrow_function : '')
exe 'syntax match srArrowFunction /()\ze\s*=>/   skipwhite skipempty nextgroup=srArrowFunction '.(exists('g:safire_conceal_noarg_arrow_function') ? 'conceal cchar='.g:javascript_conceal_noarg_arrow_function : '')
exe 'syntax match srArrowFunction /_\ze\s*=>/    skipwhite skipempty nextgroup=srArrowFunction '.(exists('g:safire_conceal_underscore_arrow_function') ? 'conceal cchar='.g:javascript_conceal_underscore_arrow_function : '')

" Classes
syntax keyword srClassKeyword           contained class
syntax keyword srExtendsKeyword         contained extends skipwhite skipempty nextgroup=@srExpression
syntax match   srClassNoise             contained /\./
syntax match   srClassFuncName          contained /\<\K\k*\ze\s*[(<]/ skipwhite skipempty nextgroup=srFuncArgs,srFlowClassFunctionGroup
syntax match   srClassMethodType        contained /\<\%([gs]et\|static\)\ze\s\+\K\k*/ skipwhite skipempty nextgroup=srAsyncKeyword,srClassFuncName,srClassProperty
syntax region  srClassDefinition                  start=/\<class\>/ end=/\(\<extends\>\s\+\)\@<!{\@=/ contains=srClassKeyword,srExtendsKeyword,srClassNoise,@srExpression,srFlowClassGroup skipwhite skipempty nextgroup=srCommentClass,srClassBlock,srFlowClassGroup
syntax match   srClassProperty          contained /\<\K\k*\ze\s*[=;]/ skipwhite skipempty nextgroup=srClassValue,srFlowClassDef
syntax region  srClassValue             contained start=/=/ end=/\_[;}]\@=/ contains=@srExpression
syntax region  srClassPropertyComputed  contained matchgroup=srBrackets start=/\[/ end=/]/ contains=@srExpression skipwhite skipempty nextgroup=srFuncArgs,srClassValue extend
syntax region  srClassStringKey         contained start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1\|$+  contains=srSpecial extend skipwhite skipempty nextgroup=srFuncArgs

" Destructuring
syntax match   srDestructuringPropertyValue     contained /\k\+/
syntax match   srDestructuringProperty          contained /\k\+\ze\s*=/ skipwhite skipempty nextgroup=srDestructuringValue
syntax match   srDestructuringAssignment        contained /\k\+\ze\s*:/ skipwhite skipempty nextgroup=srDestructuringValueAssignment
syntax region  srDestructuringValue             contained start=/=/ end=/[,}\]]\@=/ contains=@srExpression extend
syntax region  srDestructuringValueAssignment   contained start=/:/ end=/[,}=]\@=/ contains=srDestructuringPropertyValue,srDestructuringBlock,srNoise,srDestructuringNoise skipwhite skipempty nextgroup=srDestructuringValue extend
syntax match   srDestructuringNoise             contained /[,[\]]/
syntax region  srDestructuringPropertyComputed  contained matchgroup=srDestructuringBraces start=/\[/ end=/]/ contains=@srExpression skipwhite skipempty nextgroup=srDestructuringValue,srDestructuringValueAssignment,srDestructuringNoise extend fold

" Comments
syntax keyword srCommentTodo    contained TODO FIXME XXX TBD NOTE
syntax region  srComment        start=+//+ end=/$/ contains=srCommentTodo,@Spell extend keepend
syntax region  srComment        start=+/\*+  end=+\*/+ contains=srCommentTodo,@Spell fold extend keepend
syntax region  srEnvComment     start=/\%^#!/ end=/$/ display

" Specialized Comments - These are special comment regexes that are used in
" odd places that maintain the proper nextgroup functionality. It sucks we
" can't make srComment a skippable type of group for nextgroup
syntax region  srCommentFunction    contained start=+//+ end=/$/    contains=srCommentTodo,@Spell skipwhite skipempty nextgroup=srFuncBlock,srFlowReturn extend keepend
syntax region  srCommentFunction    contained start=+/\*+ end=+\*/+ contains=srCommentTodo,@Spell skipwhite skipempty nextgroup=srFuncBlock,srFlowReturn fold extend keepend
syntax region  srCommentClass       contained start=+//+ end=/$/    contains=srCommentTodo,@Spell skipwhite skipempty nextgroup=srClassBlock,srFlowClassGroup extend keepend
syntax region  srCommentClass       contained start=+/\*+ end=+\*/+ contains=srCommentTodo,@Spell skipwhite skipempty nextgroup=srClassBlock,srFlowClassGroup fold extend keepend
syntax region  srCommentIfElse      contained start=+//+ end=/$/    contains=srCommentTodo,@Spell skipwhite skipempty nextgroup=srIfElseBlock extend keepend
syntax region  srCommentIfElse      contained start=+/\*+ end=+\*/+ contains=srCommentTodo,@Spell skipwhite skipempty nextgroup=srIfElseBlock fold extend keepend
syntax region  srCommentRepeat      contained start=+//+ end=/$/    contains=srCommentTodo,@Spell skipwhite skipempty nextgroup=srRepeatBlock extend keepend
syntax region  srCommentRepeat      contained start=+/\*+ end=+\*/+ contains=srCommentTodo,@Spell skipwhite skipempty nextgroup=srRepeatBlock fold extend keepend

syntax cluster srExpression  contains=srBracket,srParen,srObject,srTernaryIf,srTaggedTemplate,srTemplateString,srString,srRegexpString,srNumber,srFloat,srOperator,srOperatorKeyword,srBooleanTrue,srBooleanFalse,srNull,srFunction,srArrowFunction,srGlobalObjects,srExceptions,srFutureKeys,srDomErrNo,srDomNodeConsts,srHtmlEvents,srFuncCall,srUndefined,srNan,srPrototype,srBuiltins,srNoise,srClassDefinition,srArrowFunction,srArrowFuncArgs,srParensError,srComment,srArguments,srThis,srSuper,srDo,srForAwait,srAsyncKeyword,srStatement,srDot
syntax cluster srAll         contains=@srExpression,srStorageClass,srConditional,srWhile,srFor,srReturn,srException,srTry,srNoise,srBlockLabel,srBlock

" Define the default highlighting.
let b:current_syntax = "safire"

hi def link srComment              Comment
hi def link srEnvComment           PreProc
hi def link srParensIfElse         srParens
hi def link srParensWhile          srParensRepeat
hi def link srParensFor            srParensRepeat
hi def link srParensRepeat         srParens
hi def link srParensSwitch         srParens
hi def link srParensCatch          srParens
hi def link srCommentTodo          Todo
hi def link srString               String
hi def link srObjectKeyString      String
hi def link srTemplateString       String
hi def link srObjectStringKey      String
hi def link srClassStringKey       String
hi def link srTaggedTemplate       StorageClass
hi def link srTernaryIfOperator    Operator
hi def link srRegexpString         String
hi def link srRegexpBoundary       SpecialChar
hi def link srRegexpQuantifier     SpecialChar
hi def link srRegexpOr             Conditional
hi def link srRegexpMod            SpecialChar
hi def link srRegexpBackRef        SpecialChar
hi def link srRegexpGroup          srRegexpString
hi def link srRegexpCharClass      Character
hi def link srCharacter            Character
hi def link srPrototype            Special
hi def link srConditional          Conditional
hi def link srBranch               Conditional
hi def link srLabel                Label
hi def link srReturn               Statement
hi def link srWhile                srRepeat
hi def link srFor                  srRepeat
hi def link srRepeat               Repeat
hi def link srDo                   Repeat
hi def link srStatement            Statement
hi def link srException            Exception
hi def link srTry                  Exception
hi def link srFinally              Exception
hi def link srCatch                Exception
hi def link srAsyncKeyword         Keyword
hi def link srForAwait             Keyword
hi def link srArrowFunction        Type
hi def link srFunction             Type
hi def link srGenerator            srFunction
hi def link srArrowFuncArgs        srFuncArgs
hi def link srFuncName             Function
hi def link srFuncCall             Function
hi def link srClassFuncName        srFuncName
hi def link srObjectFuncName       Function
hi def link srArguments            Special
hi def link srError                Error
hi def link srParensError          Error
hi def link srOperatorKeyword      srOperator
hi def link srOperator             Operator
hi def link srOf                   Operator
hi def link srStorageClass         StorageClass
hi def link srClassKeyword         Keyword
hi def link srExtendsKeyword       Keyword
hi def link srThis                 Special
hi def link srSuper                Constant
hi def link srNan                  Number
hi def link srNull                 Type
hi def link srUndefined            Type
hi def link srNumber               Number
hi def link srFloat                Float
hi def link srBooleanTrue          Boolean
hi def link srBooleanFalse         Boolean
hi def link srObjectColon          srNoise
hi def link srNoise                Noise
hi def link srDot                  Noise
hi def link srBrackets             Noise
hi def link srParens               Noise
hi def link srBraces               Noise
hi def link srFuncBraces           Noise
hi def link srFuncParens           Noise
hi def link srClassBraces          Noise
hi def link srClassNoise           Noise
hi def link srIfElseBraces         Noise
hi def link srTryCatchBraces       Noise
hi def link srModuleBraces         Noise
hi def link srObjectBraces         Noise
hi def link srObjectSeparator      Noise
hi def link srFinallyBraces        Noise
hi def link srRepeatBraces         Noise
hi def link srSwitchBraces         Noise
hi def link srSpecial              Special
hi def link srTemplateBraces       Noise
hi def link srGlobalObjects        Constant
hi def link srGlobalNodeObjects    Constant
hi def link srExceptions           Constant
hi def link srBuiltins             Constant
hi def link srImport               Include
hi def link srExport               Include
hi def link srExportDefault        StorageClass
hi def link srExportDefaultGroup   srExportDefault
hi def link srModuleAs             Include
hi def link srModuleComma          srNoise
hi def link srModuleAsterisk       Noise
hi def link srFrom                 Include
hi def link srDecorator            Special
hi def link srDecoratorFunction    Function
hi def link srParensDecorator      srParens
hi def link srFuncArgOperator      srFuncArgs
hi def link srClassProperty        srObjectKey
hi def link srObjectShorthandProp  srObjectKey
hi def link srSpreadOperator       Operator
hi def link srRestOperator         Operator
hi def link srRestExpression       srFuncArgs
hi def link srSwitchColon          Noise
hi def link srClassMethodType      Type
hi def link srObjectMethodType     Type
hi def link srClassDefinition      srFuncName
hi def link srBlockLabel           Identifier
hi def link srBlockLabelKey        srBlockLabel

hi def link srDestructuringBraces     Noise
hi def link srDestructuringProperty   srFuncArgs
hi def link srDestructuringAssignment srObjectKey
hi def link srDestructuringNoise      Noise

hi def link srCommentFunction      srComment
hi def link srCommentClass         srComment
hi def link srCommentIfElse        srComment
hi def link srCommentRepeat        srComment

hi def link srDomErrNo             Constant
hi def link srDomNodeConsts        Constant
hi def link srDomElemAttrs         Label
hi def link srDomElemFuncs         PreProc

hi def link srHtmlEvents           Special
hi def link srHtmlElemAttrs        Label
hi def link srHtmlElemFuncs        PreProc

hi def link srCssStyles            Label

