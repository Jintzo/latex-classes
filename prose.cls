\ProvidesClass{prose}[2019/02/23 v1.6 prose class (Jens Ochsenmeier)]
\NeedsTeXFormat{LaTeX2e}[1996/06/01]
\LoadClass[a4paper, oneside]{report}

% Packages
\RequirePackage[top=2cm, bottom=2cm, outer=2cm, inner=2cm, heightrounded]{geometry}
\RequirePackage{xcolor}
\RequirePackage[clearempty,pagestyles,newlinetospace,nobottomtitles]{titlesec}
\RequirePackage{titletoc}
\RequirePackage[fleqn]{mathtools}
\RequirePackage{enumitem}
\RequirePackage{setspace}
\RequirePackage{booktabs}
\RequirePackage[utf8]{inputenc}
\RequirePackage{tcolorbox}

\RequirePackage{listings}

% fonts
\RequirePackage{stmaryrd}
\RequirePackage{lmodern}
\RequirePackage{libertine}
\RequirePackage[libertine]{newtxmath}
\RequirePackage{courier}
\RequirePackage[T1]{fontenc}
\renewcommand{\familydefault}{\sfdefault}

\RequirePackage{wrapfig}
\RequirePackage[eqno]{tabfigures}
\RequirePackage[backend=biber,style=alphabetic,sorting=ynt]{biblatex}
\RequirePackage{index}
\RequirePackage[pdfstartview={FitH},pdfborder={0 0 0},hyperindex=false]{hyperref}
\RequirePackage[compatibility=true,font={footnotesize,it}]{caption}
\RequirePackage{floatrow}
\RequirePackage[hyperref,amsmath]{ntheorem}
\RequirePackage[capitalise]{cleveref}

\RequirePackage[ngerman]{babel}

