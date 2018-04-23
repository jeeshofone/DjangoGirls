rule 'MD001' # header levels increment by 1
rule 'MD002' # first header should be level 1
rule 'MD003', style: :atx # header style - atx
rule 'MD004', style: :dash # unordered list style - dash
rule 'MD005' # don't allow inconsistent indentation for list items
rule 'MD006' # start bullets at beginning of line
rule 'MD007', indent: 4 # unordered list indentation should be 4 spaces
rule 'MD009' # trailing spaces not allowed
rule 'MD010' # hard tabs not allowed
rule 'MD011' # alert on reversed link syntax
rule 'MD012' # alert on multiple consecutive blank lines
# line length is ignored. Mostly because badges usually have long lines
rule 'MD013', line_length: false
rule 'MD014' # dollars signs not before commands w/o showing output
rule 'MD018' # must have space after header style
rule 'MD019' # no multiple spaces after header style
rule 'MD022' # headers should be surrounded by blank lines
rule 'MD023' # headers must start at the beginning of the line
rule 'MD024' # no multiple headers with same content
rule 'MD025' # only 1 level 1 header
rule 'MD026' # no trailing punctuation in headers
rule 'MD027' # no multiple spaces after blockquote symbol
rule 'MD028' # no blank lines within blockquote
rule 'MD029', style: :ordered # ordered list item prefix, shoulded be ordered
# spaces after list markers
rule 'MD030', ul_single: 1, ul_multi: 3, ol_single: 1, ol_multi: 2
rule 'MD031' # fenced code blocks need line surrounding
rule 'MD032' # lists should be surrounded by line
rule 'MD033' # No inline HTML
rule 'MD034' # Bare URL used
rule 'MD035', style: '---' # Horizontal rule style
rule 'MD036' # Emphasis used instead of a header
rule 'MD037' # Spaces inside emphasis markers
rule 'MD038' # Spaces inside code span elements
rule 'MD039' # Spaces inside link text
rule 'MD040' # Fenced code blocks should have a language specified
