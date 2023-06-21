# Generic-LaTeX-Thesis-Template
A comprehensive and user friendly template for theses of all kinds in any field. 
It is intended to be used with Overleaf.com. Get an account, download the files as a zip file. 
Select New Project -> Upload Projec -> Select a .zip file, and that's it :-)
Or you can select New Project -> Import from GitHub etc.
You may of course use it locally on your computer.

The template requires XeLaTeX as compiler since it relies on the fontspec package. 
If you get an error message like `Fatal Package fontspec Error: The fontspec package requires either XeTeX` then you have chosen the wrong compiler.
In Overleaf, go to the project menu and select XeLaTeX as compiler. 
If you are working locally, the compiling sequence in the command/terminal window is:
* xelatex main
* biber main
* xelatex main
* xelatex main

If you are using an IDE, set up the compiling sequence with the appropriate menu selections.

Happy writing, and may the muse be with you!