% Accent
\definecolor{accent}{rgb}{0.45,0.45,0.45}
\DeclareOption{green}{\definecolor{accent}{rgb}{0,0.65,0.37}}
\DeclareOption{red}{\definecolor{accent}{rgb}{0.75,0.22,0.22}}
\DeclareOption{orange}{\definecolor{accent}{rgb}{1, 0.6, 0}}
\DeclareOption{blue}{\definecolor{accent}{rgb}{0, 0.2, 0.6}}
\DeclareOption{purple}{\definecolor{accent}{rgb}{0.65,0,0.37}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
 
% Support for discretionary breakpoints and suppression of italic correction

\newcommand{\dbr}{\discretionary{}{}{}}
\newcommand{\nocorr}{\kern0pt}


% Glyph-to-Unicode Translation for searching in PDFs (needs PdfTex >=1.4)

\InputIfFileExists{glyphtounicode}{\pdfgentounicode=1}{}


% Ornaments

\newcommand{\mydiss@diamond}{\textbullet}

% Header/Footer
\newpagestyle{main}{
  \sethead[\small\itshape\ifthechapter{\thechapter\enspace}{}\chaptertitle][][]%
    {}{}{\small\itshape\ifthesection{\thesection\enspace}{}\sectiontitle}
  \setfoot*{}{}{\thepage}
}
\newpagestyle{nosub}{
  \sethead[\small\itshape\ifthechapter{\thechapter\enspace}{}\chaptertitle][][]%
    {}{}{\small\itshape\ifthechapter{\thechapter\enspace}{}\chaptertitle}
  \setfoot*{}{}{\thepage}
}
\renewpagestyle{plain}{
  \setfoot*{}{}{\thepage}
}
\pagestyle{main}

% Line spread
\newcommand{\diss@spread}{1.25}
\setstretch{\diss@spread}
\setlength{\parskip}{\baselineskip}
\newcommand{\@minipagerestore}{\setlength{\parskip}{\baselineskip}}

% Indentation
\newlength{\diss@indent}
\setlength{\diss@indent}{1.5em}
\setlength{\parindent}{0px}
\setlength{\mathindent}{\diss@indent}

\renewcommand\@makefntext[1]{\noindent\makebox[\diss@indent][r]{\@makefnmark}%
  \setstretch{\diss@spread} #1}

% Penalties
\pretolerance=60
\tolerance=2000
\widowpenalty=9999
\interdisplaylinepenalty=100
\interfootnotelinepenalty=1000
\predisplaypenalty=50


% Title

\renewcommand{\title}[1]{%
  \gdef\@title{#1}%
  \pdfstringdef{\@pdftitle}{\@title}%
  \hypersetup{pdftitle=\@pdftitle}%
}
\renewcommand{\author}[1]{%
  \gdef\@author{#1}%
  \pdfstringdef{\@pdfauthor}{\@author}%
  \hypersetup{pdfauthor=\@pdfauthor}%
}


% Sectioning

\providecommand{\figureversion}[1]{}

\setcounter{secnumdepth}{1}

\newcommand{\periodafter}[1]{#1.}

\titleformat{\section}[hang]{\normalfont\Large\bfseries}{\thesection}{.5em}{}
\titleformat{\subsection}[hang]{\normalfont\large\itshape}{\thesubsection}{.5em}{}
\titleformat{\subsubsection}[runin]{\normalfont\itshape}{\thesubsubsection}%
  {.5em}{\periodafter}

%CHAPTER
\titleformat{\chapter}[hang]
{
%\setcounter{satz}{0}
\Huge\centering\scshape}
{\color{accent}{\rmfamily\bfseries\thechapter}\huge: }
{0pt}
{\huge}
\titlespacing*{\chapter}{0pt}{0pt}{2em}


% Floats

\renewcommand{\arraystretch}{\diss@spread}
\renewcommand{\topfraction}{0.9}
\renewcommand{\textfraction}{0.1}

\setlength{\heavyrulewidth}{0.05em}
\setlength{\lightrulewidth}{0.03em}
\captionsetup{labelfont=bf,labelsep=period,textformat=period,font={footnotesize}}
\DeclareFloatVCode{toprule}{%
  \hrule height\heavyrulewidth\vskip 1ex%
}
\DeclareFloatVCode{topprule}{%
  \hrule height\heavyrulewidth\vskip 1.5ex%
}
\DeclareFloatVCode{midrule}{%
  \vskip 1ex\hrule height\lightrulewidth\vskip 1ex%
}
\DeclareFloatVCode{endrule}{%
  \vskip 1ex\hrule height\heavyrulewidth%
}
\captionsetup[ruled]{labelfont=bf,labelsep=period,textformat=period,font=spread}
\DeclareNewFloatType{algorithm}{placement=tbp,name=Algorithm,fileext=loa,within=chapter}
\contentsuse{algorithm}{loa}
\newcommand{\listofalgorithms}{\listof{algorithm}{List of Algorithms}}
\floatsetup[algorithm]{style=ruled,precode=toprule,midcode=midrule,postcode=endrule}
%\floatsetup[figure]{precode=topprule,postcode=endrule}
\floatsetup[table]{capposition=top}

\newcommand{\keyw}[1]{\textbf{#1}}


% Table of Contents

\titlecontents{chapter}[1pc]%
  {\addvspace{2ex}\Large\filright}%
  {\contentslabel[\figureversion{tab}\thecontentslabel]{1pc}}{\hspace*{-1pc}}%
  {\nolinebreak\enskip\nolinebreak\mydiss@diamond\nolinebreak%
    \enspace\nolinebreak\thecontentspage}[]
\titlecontents{section}[2.4pc]{\filright}%
  {\contentslabel[\figureversion{tab}\thecontentslabel]{1.4pc}}{\hspace*{-1.4pc}}%
  {\nolinebreak\enskip\nolinebreak\mydiss@diamond\nolinebreak%
    \enspace\nolinebreak\thecontentspage}[]
\setcounter{tocdepth}{1}


% List of Figures etc.

\titlecontents{figure}[1.4pc]{\filright}%
  {\contentslabel[\figureversion{tab}\thecontentslabel]{1.4pc}}{\hspace*{-1.4pc}}%
  {\nolinebreak\enskip\nolinebreak\mydiss@diamond\nolinebreak%
    \enspace\nolinebreak\thecontentspage}[]
\titlecontents{table}[1.4pc]{\filright}%
  {\contentslabel[\figureversion{tab}\thecontentslabel]{1.4pc}}{\hspace*{-1.4pc}}%
  {\nolinebreak\enskip\nolinebreak\mydiss@diamond\nolinebreak%
    \enspace\nolinebreak\thecontentspage}[]
\titlecontents{algorithm}[1.4pc]{\filright}%
  {\contentslabel[\figureversion{tab}\thecontentslabel]{1.4pc}}{\hspace*{-1.4pc}}%
  {\nolinebreak\enskip\nolinebreak\mydiss@diamond\nolinebreak%
    \enspace\nolinebreak\thecontentspage}[]


% References

\crefformat{equation}{#2(#1)#3}
\Crefformat{equation}{Eq.~#2(#1)#3}
\crefrangeformat{equation}{#3(#1)#4--#5(#2)#6}
\Crefrangeformat{equation}{Eqs.~#3(#1)#4--#5(#2)#6}
\crefmultiformat{equation}{#2(#1)#3}{\crefpairconjunction#2(#1)#3}%
  {, #2(#1)#3}{\creflastconjunction#2(#1)#3}
\Crefmultiformat{equation}{Eqs.~#2(#1)#3}{\crefpairconjunction#2(#1)#3}%
  {, #2(#1)#3}{\creflastconjunction#2(#1)#3}
\crefrangemultiformat{equation}{#3(#1)#4--#5(#2)#6}%
  {\crefpairconjunction#3(#1)#4--#5(#2)#6}{, #3(#1)#4--#5(#2)#6}%
  {\creflastconjunction#3(#1)#4--#5(#2)#6}
\Crefrangemultiformat{equation}{Eqs.~#3(#1)#4--#5(#2)#6}%
  {\crefpairconjunction#3(#1)#4--#5(#2)#6}{, #3(#1)#4--#5(#2)#6}%
  {\creflastconjunction#3(#1)#4--#5(#2)#6}

\crefname{algorithm}{Algorithm}{Algorithms}
\crefname{figure}{Figure}{Figures}


% Theorems

% Styles

\newtheoremstyle{definition}%
  {\item[\hskip\labelsep\normalfont\bfseries ##1~##2.]}%
  {\item[\hskip\labelsep\normalfont\bfseries ##1~##2\normalfont\ (##3).]}

\newtheoremstyle{nonumberdefinition}%
  {\item[\hskip\labelsep\normalfont\bfseries ##1.]}%
  {\item[\hskip\labelsep\normalfont\bfseries ##1\normalfont\ (##3).]}

\newtheoremstyle{remark}%
  {\item[\hskip\labelsep\normalfont\itshape ##1~##2.]}%
  {\item[\hskip\labelsep\normalfont\itshape ##1~##2\/\normalfont\ (##3).]}

\newtheoremstyle{nonumberremark}%
  {\item[\hskip\labelsep\normalfont\itshape ##1.]}%
  {\item[\hskip\labelsep\normalfont\itshape ##1\/\normalfont\ (##3).]}

\newtheoremstyle{smalltheorem}
  {\item[\hskip\labelsep\normalfont\itshape\small ##1.]}
  {\item[\hskip\labelsep\normalfont\itshape\small ##1\/\normalfont\small\ (##3).]}
  {\normalfont\small}
\AtBeginEnvironment{proof}{\small}
\AtBeginEnvironment{solution}{\small}
% Declarations
\theorembodyfont{\normalfont}
\theoremstyle{definition}
\theorempostskip{1.8em}

\newtheorem{definition}{Definition}[section]
\renewtheorem*{definition*}{Definition}
\crefname{definition}{Definition}{Definitionen}

\newtheorem{proposition}[definition]{Proposition}
\renewtheorem*{proposition*}{Proposition}
\crefname{proposition}{Proposition}{Propositionen}

\newtheorem{lemma}[definition]{Lemma}
\renewtheorem*{lemma*}{Lemma}
\crefname{lemma}{Lemma}{Lemmas}

\newtheorem{theorem}[definition]{Satz}
\renewtheorem*{theorem*}{Satz}
\crefname{theorem}{Satz}{Sätze}

\newtheorem{corollary}[definition]{Korollar}
\renewtheorem*{corollary*}{Korollar}
\crefname{corollary}{Korollar}{Korollare}

\newtheorem{example}[definition]{Beispiel}
\renewtheorem*{example*}{Beispiel}
\crefname{example}{Beispiel}{Beispiele}

\newtheorem{problem}{Aufgabe}[section]
\renewtheorem*{problem*}{Aufgabe}
\crefname{problem}{Aufgabe}{Aufgaben}
\renewcommand{\theproblem}{\arabic{problem}}

\newtheorem{remark}[definition]{Bemerkung}
\renewtheorem*{remark*}{Bemerkung}
\crefname{remark}{Bemerkung}{Bemerkungen}

\newtheorem{excourse}[definition]{Exkurs}
\renewtheorem*{excourse*}{Exkurs}
\crefname{excourse}{Exkurs}{Exkurse}

\newtheorem{addition}[definition]{Ergänzung}
\renewtheorem*{addition*}{Ergänzung}
\crefname{addition}{Ergänzung}{Ergänzungen}

\newtheorem{deduction}[definition]{Folgerung}
\theoremstyle{nonumberremark}

\newtheorem{claim}[definition]{Behauptung}
\theoremstyle{smalltheorem}

\newtheorem{proof}{Beweis}
\newtheorem{solution}{Lösung}

% QED symbol
\renewcommand{\qedsymbol}{$\square$}
\newcommand{\mathqed}{}
\DeclareRobustCommand{\qed}{%
  \ifmmode \mathqed
  \else
    \leavevmode\unskip\penalty9999 \hbox{}\nobreak\hfill
    \quad\hbox{\qedsymbol}%
  \fi  
}


% Lists

\setlist{leftmargin=\diss@indent,labelsep=3pt,topsep=\parsep,
  parsep=\parskip,itemsep=\parskip}%

\setenumerate{label={\figureversion{tab}\arabic*.},ref=\arabic*}
%\setenumerate{label={\openbullet{\arabic*}},ref=\arabic*}
\renewcommand{\labelitemii}{--}
\renewcommand{\labelitemiii}{--}
\renewcommand{\labelitemiv}{--}


% Quotes

\renewenvironment{quote}{%
  \begin{list}{}{%
    \setlength\leftmargin{\diss@indent}%
    \setlength\rightmargin{\diss@indent}%
    \setlength\parsep{\parskip}%
    \setlength\itemsep{0pt}%
  }%
  \item%
}{\end{list}}

\renewenvironment{quotation}{%
\begin{list}{}{%
    \setlength\leftmargin{\diss@indent}%
    \setlength\rightmargin{\diss@indent}%
    \setlength\parsep{\parskip}%
    \setlength\itemsep{0pt}%
  }%
  \item%
}{\end{list}}


% Indexing

\newindex{default}{idx}{ind}{Index}
\newindex{symbols}{sdx}{snd}{Notation}

\newcommand{\symb}[2][]{\index[symbols]{#2}\@ifempty{#1}{}{\index[symbols]{#2|desc{#1}}}}

\newcommand{\idxspace}[1]%
 {\let\next#1\ifx#1\hyperpage\nobreak\enspace\nobreak\else, \fi\next}

\newcommand{\seealso}[2]{\emph{see also} #1}

\renewenvironment{theindex}{%
  \edef\indexname{\the\@nameuse{idxtitle@\@indextype}}%
  \setlength{\columnseprule}{0pt}%
  \setlength{\columnsep}{2em}%
  \twocolumn[\@makeschapterhead{\indexname}]%
  \@mkboth{\indexname}{\indexname}%
  \setlength{\parindent}{0pt}%
  \thispagestyle{plain}%
  \let\item\@idxitem%
  \begingroup%
  \small%
  \raggedright%
}{%
  \endgroup%
  \onecolumn%
}

\newenvironment{nomencl}[1]{%
  \begin{list}{}{%
    \renewcommand\makelabel[1]{##1\hfil}%
    \settowidth\labelwidth{\makelabel{#1}}%
    \setlength\labelsep{1em}%
    \setlength\leftmargin{\labelwidth}%
    \addtolength\leftmargin{\labelsep}%
    \setlength\rightmargin{0pt}%
    \setlength\parsep{\parskip}%
    \setlength\itemsep{2pt minus 1pt}%
  }%
}{\end{list}}

\newenvironment{thesymbols}{%
  \edef\indexname{\the\@nameuse{idxtitle@\@indextype}}%
  \@makeschapterhead{\indexname}%
  \@mkboth{\indexname}{\indexname}%
  \setlength{\parindent}{0pt}%
  \thispagestyle{plain}%
  \emph{Note:} See referenced pages for formal definitions.
  \par%
  \begingroup%
  \raggedright
  \begin{nomencl}{9999999999}
}{%
  \end{nomencl}%
  \endgroup%
}

\renewcommand{\@idxitem}{\par\hangindent2em}
\renewcommand{\subitem}{\par\hangindent2em\hspace*{1em}}
\renewcommand{\subsubitem}{\par\hangindent2em\hspace*{1.5em}}


% Math declarations

\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\C}{\mathbb{C}}

\newcommand{\ot}{\leftarrow}
\newcommand{\To}{\implies}

\newcommand{\e}{\text{\rmfamily e}}
\renewcommand{\i}{\text{\rmfamily i}}
\renewcommand{\O}{\mathcal{O}}

\let\lim\undefined
\DeclareMathOperator{\lim}{lim}
\let\liminf\undefined
\DeclareMathOperator{\liminf}{lim\,inf}
\let\limsup\undefined
\DeclareMathOperator{\limsup}{lim\,sup}

\let\origphi\phi
\let\phi\varphi
\let\origtheta\theta
% \let\theta\vartheta
\let\origepsilon\epsilon
\let\epsilon\varepsilon
\let\origupepsilon\upepsilon
\let\upepsilon\upvarepsilon

\let\smallfrac\@undefined
\newcommand{\smallfrac}[2]{\ensuremath{\frac{#1}{#2}}}

\newcommand{\term}[1]{\textcolor{red!70!black}{\textbf{#1}}}

% Pfad, an dem Grafiken abgelegt werden
\graphicspath{{assets/images/}}

% schönere Malpunkte
\mathcode`\*="8000
{\catcode`\*\active\gdef*{\cdot}}

% Punkte zu Kommas in Mathe-Umgebungen
\DeclareMathSymbol{.}{\mathord}{letters}{"3B}

% Römische Zahlen
\newcommand{\rom}[1]{%
  \textup{\uppercase\expandafter{\romannumeral#1}}%
}

% Pseudocode-Umgebung
\newenvironment{pseudocode}
  {
    \begin{tcolorbox}[colframe=black!3!white,left=0mm]
    \ttfamily
    \footnotesize
  }
  {
    \end{tcolorbox}
  }

% Frage-Umgebung
\newcounter{problemcounter}
\newenvironment{assignment}
  {
    \refstepcounter{problemcounter}
    \begin{tcolorbox}[colback=black!3!white,colframe=black!15!white,coltitle=black,fonttitle=\bfseries,title=Aufgabe \theproblemcounter,arc=0mm,toprule=0.2mm,bottomrule=0.2mm,leftrule=0.2mm,rightrule=0.2mm,left=1mm,right=1mm,titlerule=0mm,middle=0.5mm]
  }
  {
    \end{tcolorbox}
  }

% Inline-Code
\newcommand{\code}[1]{\lstinline[language=c,basicstyle=\ttfamily]|#1|}

\endinput