# Smarty plugin for Vim

This plugin provides syntax highlighting, indenting and general filetype settings for the Smarty templating language.

This is a fork of [Vim Script #1798](http://www.vim.org/scripts/script.php?script_id=1798)
(see the original README below).

## Enhancements

The following (probably incomplete) list of enhancements are provided:

 * Various improvements throughout the syntax handling.
 * `{php}…{/php}` blocks are delegated to PHP syntax.
 * `filetype` is set to "smarty" for `*.tpl` files.
 * syntax is based on HTML filetype.
 * matchit (jumping between tags via `%`) is configured for Smarty tags
   (`{foo}` .. `{/foo}`), and based on the html setup.
 * line endings have been converted to unix fileformat (to prevent
   parse errors on Linux/Mac).
 * Smarter indenting, handling PHP blocks and delegating to HTML (includes
   JavaScript).

## About Smarty
[Smarty](http://www.smarty.net/) is a PHP template language.

## About this fork
I am not using Smarty that much (anymore), but wanted to get these enhancements
published, for others to pick them up.

[Pull requests](https://github.com/blueyed/smarty.vim) are welcome, of course.


# Original README
This is a mirror of http://www.vim.org/scripts/script.php?script_id=1798

A friend and I found that there were no acceptable vim syntax files for smarty, so we took the only one we could find and added everything from the smarty documentation (http://smarty.php.net/manual/en) to it.  If nothing else, this is a very good start on a complete smarty syntax file.  We have even used vimtip #498 to use autocomplete with this syntax and so far it seems to work well.
