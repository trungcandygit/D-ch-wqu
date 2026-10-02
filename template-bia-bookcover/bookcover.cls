%% bookcover.cls
%% A LaTeX class for producing print-ready book covers with
%% front cover, spine, back cover, bleed marks and groove lines.
%%
%% Requires XeLaTeX or LuaLaTeX (for fontspec).
%%
%% ============================================================
%% QUICK START
%% ============================================================
%%
%%   \documentclass[pages=300, colorFront=1B6B7B, colorSpine=D4A96A]{bookcover}
%%
%%   \begin{front}  ... \end{front}   % front cover content
%%   \begin{back}   ... \end{back}    % back cover content
%%   \begin{spine}  ... \end{spine}   % spine content
%%
%%   \begin{document}
%%   \makecover
%%   \end{document}
%%
%% ============================================================
%% ANATOMY OF THE SHEET
%% ============================================================
%%
%%  The full artwork is centered on the output sheet (default A3).
%%  Reading left to right:
%%
%%  |←bleed→|←  back  →|←groove→|←spine→|←groove→|←  front  →|←bleed→|
%%
%%  bleed  : colour extends beyond the trim edge so no white border
%%           appears after guillotining.
%%  back   : back cover panel (width = `width` option).
%%  groove : hinge recess for hardcover binding. The panel colour
%%           fills it, but text is kept clear of it via automatic
%%           margins (see `margin` option).
%%  spine  : width calculated automatically from `pages` × sheet
%%           thickness / 2.
%%  front  : front cover panel (width = `width` option).
%%
%% ============================================================
%% SPINE WIDTH CALCULATION
%% ============================================================
%%
%%  spine_width = pages × sheet_thickness / 2
%%
%%  Sheet thickness by grammage (g/m²):
%%    56  → 0.07 mm / sheet
%%    60  → 0.08 mm / sheet
%%    75  → 0.10 mm / sheet  ← default
%%    90  → 0.12 mm / sheet
%%   115  → 0.15 mm / sheet
%%
%%  Example: 400 pages at 75 g/m²  →  400 × 0.10 / 2 = 20 mm spine
%%
%% ============================================================
%% CLASS OPTIONS
%% ============================================================
%%
%%   \documentclass[
%%     width       = 148,    % book page width in mm             (default: 148)
%%     height      = 210,    % book page height in mm            (default: 210)
%%     margin      = 10,     % horizontal content margin in mm.
%%                           % Applied automatically to front and back panels.
%%                           % The groove-adjacent side always receives
%%                           % margin + groove, keeping text clear of the hinge.
%%                           %                                   (default: 10)
%%     bleed       = 20,     % bleed extension beyond trim in mm (default: 20)
%%     groove      = 8,      % groove/hinge width in mm          (default: 8)
%%     paperwidth  = 420,    % output sheet width in mm          (default: 420 = A3)
%%     paperheight = 297,    % output sheet height in mm         (default: 297 = A3)
%%     pages       = 300,    % number of pages in the book body  (default: 300)
%%     grammage    = 75,     % paper grammage g/m², see table    (default: 75)
%%     colorFront  = 000000, % front panel background colour, hex without #
%%     colorBack   = 000000, % back panel background colour, hex without #
%%     colorSpine  = 000000, % spine background colour, hex without #
%%   ]{bookcover}
%%
%% ============================================================
%% USER COMMANDS AND ENVIRONMENTS
%% ============================================================
%%
%%  {front}
%%    Captures front cover content. Margins are applied automatically:
%%    `margin` on the right, `margin+groove` on the left (to keep
%%    text clear of the binding hinge).
%%
%%  {back}
%%    Captures back cover content. Margins are applied automatically:
%%    `margin` on the left, `margin+groove` on the right.
%%
%%  {spine}
%%    Captures spine content. No automatic margins are applied.
%%    Use \centering and \vfill for layout.
%%    \colorblock is NOT meaningful inside {spine}.
%%
%%  \colorblock{color}{height}{content}
%%    Full-panel-width colour band. Deliberately escapes the content
%%    margins so it always spans the full panel from edge to edge.
%%    Content inside the band inherits the full panel \linewidth.
%%    Vertical alignment inside the band is centred.
%%
%%  \spinerotated{text}
%%    Rotates content -90° (reads bottom-to-top, the standard
%%    orientation for book spines). Centred across the spine width.
%%
%%  \makecover
%%    Renders the complete cover. Must be the only content inside
%%    \begin{document}...\end{document}.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bookcover}[2026/05/05 v2.0 Book Cover Class]

