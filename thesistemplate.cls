\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesistemplate}[2021/01/208 Generic Thesis TEmplate 2.0 by gunnar.misund@hiof.no]

%% Book options
\DeclareOption{11pt,a4paper,twoside}{
  \PassOptionsToClass{\CurrentOption}{book}
}

%% Custom package options

% Option master: Master version, default bachelor
\newif\ifmaster
\masterfalse
\DeclareOption{master}{
  \mastertrue
}

% Option sans: Uses HiØ official font "Source Sans Pro", default Latex standard Times Roman
\newif\ifsans
\sansfalse
\DeclareOption{sans}{
  \sanstrue
}

% Option us: Norwegian language, default american
\newif\ifus
\usfalse
\DeclareOption{us}{
  \ustrue
}

% Option other: An other language will be used
\newif\ifother
\otherfalse
\DeclareOption{other}{
  \othertrue
}

% Option word: The ugly M$ standard paragraph formatting, no indentation, one line separation, default: What is considered normal by the rest of the world.
\newif\ifword
\wordfalse
% Uses custom title page provided as "titlepage.pdf", OBS: MUST BE EXACTLY A4 SIZE

\DeclareOption{word}{
  \ClassWarning{hiofthesis}{Your thesis will now look like a standard formatted MicroSoft document, hmmm, up to you.}
  \wordtrue
}

% Option cover: Uses custom title page provided as "titlepage.pdf", OBS: MUST BE EXACTLY A4 SIZE, default HiØ standard thesis title page

\newif\ifcover
\coverfalse

\DeclareOption{cover}{
  \covertrue
}

% Fallback
\DeclareOption*{
  \ClassWarning{myclass}{Unknown option '\CurrentOption'}
}

% Execute default options
\ExecuteOptions{11pt,a4paper,twoside,openright}

% Process given options
\ProcessOptions\relax

% Needs to be included before LoadClass, to avoid package clash
\RequirePackage[hyphens]{url}

% Load base
\LoadClass[11pt,a4paper,twoside]{book}

% Variables for layout geomtry
\def \innerm {25mm} % inner margin
\def \uterm {35mm} % outer margin
\def \topm {30mm} % top margin
\def \bottomm {40mm} % inner margin
\def \headh {14pt} % headheight
%inner=25mm,outer=35mm,top=30mm,bottom=40mm,headheight=14pt

% Load additional packages and commands.

\RequirePackage{fancyhdr,paralist,lipsum,pdfpages,url,nameref,subfigure,wrapfig,tabularx,amssymb,relsize,microtype,xparse,hyperref,float,fullpage,polyglossia,csquotes,listings,dirtytalk,imakeidx,endnotes}

\RequirePackage{xcolor}
\RequirePackage[headsep=2em]{geometry}
\RequirePackage[odd]{emptypage}
\RequirePackage[export]{adjustbox}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage[colorinlistoftodos,obeyDraft]{todonotes}
\RequirePackage[multidot]{grffile}


% Custom headers and footers
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\leftmark}
\fancyhead[RO]{\rightmark}
\fancyfoot[LE,RO]{\thepage}
\renewcommand{\headrulewidth}{0pt}

% Set page style in main matter command
\let\oldmm\mainmatter
\renewcommand{\mainmatter}{\oldmm \pagestyle{fancy}}

%% Source sans pro font
\ifsans
    \RequirePackage[lining,light,default]{sourcesanspro}
    %\RequirePackage[T1]{fontenc}
\fi

% Utilities


\newcommand{\citationstyle}[1]{
    \RequirePackage[
        style=#1,
        backend=biber,
        sorting=ynt
    ]{biblatex}
}

