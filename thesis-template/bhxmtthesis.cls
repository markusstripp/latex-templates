\LoadClassWithOptions{scrreprt}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bhxmtthesis}[2023/05/24 Custom report class built on top of scrreprt.]

%% General packages
\RequirePackage[utf8]{inputenc}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{blindtext}
\RequirePackage{framed}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{enumitem}
\RequirePackage[labelfont=bf]{caption}
\RequirePackage[textsize=tiny]{todonotes}
\setlength{\marginparwidth}{2cm}
\RequirePackage{parskip}
\RequirePackage{etoolbox}
\pretocmd{\tableofcontents}{\begingroup\linespread{1.25}\selectfont}{}{} % Onehalf-spacing in the table of contents
\apptocmd{\tableofcontents}{\endgroup}{}{}

%% Colors
\definecolor{aaulight}{RGB}{70,153,194}
\definecolor{aaudark}{RGB}{67,111,128}
\definecolor{aaugray}{gray}{0.95}

%% For typesetting math
\input{../math-commands.sty}

\RequirePackage[charter]{mathdesign}

%% For typesetting algorithms
\RequirePackage[chapter]{algorithm}
\RequirePackage{algpseudocode}
\renewcommand*\Call[2]{\textproc{#1}(#2)} % For nested calls
\renewcommand{\algorithmicrequire}{\textbf{Input:}}
\renewcommand{\algorithmicensure}{\textbf{Output:}}
\newenvironment{breakablealgorithm}{ % For algorithms going over the end of a page
	\begin{center}
		\refstepcounter{algorithm}
        \renewcommand{\caption}[1]{
			\addcontentsline{loa}{algorithm}{\protect\numberline{\thealgorithm}##1}
            \parbox{\textwidth}
            		% Makes a unbreakable block and can also be done by `minipage`
            		{\hrule height.8pt depth0pt \kern2pt
				{\raggedright\textbf{\fname@algorithm~\thealgorithm} ##1\par}
				\kern2pt\hrule\kern2pt
            } \vspace*{-\baselineskip}
        }
}{%
	\kern2pt\hrule\relax
    \end{center}
}

%% For typesetting code listings                                                
\RequirePackage{listings}
\lstdefinelanguage{Sage}[]{Python}
	{morekeywords={False,sage,True},sensitive=true}
\lstset{
	frame=None,
	breaklines=True,
	postbreak=\mbox{\textcolor{codegray}{$\hookrightarrow$}\space},
	showtabs=False,
	showspaces=False,
	showstringspaces=False,
	backgroundcolor=\color{aaugray},
	commentstyle={\ttfamily\color{codegreen}},
	keywordstyle={\ttfamily\color{codeblue}\bfseries},
	stringstyle={\ttfamily\color{codegray}\bfseries},
	language=Sage,
	basicstyle={\scriptsize\linespread{1.25}\ttfamily},
	aboveskip=0.3em,
	belowskip=0.1em,
	numbers=left,
	numberstyle={\tiny\color{gray}}
}

\definecolor{codeblue}{rgb}{0.01,0.02,0.7}
\definecolor{codegreen}{rgb}{0.2,0.4,0.0}
\definecolor{codegray}{rgb}{0.30,0.3,0.30}

%% Defining headings
\RequirePackage{fullpage}
\RequirePackage[Bjornstrup]{fncychap}
\ChTitleVar{\raggedright\Huge\sffamily\bfseries}
\ChNumVar{\fontsize{76}{80}\selectfont\color{black}}
\renewcommand{\DOTIS}[1]{% Customize \chapter*{} 
	\fboxsep=0pt
    {\rule{0pt}{40pt}\parbox[b]{\textwidth}{\hfill}}\\%
    \nointerlineskip\raggedright%
    \fboxsep=\myhi%
    {\parbox[t]{\mylen}{\CTV\FmTi{#1}}}\par\nobreak%
    \par\noindent\rule{\textwidth}{2pt}%\includegraphics[scale=1]{testthesis.pdf} 
    \vskip 0\p@%
}

\renewcommand{\DOTI}[1]{% Customize \chapter{} 
	\nointerlineskip\raggedright%
    \fboxsep=\myhi%
    \vskip-1ex%
    {\parbox[t]{\mylen}{\CTV\FmTi{#1}}}\par\nobreak%
    \par\noindent\rule{\textwidth}{2pt}
    \vskip 40\p@%
}

\renewcommand{\DOCH}{%
    \settowidth{\py}{\CNoV\thechapter}
    \addtolength{\py}{-10pt} % Amount of space by which the number is shifted right
    \fboxsep=0pt%
    {\rule{0pt}{40pt}\parbox[b]{\textwidth}{\hfill}}%
    \kern-\py\raise20pt%
    \hbox{\CNoV\thechapter}\\%
}

\newcommand{\introchapter}[1]{
	\renewcommand{\DOTIS}[1]{% Set correct style
	\vskip -100\p@%
    \fboxsep=0pt
    {\rule{0pt}{40pt}\parbox[b]{\textwidth}{\hfill}}\\%
    \nointerlineskip\raggedright%
    \fboxsep=\myhi%
    {\parbox[t]{\mylen}{\CTV\FmTi{##1}}}\par\nobreak%
    \vskip -20\p@%
	}
	
	\ChTitleVar{\centering\huge\sffamily\bfseries}
	\chapter*{#1}
	\thispagestyle{scrheadings}
	
	\renewcommand{\DOTIS}[1]{% Reset style
    \fboxsep=0pt
    {\rule{0pt}{40pt}\parbox[b]{\textwidth}{\hfill}}\\%
    \nointerlineskip\raggedright%
    \fboxsep=\myhi%
    {\parbox[t]{\mylen}{\CTV\FmTi{##1}}}\par\nobreak%
    \par\noindent\rule{\textwidth}{2pt}
    \vskip 0\p@%
	}
	\ChTitleVar{\raggedright\Huge\sffamily\bfseries}
}

\renewcommand{\addchap}[1]{% command for unnumbered \chapter (that is added in toc and to the header)
	\clearpage \phantomsection % \addchap of Koma script would destroy formatting
	\addcontentsline{toc}{chapter}{#1}
	\chapmark{#1} % Custom command to mark \chapter* for header
	\chapter*{#1}
}



%% Header and footer
\RequirePackage[autooneside=false, automark]{scrlayer-scrpage} 
\pagestyle{scrheadings} 
\clearpairofpagestyles 
\ihead{\textnormal{\headmark}}
\ohead[\pagemark]{\pagemark} 
\KOMAoptions{headsepline = true} 
\renewcommand*\chapterpagestyle{empty}
\setlength{\headsep}{\baselineskip}
\RequirePackage[left=2.5cm,right=2.5cm,top=3cm,bottom=3cm,includehead]{geometry}

\let\oldchaptermarkformat\chaptermarkformat % Save \chaptermarkformat
\newcommand{\chapmark}[1]{ % To mark \chapter* for the header
	\renewcommand*{\chaptermarkformat}{} % Remove numbering of chapter in header
	\chaptermark{#1}
	\renewcommand*{\chaptermarkformat}{\oldchaptermarkformat} % Add numbering of chapter in header
}

%% Math environments
\newtheoremstyle{deftheoremproof} 
	{\topsep}{\topsep}
	{}{}
	{\bfseries}{.}
	{\newline}{}
\theoremstyle{deftheoremproof} 
\newtheorem{definition}{Definition}[chapter]
\newtheorem*{definition*}{Definition}
\newtheorem{theorem}[definition]{Theorem}
\newtheorem*{theorem*}{Theorem}
\newtheorem{examplex}[definition]{Example}
\newenvironment{example}{\pushQED{\qed}\renewcommand{\qedsymbol}{$\triangle$}\examplex}{\popQED\endexamplex}
\newtheorem{proposition}[definition]{Proposition}
\newtheorem*{proposition*}{Proposition}
\newtheorem{lemma}[definition]{Lemma}
\newtheorem*{lemma*}{Lemma}
\newtheorem{corollary}[definition]{Corollary}
\newtheorem*{corollary*}{Corollary}
\newtheorem{remark}[definition]{Remark}
\newtheorem*{remark*}{Remark}
\newtheorem{notation}[definition]{Notation}
\newtheorem*{notation*}{Notation}

%% References
\RequirePackage[
	backend=biber, 
	bibstyle=mtnumeric, 
	natbib=true, 
	hyperref=true
]{biblatex}
\addbibresource{thesis-template.bib}
\setlength{\bibitemsep}{6.0pt plus 3.0pt minus 1.5pt}
\nocite{*}
\let\oldprintbibliography\printbibliography
\renewcommand{\printbibliography}{% adds new page and correct reference for the table of contents
	\clearpage \phantomsection
	\addcontentsline{toc}{chapter}{Bibliography}
	\oldprintbibliography
}
\RequirePackage{csquotes}

\RequirePackage{hyperref}

%% ===================================================
%% More technical commands (comes from 'bhthesis.cls')

\newif\if@english\@englishfalse
\newif\if@withdegree\@withdegreefalse

\DeclareOption{english}{
  \@englishtrue
}
\DeclareOption{withdegree}{
  \@withdegreetrue
}
\ProcessOptions

%
% Data to appear on the title page
% \author and \title are defined by the latex kernel
%
\newcommand{\person}[4][]{
  \begin{minipage}[t]{#2}
    #1\fontsize{14}{18}\selectfont
    {\textsc{#3}}\\
    \fontsize{12}{14}\selectfont
    #4
  \end{minipage}
}

\gdef\@authorname{}
\gdef\@authornameone{}
\gdef\@authornamemore{}
\renewcommand\author[1]{\gdef\@author{#1}
  \let\@authorname\@authornameone}
\newcommand\authors[1]{\gdef\@author{#1}
  \let\@authorname\@authornamemore}
\renewcommand*{\@extratitle}{}
\renewcommand{\extratitle}[1]{\gdef\@extratitle{#1}}
\gdef\@reporttype{}
\newcommand \reporttype[1]{\gdef \@reporttype{#1}}
\gdef\@university{}
\newcommand \university[1]{\gdef \@university{#1}}
\gdef\@universityname{}
\newcommand \universityname[1]{\gdef \@universityname{#1}}
\gdef\@fakultaetname{}
\newcommand \fakultaetname[1]{\gdef \@fakultaetname{#1}}
\gdef\@studname{}
\newcommand \studname[1]{\gdef \@studname{#1}}
\gdef\@degree{{\bfseries\color{red} degree}}
\newcommand \degree[1]{\gdef \@degree{#1}}
\renewcommand{\and}{$\;\cdot\;$}
\gdef\@institute{}
\newcommand \institute[1]{\gdef \@institute{#1}}
\gdef\@involvedpeople{}
\newcommand \involvedpeople[1]{\gdef \@involvedpeople{#1}}
\gdef\@city{Klagenfurt}
\newcommand \city[1]{\gdef \@city{#1}}
\renewcommand*{\next@tpage}{\clearpage\thispagestyle{empty}}

%
% title page format
%
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}} % Bold Line
\if@titlepage
    \renewcommand*\maketitle[1][1]{\begin{titlepage}%
    \setcounter{page}{#1}
    \let\footnotesize\small
    \let\footnoterule\relax
    \let\footnote\thanks
    \renewcommand*\thefootnote{\@fnsymbol\c@footnote}%
    \let\@oldmakefnmark\@makefnmark
    \def\@makefnmark{\rlap\@oldmakefnmark}
    \ifx\@extratitle\@empty \else
        \noindent\@extratitle\next@tpage\cleardoublepage\thispagestyle{empty}
    \fi
    \large
    %
    % center logo (or not)
    %
    \ifx\@university\@empty\else
      \@university\par
      \vskip 1em
    \fi
    \begin{center}
    \fontsize{12}{14}\selectfont
    {\lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em
    \HRule\par
    {\lineskip .5em%
     \sectfont\Huge
      \begin{tabular}[t]{c}%
        \@title
      \end{tabular}\par}%
    \HRule\par
    \vskip 2em
    {\huge\textsc{\@reporttype}}
    \vskip 1em
    \if@withdegree
      \if@english
        submitted in fulfilment of the requirements for the degree of \\[0.5em]
      \else
        zur Erlangung des akademischen Grades \\[0.5em]
      \fi
      \@degree
    \else\fi
    \vfill
    {\textsc{\if@english Degree Programme\else Studium\fi}}\\[0.25em]
    {\Large\@studname}
    \vfill
    \@universityname \\[0.2em]
    \@fakultaetname
    \vfill
    \@involvedpeople


    \vfill
    \fontsize{12}{12}\selectfont
    \hfill \@city, \@date
  \end{center}\par
  \pagestyle{empty}
  \cleardoublepage
  \end{titlepage}
    % \@thanks
    % \null
    % \if@twoside\next@tpage
    %     \noindent\begin{minipage}[t]{\textwidth}
    %     \@uppertitleback
    %     \end{minipage}\par
    %     \vfill
    %     \noindent\begin{minipage}[b]{\textwidth}
    %     \@lowertitleback
    %     \end{minipage}
    % \fi
    % \ifx\@dedication\@empty \else
    %     \next@tpage\null\vfill
    %     {\centering \Large \@dedication \par}
    %     \vskip \z@ \@plus3fill
    %     \if@twoside \next@tpage\cleardoublepage \fi
    % \fi
    % \end{titlepage}
    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\@title\@empty
    \global\let\@reporttype\@empty
    \global\let\@university\@empty
    \global\let\@institute\@empty
    \global\let\@city\@empty
    \global\let\@version\@empty
    \global\let\@uppertitleback\@empty
    \global\let\@lowertitleback\@empty
    \global\let\@dedication\@empty
    \global\let\author\relax
    \global\let\title\relax
    \global\let\date\relax
    \global\let\reporttype\@empty
    \global\let\university\@empty
    \global\let\universityname\@empty
    \global\let\institute\@empty
    \global\let\city\@empty
    \global\let\version\@empty
    \global\let\and\relax}
\else
     \newcommand*\maketitle[1][1]{%\par
       \@tempcnta=#1\relax\ifnum\@tempcnta=1\else
         \ClassWarning{kluconf}
                      {Optional argument of \string\maketitle\space ignored
                       at\MessageBreak
                       notitlepage-mode}\fi
       \begingroup
         \renewcommand*\thefootnote{\@fnsymbol\c@footnote}%
         \let\@oldmakefnmark\@makefnmark
         \def\@makefnmark{\rlap\@oldmakefnmark}
         \if@twocolumn
           \ifnum \col@number=\@ne
             \@maketitle
           \else
             \twocolumn[\@maketitle]%
           \fi
         \else
           \newpage
           \global\@topnum\z@   % Prevents figures from going at top of page.
           \@maketitle
         \fi
         \thispagestyle{empty}\@thanks
       \endgroup
       \setcounter{footnote}{0}%
       \let\thanks\relax
       \let\maketitle\relax
       \let\@maketitle\relax
       \global\let\@thanks\@empty
       \global\let\@author\@empty
       \global\let\@date\@empty
       \global\let\@title\@empty
       \global\let\@reporttype\@empty
       \global\let\@university\@empty
       \global\let\@institute\@empty
       \global\let\@city\@empty
       \global\let\@version\@empty
       \global\let\@uppertitleback\@empty
       \global\let\@lowertitleback\@empty
       \global\let\@dedication\@empty
       \global\let\author\relax
       \global\let\title\relax
       \global\let\date\relax
       \global\let\reporttype\@empty
       \global\let\university\@empty
       \global\let\institute\@empty
       \global\let\city\@empty
       \global\let\version\@empty
       \global\let\and\relax}
\fi
\def\@maketitle{%
  \clearpage
  \let\footnote\thanks
  \begingroup
  \parskip\z@ \parsep\z@
  \ifx\@extratitle\@empty \else
      \noindent\@extratitle \next@tpage \if@twoside \null\next@tpage \fi
  \fi
  \begin{center}%
    \@university\par
    \ifx\@reporttype\@empty \else
        \vskip 1em
  {\sc\@reporttype}\par
    \fi
    \vskip 1em
    {\sectfont\huge \@title \par}%
    \vskip 15pt%
    {\lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 15pt%
    \@date \par%
    \vskip \z@ \@plus 1em
    \ifx\@dedication\@empty \else
        \vskip 2em
        {\Large \@dedication \par}
    \fi
  \end{center}%
  \par
  \vskip 30pt
  \endgroup
}