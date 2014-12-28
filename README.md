# meleme

An experiment to see if I can annotate, and ultimately customize,
Emacs' mode line.

To use it, eval or add to your .emacs:

    (require 'meleme)

Then run `M-x meleme`.  What you'll get is a buffer named `*meleme*`
with the components of your mode-line, what's actually produced by
each component, and (where possible) documentation for the component.
At the moment, the output is in an org-mode table.

# License

GPL v3.0, baby!

# Thanks

* The [JavaScript Random Project Name Generator] for the name "meleme".

# TODO

- note which output is empty
- split window automagically
- ert-runner for tests; meleme-analyze would be a good place to start
- ASCII art to show what part of the modeline comes from what

# Reference

- [Variable and function docstring][1]
- [My original question][2]
- [modeline-posn][3]
- [format-mode-line][4]

[0]: http://mrsharpoblunto.github.io/foswig.js/
[1]: https://emacs.stackexchange.com/questions/3631/how-to-retrieve-docstrings-from-functions-and-variables
[2]: https://emacs.stackexchange.com/questions/2097/how-can-i-find-out-exactly-what-my-modeline-is-telling-me
[3]: http://www.emacswiki.org/emacs/modeline-posn.el
[4]: https://www.gnu.org/software/emacs/manual/html_node/elisp/Emulating-Mode-Line.html