\newcommand{\listingslabel}[1]{
    \newcommand{\thelistingslabel}{#1} 
    \renewcommand{\lstlistlistingname}{#1} 
}

\newcommand{\floatingfigure}[3]{
    \begin{figure}[!htbp]
        \center
        \includegraphics[width=#2\textwidth]{#1}
        \caption{#3}
    \end{figure}
}

\newcommand{\fixedfigure}[3]{
    \begin{figure}[H]
        \center
        \includegraphics[width=#2\textwidth]{#1}
        \caption{#3}
    \end{figure}
}

\newcommand{\doctype}[1]{\newcommand{\dtype}{#1}}
\newcommand{\affiliation}[1]{\newcommand{\aff}{#1}}
\newcommand{\department}[1]{\newcommand{\dep}{#1}}
\newcommand{\place}[1]{\newcommand{\plc}{#1}}
\newcommand{\subtitle}[1]{\newcommand{\subt}{#1}}

%% Title page

\ifcover
    \renewcommand{\maketitle}{
    \pagestyle{empty}
    \includepdf[pages=-]{Cover/coverpage}
    \pagestyle{headings}
    }
\else

    \renewcommand{\maketitle}{
        % Smaller margins on titlepage
        \newgeometry{top=7mm,bottom=15mm,inner=15mm,outer=15mm,headheight=14pt}
        \pagestyle{empty}
        \begin{titlepage}
            \includegraphics[width=0.5\textwidth,right]{Cover/hiof-logo-no}
            \mbox{
                \vtop{
                \vskip 3cm
                \begin{center}
                    \textsf{\fontseries{t}\selectfont \bfseries \Huge \@title\\ \smaller \vskip 1em \subt } \par
    
                \vskip 1cm
                    \textsf{\large \dtype} \par
    
                \vskip 2cm
                     \textsf{\LARGE \@author} \par
    
                \vskip 1cm
                    \textsf{\large \dep\\ \aff\\ \plc\\ \@date } \par
                \end{center}
            }%\mbox
        }
        
        \begin{figure}[!b]
        \includegraphics[width=0.99\textwidth]{Cover/hiof-footer}
        \end{figure}
        
        \null
        \end{titlepage}
        
        \pagestyle{headings}
        \newgeometry{inner=25mm,outer=35mm,top=30mm,bottom=40mm,headheight=14pt}
    }  

\fi %ifcover

% Half-title page

\newcommand{\makehalftitle}{
    
    \newgeometry{inner=25mm,outer=35mm,top=70mm,bottom=40mm,headheight=14pt}
    \pagestyle{empty}
    \cleardoublepage
    \begin{center}
        \textsc{
            \Huge{\@title} \\
            \vskip .5cm
            \LARGE{\subt} 
        }\\
        \vskip 2cm
        \Large{\dtype} \\
        \vskip 5cm
        \LARGE{\@author} \\
        \vskip 2cm
        \large{\large \dep\\ \aff\\ \plc\\ \@date}
    \end{center}

    \cleardoublepage
    \newgeometry{inner=25mm,outer=35mm,top=30mm,bottom=40mm,headheight=14pt}
}  


%% Formatting Word-like paragraphs, must occur after maketitle
\ifword
  \setlength{\parindent}{0em}
  \setlength{\parskip}{1em}
  \raggedright
\fi

%% Set main file
%!TEX root = main.tex

% Add front matter chapters to ToC


%% Common number levels in table of contents
\setcounter{tocdepth}{2}

%% Prevent orphan and widow lines
\widowpenalty10000
\clubpenalty10000
\brokenpenalty10000
\hyphenpenalty10000


%% Code listing style 

\lstdefinestyle{codestyle}{
  %backgroundcolor=\color{backcolour},   
  commentstyle=\color{blue},
  keywordstyle=\color{purple},
  numberstyle=\tiny\color{gray},
  stringstyle=\color{violet},
  basicstyle=\ttfamily\footnotesize,
  breakatwhitespace=false,         
  breaklines=true,                 
  captionpos=b,                    
  keepspaces=true,                 
  numbers=left,                    
  numbersep=5pt,                  
  showspaces=false,                
  showstringspaces=false,
  showtabs=false,                  
  tabsize=2
}

%% Use the above style
\lstset{style=codestyle}

% Making some blank pages
\newcommand{\theend}{
\newpage
\pagestyle{empty}
\mbox{}
\newpage
\mbox{}
\newpage
\mbox{}
\cleardoublepage
}

% To avoid cutting off margin notes like todo's
\makeatletter
\setlength\marginparwidth{\FP@margin}
\addtolength\marginparwidth{-4mm}
\makeatother

% Make some blank pages for sensor notes
\AtEndDocument{
    \theend
}
\endinput