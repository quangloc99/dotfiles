" YAML front matter
syntax match Comment /\%^---\_.\{-}---$/ contains=@Spell

" My unfinished attempt at getting YAML syntax in the front matter
" NOT WORKING
" syntax include @yaml $VIMRUNTIME/syntax/yaml.vim
" syntax region jekyllFrontMatter start=/\%^---/ end=/^---/ contains=@yaml

" Match Liquid Tags and Filters
" syntax match liquidTag /{[{%].*[}%]}/
syntax match liquidValue contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1
syntax region liquidString contained start=+"+ end=+"+
syntax keyword liquidKeyword contained include assign capture increment decrement
syntax keyword liquidKeyword contained if elsif else endif unless endunless
syntax keyword liquidKeyword contained case when
syntax keyword liquidKeyword contained for endfor break continue in offset
syntax keyword liquidKeyword contained comment endcomment raw endraw
syntax region liquidTag start=/{[{%]/ end=/[}%]}/ contains=liquidValue,liquidString,liquidKeyword

" Match the Octopress Backtick Code Block line
" syntax match codeblockContents contained /^\(```\)\@!.*/
" syntax region octoBacktickCodeBlockRegion start=/^```/ end=/^```/ contains=codeblockContents keepend

" Match latexMath
syntax match latexTag contained /\\\i\+/
syntax region latexMath start=/$$\?/ end=/$$\?/ contains=latexTag

" Special handling for Octopress {% codeblock %}
" NOT WORKING
" syntax region octoCodeBlockRegion start=/{%\s*codeblock.*%}/ end=/{%\s*endcodeblock.*%}/ contains=codeblockContents keepend

hi def link codeblockContents									Ignore
hi def link jekyllFrontMatter									Comment
hi def link liquidTag													Statement
hi def link liquidKeyword                     Keyword
hi def link liquidValue                       String
hi def link liquidString                      String
hi def link octoBacktickCodeBlockRegion				Statement
hi def link octoCodeBlockRegion								Statement
hi def link latexMath                         String
hi def link latexTag                          Keyword