%% ============================================================
%% Required packages (loaded before options are processed)
%% ============================================================
\RequirePackage{xkeyval}   % key=value class options
\RequirePackage{xcolor}    % colour definitions and \colorbox
\RequirePackage{calc}      % arithmetic on lengths
\RequirePackage{ifthen}    % \ifthenelse
\RequirePackage{pgf}       % \pgfmathsetmacro for spine calculation

%% ============================================================
%% Option defaults
%% ============================================================
\newlength{\bc@width}        \setlength{\bc@width}{148mm}
\newlength{\bc@height}       \setlength{\bc@height}{210mm}
\newlength{\bc@margin}       \setlength{\bc@margin}{10mm}
\newlength{\bc@bleed}        \setlength{\bc@bleed}{20mm}
\newlength{\bc@groove}       \setlength{\bc@groove}{8mm}
\newlength{\bc@paperwidth}   \setlength{\bc@paperwidth}{420mm}
\newlength{\bc@paperheight}  \setlength{\bc@paperheight}{297mm}
\newcount\bc@pages           \bc@pages=300
\newcount\bc@grammage        \bc@grammage=75
\newcommand{\bc@colorFront}{000000}
\newcommand{\bc@colorBack}{000000}
\newcommand{\bc@colorSpine}{000000}

