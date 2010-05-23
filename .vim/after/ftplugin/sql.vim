call PreHandlerHook()

" We almost always work with MySQL, so default to it.
" XXX using this after starting the buffer is fine, here it errors out
"SQLSetType mysql

setl tabstop=2 shiftwidth=2 expandtab
if has("folding") 
	setl foldmethod=indent
endif

" define buffer local abbreviations to auto-capitalize keywords
iab <buffer> all ALL
iab <buffer> alter ALTER
iab <buffer> and AND
iab <buffer> as AS
iab <buffer> between BETWEEN
iab <buffer> by BY
iab <buffer> create CREATE
iab <buffer> database DATABASE
iab <buffer> delete DELETE
iab <buffer> distinct DISTINCT
iab <buffer> drop DROP
iab <buffer> from FROM
iab <buffer> full FULL
iab <buffer> group GROUP
iab <buffer> having HAVING
iab <buffer> in IN
iab <buffer> index INDEX
iab <buffer> inner INNERY
iab <buffer> insert INSERT
iab <buffer> into INTO
iab <buffer> join JOIN
iab <buffer> left LEFT
iab <buffer> like LIKE
iab <buffer> or OR
iab <buffer> order ORDER
iab <buffer> right RIGHT
iab <buffer> select SELECT
iab <buffer> table TABLE
iab <buffer> top TOP
iab <buffer> truncate TRUNCATE
iab <buffer> union UNION
iab <buffer> update UPDATE
iab <buffer> view VIEW
iab <buffer> where WHERE

call PostHandlerHook()