%% ============================================================
%% Option declarations
%% ============================================================
\DeclareOptionX{width}      {\setlength{\bc@width}{#1mm}}
\DeclareOptionX{height}     {\setlength{\bc@height}{#1mm}}
\DeclareOptionX{margin}     {\setlength{\bc@margin}{#1mm}}
\DeclareOptionX{bleed}      {\setlength{\bc@bleed}{#1mm}}
\DeclareOptionX{groove}     {\setlength{\bc@groove}{#1mm}}
\DeclareOptionX{paperwidth} {\setlength{\bc@paperwidth}{#1mm}}
\DeclareOptionX{paperheight}{\setlength{\bc@paperheight}{#1mm}}
\DeclareOptionX{pages}      {\bc@pages=#1\relax}
\DeclareOptionX{grammage}   {\bc@grammage=#1\relax}
\DeclareOptionX{colorFront} {\renewcommand{\bc@colorFront}{#1}}
\DeclareOptionX{colorBack}  {\renewcommand{\bc@colorBack}{#1}}
\DeclareOptionX{colorSpine} {\renewcommand{\bc@colorSpine}{#1}}

\ProcessOptionsX\relax

%% ============================================================
%% Spine width calculation
%%
%% Deferred to \AtEndOfClass so that \bc@pages and \bc@grammage
%% already hold the values supplied by the user.
%% ============================================================
\newlength{\bc@spinewidth}
\newcommand{\bc@sheetThickness}{0.10}   % fallback value (75 g/m²)

\newcommand{\bc@calcSheetThickness}{%
  \renewcommand{\bc@sheetThickness}{0.10}%
  \ifnum\bc@grammage=56  \renewcommand{\bc@sheetThickness}{0.07}\fi
  \ifnum\bc@grammage=60  \renewcommand{\bc@sheetThickness}{0.08}\fi
  \ifnum\bc@grammage=75  \renewcommand{\bc@sheetThickness}{0.10}\fi
  \ifnum\bc@grammage=90  \renewcommand{\bc@sheetThickness}{0.12}\fi
  \ifnum\bc@grammage=115 \renewcommand{\bc@sheetThickness}{0.15}\fi
}

\AtEndOfClass{%
  \bc@calcSheetThickness
  %% spine = pages × thickness_per_sheet / 2
  %% (divide by 2 because `pages` counts sides, not physical sheets)
  \pgfmathsetmacro{\bc@spineval}{\bc@pages*\bc@sheetThickness/2}%
  \setlength{\bc@spinewidth}{\bc@spineval mm}%
}

%% ============================================================
%% Total sheet dimensions (deferred for the same reason)
%% ============================================================
\newlength{\bc@totalwidth}
\newlength{\bc@totalheight}

\AtEndOfClass{%
  \setlength{\bc@totalwidth}{\bc@paperwidth}%
  \setlength{\bc@totalheight}{\bc@paperheight}%
}

%% ============================================================
%% Base class + zero-margin geometry
%%
%% `article` is used as a minimal scaffold. The geometry package
%% then sets the entire sheet as the text area so that TikZ
%% overlay coordinates match physical page coordinates exactly.
%% ============================================================
\LoadClass{article}
\RequirePackage{geometry}

\AtEndOfClass{%
  \geometry{
    paperwidth  = \bc@totalwidth,
    paperheight = \bc@totalheight,
    margin      = 0pt,
    top         = 0pt, bottom = 0pt,
    left        = 0pt, right  = 0pt,
  }%
}

%% ============================================================
%% Additional packages
%% ============================================================
\RequirePackage{tikz}
\usetikzlibrary{calc}      % coordinate arithmetic: ($(A)+(x,y)$)
\RequirePackage{graphicx}  % \includegraphics
\RequirePackage{fontenc}   % font encoding
\RequirePackage{environ}   % \NewEnviron — captures body as \BODY macro
\RequirePackage{varwidth}  % variable-width minipage (available for users)

%% ============================================================
%% Runtime colour definitions
%%
%% Defined at \begin{document} so xcolor can see the hex strings
%% set by the class options.
%% Also emits a warning if the artwork overflows the output sheet.
%% ============================================================
\AtBeginDocument{%
  \definecolor{bc@front}{HTML}{\bc@colorFront}%
  \definecolor{bc@back} {HTML}{\bc@colorBack}%
  \definecolor{bc@spine}{HTML}{\bc@colorSpine}%
  %% Width check: bleed + back + 2×groove + spine + front + bleed ≤ sheet
  \ifdim\dimexpr 2\bc@bleed + 2\bc@width + 2\bc@groove + \bc@spinewidth\relax > \bc@totalwidth
    \ClassWarning{bookcover}{Cover width with bleed exceeds paper width; artwork may be clipped}%
  \fi
  %% Height check: height + 2×bleed ≤ sheet
  \ifdim\dimexpr \bc@height + 2\bc@bleed\relax > \bc@totalheight
    \ClassWarning{bookcover}{Cover height with bleed exceeds paper height; artwork may be clipped}%
  \fi
}

%% ============================================================
%% Page style
%% ============================================================
\pagestyle{empty}
\setlength{\parindent}{0pt}

%% ============================================================
%% Internal content stores
%%
%% The three environments capture their bodies into these macros
%% during the preamble. \bc@drawall expands them inside TikZ
%% nodes at \makecover time.
%% ============================================================
\newcommand{\bc@frontbody}{}
\newcommand{\bc@backbody}{}
\newcommand{\bc@spinebody}{}

%% ============================================================
%% \bc@drawall  —  the main TikZ rendering routine
%%
%% All lengths are converted to unitless mm scalars for pgfmath,
%% then used to compute the X/Y coordinates of every zone.
%% Content nodes are clipped to their panel rectangles so that
%% overflowing text or images cannot bleed into adjacent panels.
%% ============================================================
\newcommand{\bc@drawall}{%
  \noindent
  \begin{tikzpicture}[remember picture, overlay, x=1mm, y=1mm]

    %% --- Unit conversion: lengths → plain mm numbers for pgfmath ---
    \pgfmathsetmacro{\TW}{\bc@totalwidth/1mm}
    \pgfmathsetmacro{\TH}{\bc@totalheight/1mm}
    \pgfmathsetmacro{\BL}{\bc@bleed/1mm}
    \pgfmathsetmacro{\SC}{\bc@groove/1mm}
    \pgfmathsetmacro{\BK}{\bc@width/1mm}
    \pgfmathsetmacro{\SP}{\bc@spinewidth/1mm}
    \pgfmathsetmacro{\HT}{\bc@height/1mm}

    %% A tiny overlap (mm) between adjacent colour fills prevents
    %% hairline white seams that can appear in some PDF viewers / RIPs.
    \pgfmathsetmacro{\OV}{0.2}

    %% Derived dimensions
    \pgfmathsetmacro{\CW}{2*\BK + 2*\SC + \SP}   % total cover width (no bleed)
    \pgfmathsetmacro{\AH}{\HT + 2*\BL}            % artwork height (with bleed)
    \pgfmathsetmacro{\AW}{\CW + 2*\BL}            % artwork width  (with bleed)

    %% --- Horizontal zone boundaries (mm from sheet left) ---
    %% The full artwork block is centered on the sheet.
    \pgfmathsetmacro{\xArtL} {0.5*(\TW-\AW)}       % left bleed edge
    \pgfmathsetmacro{\xBackL}{\xArtL+\BL}           % back cover left trim
    \pgfmathsetmacro{\xBackR}{\xBackL+\BK}          % back cover right trim
    \pgfmathsetmacro{\xSpineL}{\xBackR+\SC}         % spine left edge
    \pgfmathsetmacro{\xSpineR}{\xSpineL+\SP}        % spine right edge
    \pgfmathsetmacro{\xFrontL}{\xSpineR+\SC}        % front cover left trim
    \pgfmathsetmacro{\xFrontR}{\xFrontL+\BK}        % front cover right trim
    \pgfmathsetmacro{\xArtR}  {\xFrontR+\BL}        % right bleed edge

    %% --- Vertical zone boundaries (mm from sheet bottom) ---
    \pgfmathsetmacro{\yArtB} {0.5*(\TH-\AH)}        % bottom bleed edge
    \pgfmathsetmacro{\yPageB}{\yArtB+\BL}           % bottom trim line
    \pgfmathsetmacro{\yPageT}{\yPageB+\HT}          % top trim line
    \pgfmathsetmacro{\yArtT} {\yPageT+\BL}          % top bleed edge

    \coordinate (SW) at (current page.south west);

    %% ---------------------------------------------------------
    %% 1. BACKGROUND COLOUR FILLS
    %%    Each fill overlaps its neighbour by \OV mm to prevent
    %%    hairline seams. The spine is drawn last so it cleanly
    %%    covers both groove overlaps.
    %% ---------------------------------------------------------

    %% Back cover: from left bleed edge through right groove edge
    \fill[bc@back]
      ($(SW)+({\xBackL mm-\BL mm-\OV mm},{\yPageB mm-\BL mm})$)
      rectangle
      ($(SW)+({\xSpineL mm+\OV mm},{\yPageT mm+\BL mm})$);

    %% Front cover: from left groove edge through right bleed edge
    \fill[bc@front]
      ($(SW)+({\xSpineR mm-\OV mm},{\yPageB mm-\BL mm})$)
      rectangle
      ($(SW)+({\xFrontR mm+\BL mm+\OV mm},{\yPageT mm+\BL mm})$);

    %% Spine: drawn on top, sealing both groove seams
    \fill[bc@spine]
      ($(SW)+({\xSpineL mm-\OV mm},{\yPageB mm-\BL mm})$)
      rectangle
      ($(SW)+({\xSpineR mm+\OV mm},{\yPageT mm+\BL mm})$);

    %% ---------------------------------------------------------
    %% 2. CROP MARKS
    %%    One mark per corner of the trim box (back-left and
    %%    front-right). Each mark has a gap from the trim edge
    %%    so it never prints in the live area.
    %% ---------------------------------------------------------
    \pgfmathsetmacro{\marklen}{6}   % mark length in mm
    \pgfmathsetmacro{\markgap}{2}   % gap between trim edge and mark start

    \bc@cropmark        {SW}{\xBackL} {\yPageB}  % bottom-left
    \bc@cropmarkright   {SW}{\xFrontR}{\yPageB}  % bottom-right
    \bc@cropmarktop     {SW}{\xBackL} {\yPageT}  % top-left
    \bc@cropmarktopright{SW}{\xFrontR}{\yPageT}  % top-right

    %% ---------------------------------------------------------
    %% 3. DIMENSION ANNOTATIONS
    %%    Reference labels drawn below and to the right of the
    %%    artwork. Not part of the print-ready file — crop or
    %%    hide before sending to press.
    %% ---------------------------------------------------------
    \pgfmathsetmacro{\annotY}{\yArtB - 8}

    \bc@dimlabel{SW}{\xArtL}  {\xBackL} {\annotY}%
      {\pgfmathprintnumber[fixed,precision=0]{\BL}mm (bleed)}
    \bc@dimlabel{SW}{\xBackL} {\xBackR} {\annotY}%
      {\pgfmathprintnumber[fixed,precision=0]{\BK}mm (back)}
    \bc@dimlabel{SW}{\xSpineL}{\xSpineR}{\annotY}%
      {\pgfmathprintnumber[fixed,precision=2]{\SP}mm (spine)}
    \bc@dimlabel{SW}{\xFrontL}{\xFrontR}{\annotY}%
      {\pgfmathprintnumber[fixed,precision=0]{\BK}mm (front)}
    \bc@dimlabel{SW}{\xFrontR}{\xArtR}  {\annotY}%
      {\pgfmathprintnumber[fixed,precision=0]{\BL}mm (bleed)}
    \bc@gdimlabel{SW}{\xBackR} {\xSpineL}{\annotY}%
      {\pgfmathprintnumber[fixed,precision=0]{\SC}mm (groove)}
    \bc@gdimlabel{SW}{\xSpineR}{\xFrontL}{\annotY}%
      {\pgfmathprintnumber[fixed,precision=0]{\SC}mm (groove)}
    \bc@dimvertlabel{SW}{\xArtR+5}{\yPageB}{\yPageT}%
      {\pgfmathprintnumber[fixed,precision=0]{\HT}mm (height)}

    %% ---------------------------------------------------------
    %% 4. CONTENT NODES
    %%    Each panel is placed inside a clipped scope so that
    %%    overflowing elements cannot bleed into adjacent panels.
    %%
    %%    The minipage width includes the groove so that
    %%    \colorblock can span it; \bc@applycontent@margins then
    %%    indents the text away from the hinge.
    %% ---------------------------------------------------------

    %% Back cover  (groove is on the RIGHT side of this panel)
    \begin{scope}
      \clip ($(SW)+(\xBackL mm,\yPageB mm)$)
            rectangle ($(SW)+(\xSpineL mm,\yPageT mm)$);
      \node[inner sep=0pt, anchor=south west,
            text width=\dimexpr\bc@width+\bc@groove\relax,
            minimum height=\bc@height, align=left]
        at ($(SW)+(\xBackL mm,\yPageB mm)$)
        {\begin{minipage}[t][\bc@height][t]{\dimexpr\bc@width+\bc@groove\relax}%
           \setlength{\bc@env@leftmargin}{\bc@margin}%
           \setlength{\bc@env@rightmargin}{\dimexpr\bc@margin+\bc@groove\relax}%
           \bc@applycontent@margins{\bc@backbody}%
         \end{minipage}};
    \end{scope}

    %% Spine  (no automatic margins; layout is fully user-controlled)
    \begin{scope}
      \clip ($(SW)+(\xSpineL mm,\yPageB mm)$)
            rectangle ($(SW)+(\xSpineR mm,\yPageT mm)$);
      \node[inner sep=0pt, anchor=south west,
            text width=\bc@spinewidth, align=center]
        at ($(SW)+(\xSpineL mm,\yPageB mm)$)
        {\begin{minipage}[t][\bc@height][t]{\bc@spinewidth}%
           \bc@spinebody
         \end{minipage}};
    \end{scope}

    %% Front cover  (groove is on the LEFT side of this panel)
    \begin{scope}
      \clip ($(SW)+(\xSpineR mm,\yPageB mm)$)
            rectangle ($(SW)+(\xFrontR mm,\yPageT mm)$);
      \node[inner sep=0pt, anchor=south west,
            text width=\dimexpr\bc@groove+\bc@width\relax,
            minimum height=\bc@height, align=left]
        at ($(SW)+(\xSpineR mm,\yPageB mm)$)
        {\begin{minipage}[t][\bc@height][t]{\dimexpr\bc@groove+\bc@width\relax}%
           \setlength{\bc@env@leftmargin}{\dimexpr\bc@margin+\bc@groove\relax}%
           \setlength{\bc@env@rightmargin}{\bc@margin}%
           \bc@applycontent@margins{\bc@frontbody}%
         \end{minipage}};
    \end{scope}

  \end{tikzpicture}%
}

%% ============================================================
%% Crop mark helpers
%%
%% Each macro draws one corner: a horizontal and a vertical tick,
%% both offset \markgap mm from the trim corner.
%%
%% Arguments: #1 TikZ reference coord name, #2 X (mm), #3 Y (mm)
%% ============================================================

\newcommand{\bc@cropmark}[3]{% bottom-left
  \pgfmathsetmacro{\cxv}{#2}\pgfmathsetmacro{\cyv}{#3}%
  \draw[black,line width=0.4pt]
    ($(#1)+({\cxv mm-\markgap mm-\marklen mm},{\cyv mm})$) --
    ($(#1)+({\cxv mm-\markgap mm},{\cyv mm})$);
  \draw[black,line width=0.4pt]
    ($(#1)+({\cxv mm},{\cyv mm-\markgap mm-\marklen mm})$) --
    ($(#1)+({\cxv mm},{\cyv mm-\markgap mm})$);
}
\newcommand{\bc@cropmarktop}[3]{% top-left
  \pgfmathsetmacro{\cxv}{#2}\pgfmathsetmacro{\cyv}{#3}%
  \draw[black,line width=0.4pt]
    ($(#1)+({\cxv mm-\markgap mm-\marklen mm},{\cyv mm})$) --
    ($(#1)+({\cxv mm-\markgap mm},{\cyv mm})$);
  \draw[black,line width=0.4pt]
    ($(#1)+({\cxv mm},{\cyv mm+\markgap mm})$) --
    ($(#1)+({\cxv mm},{\cyv mm+\markgap mm+\marklen mm})$);
}
\newcommand{\bc@cropmarkright}[3]{% bottom-right
  \pgfmathsetmacro{\cxv}{#2}\pgfmathsetmacro{\cyv}{#3}%
  \draw[black,line width=0.4pt]
    ($(#1)+({\cxv mm+\markgap mm},{\cyv mm})$) --
    ($(#1)+({\cxv mm+\markgap mm+\marklen mm},{\cyv mm})$);
  \draw[black,line width=0.4pt]
    ($(#1)+({\cxv mm},{\cyv mm-\markgap mm-\marklen mm})$) --
    ($(#1)+({\cxv mm},{\cyv mm-\markgap mm})$);
}
\newcommand{\bc@cropmarktopright}[3]{% top-right
  \pgfmathsetmacro{\cxv}{#2}\pgfmathsetmacro{\cyv}{#3}%
  \draw[black,line width=0.4pt]
    ($(#1)+({\cxv mm+\markgap mm},{\cyv mm})$) --
    ($(#1)+({\cxv mm+\markgap mm+\marklen mm},{\cyv mm})$);
  \draw[black,line width=0.4pt]
    ($(#1)+({\cxv mm},{\cyv mm+\markgap mm})$) --
    ($(#1)+({\cxv mm},{\cyv mm+\markgap mm+\marklen mm})$);
}

%% ============================================================
%% Dimension annotation helpers
%%
%% \bc@dimlabel     — horizontal double-headed arrow + inline label.
%% \bc@gdimlabel    — same arrow but label anchored below the line
%%                    (used for grooves, which are too narrow for
%%                    an inline label).
%% \bc@dimvertlabel — vertical arrow + rotated label (for height).
%%
%% Arguments: #1 ref coord, #2 x-start (mm), #3 x-end (mm),
%%            #4 y position (mm), #5 label text
%% ============================================================
\newcommand{\bc@dimlabel}[5]{%
  \pgfmathsetmacro{\dxa}{#2}\pgfmathsetmacro{\dxb}{#3}%
  \pgfmathsetmacro{\dya}{#4}\pgfmathsetmacro{\dxmid}{0.5*(#2+#3)}%
  \draw[<->,gray!80,line width=0.45pt]
    ($(#1)+({\dxa mm},{\dya mm})$) -- ($(#1)+({\dxb mm},{\dya mm})$);
  \node[font=\scriptsize, gray!90!black, fill=white,
        inner sep=1pt, text width=10mm, align=center, anchor=mid]
    at ($(#1)+({\dxmid mm},{\dya mm})$) {#5};
}
\newcommand{\bc@gdimlabel}[5]{%
  \pgfmathsetmacro{\dxa}{#2}\pgfmathsetmacro{\dxb}{#3}%
  \pgfmathsetmacro{\dya}{#4}\pgfmathsetmacro{\dxmid}{0.5*(#2+#3)}%
  \draw[<->,gray!80,line width=0.45pt]
    ($(#1)+({\dxa mm},{\dya mm})$) -- ($(#1)+({\dxb mm},{\dya mm})$);
  \node[font=\scriptsize, gray!90!black,
        inner sep=4pt, text width=15mm, align=center, anchor=north]
    at ($(#1)+({\dxmid mm},{\dya mm})$) {#5};
}
\newcommand{\bc@dimvertlabel}[5]{%
  \pgfmathsetmacro{\dvx}{#2}\pgfmathsetmacro{\dvymid}{0.5*(#3+#4)}%
  \draw[<->,gray!80,line width=0.45pt]
    ($(#1)+({\dvx mm},{#3 mm})$) -- ($(#1)+({\dvx mm},{#4 mm})$);
  \node[font=\scriptsize, gray!90!black, fill=white,
        inner sep=1pt, rotate=90, text width=10mm, align=center, anchor=mid]
    at ($(#1)+({\dvx mm},{\dvymid mm})$) {#5};
}

%% ============================================================
%% Margin machinery
%%
%% \bc@env@leftmargin and \bc@env@rightmargin are set by the
%% content nodes in \bc@drawall immediately before each body
%% macro is expanded.
%%
%% \bc@applycontent@margins wraps the body in a zero-overhead
%% list environment — the standard TeX idiom for applying
%% asymmetric horizontal insets inside a minipage without
%% disturbing \parindent or \parskip.
%% ============================================================
\newlength{\bc@env@leftmargin}
\newlength{\bc@env@rightmargin}
\newlength{\bc@env@margin}       % reserved for future per-env overrides

\newcommand{\bc@applycontent@margins}[1]{%
  \begin{list}{}{%
    \setlength{\leftmargin} {\bc@env@leftmargin}%
    \setlength{\rightmargin}{\bc@env@rightmargin}%
    \setlength{\listparindent}{\parindent}%
    \setlength{\itemindent}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\topsep}{0pt}%
    \setlength{\partopsep}{0pt}%
    \setlength{\itemsep}{0pt}%
  }%
  \item\relax #1%
  \end{list}%
}

%% ============================================================
%% User environments: {front}, {back}, {spine}
%%
%% \NewEnviron (from `environ`) captures the body as \BODY and
%% stores it globally so \bc@drawall can expand it later, after
%% all TikZ coordinates have been computed.
%%
%% The optional `margin` key is declared for future use; margin
%% values are currently set automatically by the content nodes.
%% ============================================================
\define@key{bc@envkeys}{margin}{\setlength{\bc@env@margin}{#1}}

\NewEnviron{front}[1][]{%
  \begingroup
    \setlength{\bc@env@margin}{0mm}%
    \setkeys{bc@envkeys}{#1}%
    \global\let\bc@frontbody\BODY
  \endgroup
}{}

\NewEnviron{back}[1][]{%
  \begingroup
    \setlength{\bc@env@margin}{0mm}%
    \setkeys{bc@envkeys}{#1}%
    \global\let\bc@backbody\BODY
  \endgroup
}{}

\NewEnviron{spine}[1][]{%
  \begingroup
    \setlength{\bc@env@margin}{0mm}%
    \setkeys{bc@envkeys}{#1}%
    \global\let\bc@spinebody\BODY
  \endgroup
}{}

%% ============================================================
%% \spinerotated{text}
%%
%% Rotates content -90° (bottom-to-top, standard spine direction)
%% and centres it across the full spine width via \makebox.
%% The \makebox suppresses the rotated content's natural height
%% contribution so it does not push subsequent \vfill apart.
%% ============================================================
\newcommand{\spinerotated}[1]{%
  \makebox[\linewidth][c]{\rotatebox[origin=c]{-90}{#1}}%
}

%% ============================================================
%% \colorblock{color}{height}{content}
%%
%% A full-panel-width colour band for use inside {front}/{back}.
%%
%% WHY THE MARGIN ESCAPE IS NEEDED
%%   The panel margins are implemented via a `list` environment,
%%   which shrinks \linewidth by (leftmargin + rightmargin).
%%   A naive \colorbox{...}{\linewidth} would therefore produce
%%   a band narrower than the panel by that combined amount.
%%
%% HOW IT WORKS
%%   1. \hspace{-\leftmargin} shifts the box back to the raw
%%      left edge of the panel, undoing the list indentation.
%%   2. The minipage width is \linewidth + leftmargin + rightmargin,
%%      which equals the full panel width again.
%%
%% The content inside the band receives the full panel \linewidth
%% and is vertically centred ([c][height][c]).
%%
%% OUTSIDE front/back: \leftmargin and \rightmargin are zero, so
%% the compensation terms vanish and \colorblock behaves like a
%% plain full-width \colorbox.
%% ============================================================
\newcommand{\colorblock}[3]{%
  \noindent
  \hspace{-\leftmargin}%
  \colorbox{#1}{%
    \begin{minipage}[c][#2][c]%
        {\dimexpr\linewidth+\leftmargin+\rightmargin\relax}%
      #3%
    \end{minipage}%
  }\par
}

%% ============================================================
%% \makecover
%%
%% Triggers the full TikZ render. Must be the only content
%% inside \begin{document}...\end{document}.
%% ============================================================
\newcommand{\makecover}{\bc@drawall}

\endinput