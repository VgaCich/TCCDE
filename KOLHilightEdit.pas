unit KOLHilightEdit;
{ ��� ����� ���������� ������� ��������� ��������, ��� ������
  ����������������. �� � ������������ �������������� ���������.
  �������. ���������. ��� ������. �� 3 ��� ���������?
  �������� ������, (C) 2005.
  ����� ������������ ������� ������ - 3 ��� �� ������ �������
  (� 27.08.2005 �� 29.08.2005, ���������), � ����������� ���������
  ��� (������, FastReplaceSelection, AutoOverwrite, Indent, Autocompletion)
  � ������� ��������� ������ - ����� 4 ���. ������, 5 ����, � �� ����
  ������ ���� ������������. ����� ������ ������ "��� � ����� ����-���������
  �� 3... ���, 5 ����". ������, ���������� Autocompletion :)
}

interface

{$I KOLDEF.INC}

uses Windows, Messages, MMSystem, KOL;

// �������� (�����������) ���� �� ����� ����, ����� ���������� �� �����
// ������������ (� ����� ���������), �������������� �������� ��� �� �������.

{$DEFINE CtrlArrowMoveByWords}
{$DEFINE DblClkSelectWord}
{$DEFINE MouseWheelScrolls}
{.$DEFINE ProcessHotkeys}
//{$DEFINE Only_ReadOnly}
{$DEFINE ProvideUndoRedo}
{$DEFINE ProvideSmartTabs}
{$DEFINE ProvideCustomTabs}
{$DEFINE ProvideHighlight}
{$DEFINE ProvideBookmarks}
{$DEFINE UseBufferBitmap} // less flic!
{$DEFINE DrawRightMargin}
//{$DEFINE RightZigzagIndicateLongLine}
{$DEFINE FastReplaceSelection}
{$DEFINE AutoOverwrite}
{$DEFINE ProvideAutoCompletion}
//{$DEFINE AutocompletionCaseSensitive}
//{$DEFINE AutoCompletionNumbers}
{$DEFINE AutocompletionFastFillDictionary}
{$DEFINE UseStrListEx} // by sugg. of Thaddy de Koning, 6-Feb-2006

//{$DEFINE BeepOnError}
{$DEFINE AllowLeftFromColumn0}
{$DEFINE AlwaysHorzScrollBar_ofsize_MaxLineWidth}

const
  MaxLineWidth = 1024;
type
  TOptionEdit = ( oeReadOnly, oeOverwrite, oeKeepTrailingSpaces, oeSmartTabs,
                  oeHighlight, oeAutoCompletion );
  TOptionsEdit = set of TOptionEdit;

  TTokenAttrs = packed record
    fontstyle: TFontStyle;
    fontcolor: TColor;
    backcolor: TColor;
  end;
  TOnScanToken = function( Sender: PControl; const FromPos: TPoint;
                           var Attrs: TTokenAttrs ): Integer of object;
  { �������� ��������� ���������� ������: ��������������� ���������� �������
    OnScanToken, ������� �� ������������� �������� ���������� FromPos, �����
    ������ Lines[ FromPos.Y ], � � ������� FromPos.X (��������� � ����)
    ���������� �������� ������ (���������� �� � Attrs), � ���������� ����� ������.
    �� ���� ������ �������� ����������, ���� ��� ���� ����� ��������. }

  TFindReplaceOption = ( froBack, froCase, froSpaces, froReplace, froAll );
  TFindReplaceOptions = set of TFindReplaceOption;

  TOnText = function( Sender: PControl; LineNo: Integer; var S: KOLString ): Boolean
            of object;
  TOnInsertLine = procedure( Sender: PControl; LineNo: Integer; var S: KOLString )
            of object;
  TOnDeleteLine = procedure( Sender: PControl; LineNo: Integer ) of object;
  TOnNewLine = function( Sender: PControl; LineNo: Integer; var S: KOLString ): Integer
            of object;

  { ����� �������������� �������� ������ PHilight }
  PHilight = ^THilight;

  { ����� �������� �������, ����������� �� PControl.
    ����������� �������, ����������� ��� HilightEdit,
    ��������� � CustomObj, ��������� ����� ��������
    Edit. ��� ������ HilightEdit ����� ������
    ������, �������������� �� TControl � �����������
    ��������� ������ ��� ���� ��������� ����������������. }
  PHilightMemo = ^THilightMemo;
  THilightMemo = object( TControl )
  protected
    //fCollectUpdRgn: HRGN;
    procedure Init; virtual;
    function GetEdit: PHilight;
  public
    property Edit: PHilight read GetEdit;
    destructor Destroy; virtual;
  end;

  { � ����� ��������� ������������� ������, ������� � �������� ���
    ����������� ��� Hilighting'� �������� � ������. }
  THilight = object( TObj )
  private
    FCaret: TPoint;
    FTopLine: Integer;
    FLeftCol: Integer;
    function GetCount: Integer;
    function GetLines(Idx: Integer): KOLString;
    procedure SetLines(Idx: Integer; const Value: KOLString);
    function GetSelection: KOLString;
    procedure SetSelection(const Value: KOLString);
    procedure SetSelBegin(const Value: TPoint);
    procedure SetSelEnd(const Value: TPoint);
    procedure SetCaret(const Value: TPoint);
    procedure SetTopLine(const Value: Integer);
    procedure SetLeftCol(const Value: Integer);
    function GetText: KOLString;
    procedure SetText(Value: KOLString);
    procedure SetOnScanToken(const Value: TOnScanToken);
    function GetLineData(Idx: Integer): DWORD;
    procedure SetLineData(Idx: Integer; const Value: DWORD);
  protected
    FMemo: PHilightMemo; // ������ �� ������� - �������
    procedure Init; virtual;
  public
    destructor Destroy; virtual;
    procedure Clear;
    //--------------------------------------------------------------------------
    // ������ � ���������� ����� � ������-������ ����� �� ���������
    property Count: Integer read GetCount;
    property Lines[ Idx: Integer ]: KOLString read GetLines write SetLines;
    property LineData[ Idx: Integer ]: DWORD read GetLineData write SetLineData;
    property Text: KOLString read GetText write SetText;
             { ! �� ������� ������������ �������� Text, Caption ������
               �������� THilightMemo - ��� �� ����� ��������� � �������������
               ������. ������� ������������ ������ � �������� �������
               Edit, � ���������, ��� �������� Text ! }
    procedure InvalidateLine( y: Integer );
    public
      RightMarginChars: Integer; // �� ��������� 80, ��� ���. DrawRightMargin
      RightMarginColor: TColor;  // �� ��������� clBlue
    protected
      FLines:
         {$IFDEF UNICODE_CTRLS}
         {$IFDEF UseStrListEx} PWStrListEx {$ELSE} PWStrList {$ENDIF};    // �����
         {$ELSE}
         {$IFDEF UseStrListEx} PStrListEx {$ELSE} PStrList {$ENDIF};    // �����
         {$ENDIF}
      FBufferBitmap: PBitmap;
      procedure DoPaint( DC: HDC );
    protected
      FChangeLevel: Integer;
      procedure Changing; // ������ ����� ���������
      procedure Changed;  // ����� ����� ���������
    protected
      FOnScanToken: TOnScanToken;
  public
    //--------------------------------------------------------------------------
    // ��������� ����������
    property OnScanToken: TOnScanToken read FOnScanToken write SetOnScanToken;
  public
    //--------------------------------------------------------------------------
    // ������� ��������������
    Options: TOptionsEdit;
    procedure DeleteLine( y: Integer; UseScroll: Boolean );
    procedure InsertLine( y: Integer; const S: KOLString; UseScroll: Boolean );
    protected
      procedure DeleteLine1( y: Integer );
  protected
    fOnInsertLine: TOnInsertLine;
    fOnDeleteLine: TOnDeleteLine;
  public
    //--------------------------------------------------------------------------
    // ������� ��������� ������� �����
    property OnDeleteLine: TOnDeleteLine read fOnDeleteLine write fOnDeleteLine;
    property OnInsertLine: TOnInsertLine read fOnInsertLine write fOnInsertLine;
  public
    //--------------------------------------------------------------------------
    // ���������� ��������
    procedure Indent( delta: Integer );
  public
    //--------------------------------------------------------------------------
    // ������� ������� (�������)
    property Caret: TPoint read FCaret write SetCaret;
    function Client2Coord( const P: TPoint ): TPoint;
    procedure CaretToView;
      { CaretToView ������������ �������������� ������ ����� �������,
        ����� ������� ����� ����� �� ��������� �������� ��������� � �������
        ����� ����. }
  public
    //--------------------------------------------------------------------------
    // ���������� �������
    protected
      FSelBegin, FSelEnd, FSelFrom: TPoint; // ������, ����� ���������� �������
                 // � �������, �� ������� ��������� ���������� (��� �����������)
    public
    procedure SetSel( const Pos1, Pos2, PosFrom: TPoint );
    { SetSel ������������� ����� ��������� � ������� ����������
      ������� ��������� �� ���� �����. }
    property Selection: KOLString read GetSelection write SetSelection;
    property SelBegin: TPoint read FSelBegin write SetSelBegin;
    property SelEnd: TPoint read FSelEnd write SetSelEnd;
    property SelFrom: TPoint read FSelFrom write FSelFrom;
    function SelectionAvailable: Boolean;
    procedure DeleteSelection;
    procedure InvalidateSelection; // �������� ������� ����� ������� ���������
                                   // ��� �����������
  public
    //--------------------------------------------------------------------------
    // ���������������� � ��������� �����
    protected
      FMouseDown: Boolean; // TRUE, ����� ������ ����� ������� ����
      FOnScroll: TOnEvent;
      fOnNewLine: TOnNewLine;
      procedure DoMouseDown( X, Y, Shift: Integer );
      procedure DoMouseMove( X, Y: Integer );
    //--------------------------------------------------------------------------
    // �������������� � ��������� ����������:
      procedure AdjustHScroll;
      procedure AdjustVScroll;
      procedure DoScroll( Cmd, wParam: DWord );
  public
    property OnScroll: TOnEvent read FOnScroll write FOnScroll;
    property OnNewLine: TOnNewLine read fOnNewLine write fOnNewLine;
    //--------------------------------------------------------------------------
    // ������ �� ������� (����� ��� ��������, ��� ��������, ��������
    // ������� �� ������)
    function WordAtPosStart( const AtPos: TPoint ): TPoint;
    function WordAtPos( const AtPos: TPoint ): KOLString;
    function FindNextWord( const FromPos: TPoint; LookForLettersDigits: Boolean ): TPoint;
    function FindPrevWord( const FromPos: TPoint; LookForLettersDigits: Boolean ): TPoint;
    procedure SelectWordUnderCursor;
    function FindNextTabPos( const FromPos: TPoint ): Integer;
    function FindPrevTabPos( const FromPos: TPoint ): Integer;
  public
    //--------------------------------------------------------------------------
    // ������������ ������ ���������
    protected
      fTabSize: Integer;
      procedure SetTabSize( Value: Integer );
      function GetTabSize: Integer;
  public
    property TabSize: Integer read GetTabSize write SetTabSize;
    function GiveNextTabPos( FromPos: Integer ): Integer;
  public
    //--------------------------------------------------------------------------
    // ������������ ����������
    procedure DoKeyDown( Key, Shift: Integer );
    procedure DoKeyChar( Key: KOLChar );
  public
    //--------------------------------------------------------------------------
    // ������� ������� ������ � ����� �������
    property TopLine: Integer read FTopLine write SetTopLine;
    property LeftCol: Integer read FLeftCol write SetLeftCol;
    //--------------------------------------------------------------------------
    // ����� ������ � �������� ����� �� ��������
    function LinesPerPage: Integer;
    function LinesVisiblePartial: Integer;
    //--------------------------------------------------------------------------
    // ������ ������� � ����� ������� ������� � ��������
    function CharWidth: Integer;
    function ColumnsVisiblePartial: Integer;
    function MaxLineWidthOnPage: Integer;
    //--------------------------------------------------------------------------
    // ������ ������
    function LineHeight: Integer;
    protected
      FBitmap: PBitmap; // ������������ ��� �������� ������ � ������ ��������
      FCharWidth: Integer; // ���������� ������� ������������ ������ 1-�� �������
      FLineHeight: Integer;// ���������� ������� ������������ ������ ������
        { ����� �������������� ������������. }
  public
    //--------------------------------------------------------------------------
    // ������ � �������
    function CanUndo: Boolean;
    function CanRedo: Boolean;
    procedure Undo;
    procedure Redo;
    protected
      FUndoList, FRedoList: PStrList;
      FUndoingRedoing: Boolean; // ���� TRUE, �� ��������� ���� ������
      procedure DoUndoRedo( List1, List2: PStrList );
    //--------------------------------------------------------------------------
    // ��������
  protected
    FBookmarks: array[ 0..9 ] of TPoint;
    FOnBookmark: TOnEvent;
    procedure SetBookmark( Idx: Integer; const Value: TPoint );
    function GetBookMark( IDx: Integer ): TPoint;
    {$IFDEF ProvideBookmarks}
    procedure FixBookmarks( const FromPos: TPoint; deltaX, deltaY: Integer );
    {$ENDIF}
  public
    property Bookmarks[ Idx: Integer ]: TPoint read GetBookMark write SetBookmark;
    property OnBookmark: TOnEvent read FOnBookmark write FOnBookmark;
  public
    //--------------------------------------------------------------------------
    // ����� / ������
    function FindReplace( S: KOLString; const ReplaceTo: KOLString;
              const FromPos: TPoint;
              FindReplaceOptions: TFindReplaceOptions;
              SelectFound: Boolean ): TPoint;
  public
    //--------------------------------------------------------------------------
    // ����-����������
          { ��������! �� ��������� ������� Applet ������ �������������� ���
            ��������� ������ KOL.TApplet ! }
    // ������ ������������� ������������ ������ ���� ���. ������ ���� �������
    // ������� ������ ������������� ��� ��������� ������� ����� �����.
    AutoCompleteMinWordLength: Integer; // �� ��������� 2 �������, ��� �����
    FShowAutoCompletion: Boolean;
    procedure AutoAdd2Dictionary( S: PKOLChar ); // �������� ��� ����� �� ������
    procedure AutoCompletionShow;    // �������� ������, ���� ����
    procedure AutoCompletionHide;    // ������ ������ ����
    procedure AutoCompletionClear;   // �������� �������
    protected                           // �������� �� �������� ����-������
      FAutoCompletionForm: PControl; // ����� ��� ������ ����-������
      FAutoCompletionList: PControl; // list view
      FDictionary: {$IFDEF UNICODE_CTRLS} PWStrListEx {$ELSE} PStrListEx {$ENDIF}; // ���� ������ ����, ������ ����� ��������� �������
      FAutoFirst, FAutoCount: Integer; // ����� �������� ������ � ����������
      FAutoBestFirst: Integer;         // ������ ������ ����� - ������� ��������
      FLastInsertIdx: Integer; // ������� �������
      FAutoWord: KOLString; // ��� ������ ������ ����� ������ ����-������
      FAutoPos: TPoint;  // � ����� ����� ���� ������� ��� ������
      FnotAdd2Dictionary1time: Boolean; // ��������������� �� 1 ���
      procedure AutoListData( Sender: PControl; Idx, SubItem: Integer;
              var Txt: KOL_String; var ImgIdx: Integer; var State: DWORD;
              var Store: Boolean );    // ���������� ����������� ������ ����
      function AutoListMessage( var Msg: TMsg; var Rslt: Integer ): Boolean;
      procedure AutoCompleteWord( n: Integer ); // ��������� ��������������!
      procedure AutoformCloseEvent( Sender: PObj; var Accept: Boolean );
      procedure AutoFormShowEvent( Sender: PObj );
      procedure FastFillDictionary;   // ������ ��� Text := ����� ��������
    protected
    //--------------------------------------------------------------------------
    // ����������� �����
    FOnGetLine: TOnText;
    FOnSetLine: TOnText;
  public
    property OnGetLine: TOnText read FOnGetLine write FOnGetLine;
    // ���� ����������� � �������� "�����������" ������ ������� ����� � ������
    // ����������� (���� �� ������) �����, �� ���� ������ ������������� � ����
    // ����������� - �� ����������.
    property OnSetLine: TOnText read FOnSetLine write FOnSetLine;
  end;

function NewHilightEdit( AParent: PControl ): PHilightMemo;
procedure Beep; // ����������� ����

var Upper: array[ Char ] of Char;
    procedure InitUpper;

implementation

// ��������������� �������
function IsLetterDigit( C: KOLChar ): Boolean;
begin
  {$IFDEF UNICODE_CTRLS}
  if Ord(C)>255 then Result := TRUE // ������� ��� ������� >255 �������
  else
  {$ENDIF UNICODE_CTRLS}
  Result := Char(Ord( C )) in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ];
end;

function IsLetter( C: KOLChar ): Boolean;
begin
  {$IFDEF UNICODE_CTRLS}
  if Ord(C)>255 then Result := TRUE // ������� ��� ������� >255 �������
  else
  {$ENDIF UNICODE_CTRLS}
  Result := Char(Ord( C )) in [ {$INCLUDE HilightLetters.inc} ];
end;

procedure Beep;
begin
  PlaySound( 'Default', 0, SND_ALIAS );
end;

procedure InitUpper;
var c: Char;
begin
  for c := #0 to #255 do
    Upper[ c ] := AnsiUpperCase( c )[ 1 ];
end;

function AnsiStrLComp( S1, S2: PChar; L: Integer ): Integer;
begin
  Result := 0;
  while L > 0 do
  begin
    Result := Ord( Upper[ S1^ ] ) - Ord( Upper[ S2^ ] );
    if Result <> 0 then Exit;
    Dec( L );
    Inc( S1 );
    Inc( S2 );
  end;
end;

function WAnsiStrLComp( S1, S2: PWideChar; L: Integer ): Integer;
begin
  Result := 0;
  while L > 0 do
  begin
    if (Ord(S1^) <= 255) and (Ord(S2^) <= 255) then
      Result := Ord( Upper[ Char(Ord( S1^ )) ] ) - Ord( Upper[ Char(Ord( S2^ )) ] )
    else
      Result := Ord( S1^ ) - Ord( S2^ );
    if Result <> 0 then Exit;
    Dec( L );
    Inc( S1 );
    Inc( S2 );
  end;
end;

const
  msgCaret    = 1;
  msgDblClk   = 2;
  msgShow     = 3;
  msgComplete = 4;

{ ���������� ��������� ��������.
  ���� - ���������� WM_PAINT � WM_PRINT.
  ��� �� - ���������� ��������� � ������ ������ ��� ����������� �������.
  ��� �� - ���������� ������� - WM_KEYDOWN, WM_CHAR.
  ��� �� - ���������� ��������� ����.
  � ������. }
function HilightWndFunc( Sender: PControl; var Msg: TMsg; var Rslt: Integer )
         : Boolean;
var PaintStruct: TPaintStruct;
    OldPaintDC: HDC;
    HilightEdit: PHilightMemo;
    Edit: PHilight;
    Cplxity: Integer;
    CR: TRect;
    i: Integer;
    // ��� WM_KEYDOWN:
    Shift: Integer;
    // ��� WM_CHAR:
    C: KOLChar;
    // ��� WM_PASTE:
    S: KOLString;
begin
  Result := FALSE; // �� ��������� - ���������� ��������� �� �������
  HilightEdit := Pointer( Sender );
  if HilightEdit = nil then Exit;
  Edit := HilightEdit.Edit;

  CASE Msg.message OF
  WM_PAINT, WM_PRINT:
    begin

      HilightEdit.fUpdRgn := CreateRectRgn( 0, 0, 0, 0 );
      Cplxity := Integer(
        GetUpdateRgn( HilightEdit.fHandle, HilightEdit.fUpdRgn, FALSE ) );
       if (Cplxity = NULLREGION) or (Cplxity = ERROR) then
       begin
         DeleteObject( HilightEdit.fUpdRgn );
         HilightEdit.fUpdRgn := 0;
       end;

       if (HilightEdit.fCollectUpdRgn <> 0) and (HilightEdit.fUpdRgn <> 0) then
       begin
         if CombineRgn( HilightEdit.fCollectUpdRgn, HilightEdit.fCollectUpdRgn,
                        HilightEdit.fUpdRgn, RGN_OR )
            = COMPLEXREGION then
         begin
           windows.GetClientRect( HilightEdit.fHandle, CR );
           DeleteObject( HilightEdit.fCollectUpdRgn );
           HilightEdit.fCollectUpdRgn := CreateRectRgnIndirect( CR );
         end;
         InvalidateRgn( HilightEdit.fHandle, HilightEdit.fCollectUpdRgn,
                        FALSE{fEraseUpdRgn} );
       end;

       OldPaintDC := HilightEdit.fPaintDC;
       HilightEdit.fPaintDC := Msg.wParam;
       if HilightEdit.fPaintDC = 0 then
         HilightEdit.fPaintDC := BeginPaint( HilightEdit.fHandle, PaintStruct );

       if HilightEdit.fCollectUpdRgn <> 0 then
         SelectClipRgn( HilightEdit.fPaintDC, HilightEdit.fCollectUpdRgn );

       Edit.DoPaint( HilightEdit.fPaintDC );

       if assigned( HilightEdit.fCanvas ) then
         HilightEdit.fCanvas.Handle := 0;

       if Msg.wParam = 0 then
         EndPaint( HilightEdit.fHandle, PaintStruct );
       HilightEdit.fPaintDC := OldPaintDC;

       if HilightEdit.fUpdRgn <> 0 then
         DeleteObject( HilightEdit.fUpdRgn );
       HilightEdit.fUpdRgn := 0;

       Rslt := 0;
       Result := True;
    end;
  WM_SETFOCUS, WM_KILLFOCUS:
    begin
      HilightEdit.Postmsg( WM_USER+msgCaret, 0, 0 );
    end;
  WM_USER+msgCaret:
    begin
      Edit.Caret := Edit.Caret;
    end;
  WM_KEYDOWN:
    begin
      Shift := GetShiftState;
      if Assigned( HilightEdit.OnKeyDown ) then
        HilightEdit.OnKeyDown( HilightEdit, Msg.wParam, Shift );
      if Msg.wParam <> 0 then
        Edit.DoKeyDown( Msg.wParam, Shift );
    end;
  WM_LBUTTONDOWN:
    begin
      HilightEdit.Focused := TRUE;
      Edit.DoMouseDown(
        SmallInt( Loword( Msg.lParam ) ),
        SmallInt( hiWord( Msg.lParam ) ),
        GetShiftState );
    end;
  WM_RBUTTONDOWN, WM_MBUTTONDOWN:
    begin
      HilightEdit.Focused := TRUE;
    end;
  WM_LBUTTONUP:
    begin
      Edit.DoMouseMove(
        SmallInt( Loword( Msg.lParam ) ),
        SmallInt( hiWord( Msg.lParam ) ) );
      Edit.FMouseDown := FALSE;
      ReleaseCapture;
    end;
  WM_MOUSEMOVE:
    begin
      if Edit.FMouseDown then
        Edit.DoMouseMove(
        SmallInt( Loword( Msg.lParam ) ),
        SmallInt( hiWord( Msg.lParam ) ) );
    end;
  {$IFDEF MouseWheelScrolls}
  WM_MOUSEWHEEL:
    begin
      i := SmallInt( HiWord( Msg.wParam ) );
      if i div 40 <> 0 then
        Edit.TopLine := Edit.TopLine - i div 40;
    end;
  {$ENDIF}
  {$IFDEF DblClkSelectWord}
  WM_LBUTTONDBLCLK:
    begin
      Shift := GetShiftState;
      Edit.DoMouseDown(
        SmallInt( Loword( Msg.lParam ) ),
        SmallInt( hiWord( Msg.lParam ) ),
        Shift );
      Edit.FMouseDown := FALSE;
      ReleaseCapture;
      HilightEdit.Postmsg( WM_USER+msgDblClk, Shift, 0 );
    end;
  WM_USER+msgDblClk:
    begin
      Shift := Msg.wParam;
      if Shift and MK_SHIFT = 0 then
        Edit.SelectWordUnderCursor;
    end;
  {$ENDIF}
  {$IFNDEF Only_ReadOnly}
  WM_CHAR:
    begin
      C := KOLChar( Msg.wParam );
      if Assigned( HilightEdit.OnChar ) then
        HilightEdit.OnChar( HilightEdit, C, GetShiftState );
      if (C = #9) and (GetShiftState and MK_CONTROL <> 0) then C := #0; //Supress Ctrl-I to Tab conversion
      if C <> #0 then
        Edit.DoKeyChar( C )
      else Result := TRUE;
    end;
  {$ENDIF}
  WM_SIZE:
    begin
      Edit.AdjustHScroll;
      Edit.AdjustVScroll;
    end;
  WM_HScroll:
    Edit.DoScroll( SC_HSCROLL, Msg.wParam );
  WM_VScroll:
    Edit.DoScroll( SC_VSCROLL, Msg.wParam );
  WM_SETFONT:
    begin
      Edit.FCharWidth := 0;
      Edit.FLineHeight := 0;
      Edit.Caret := Edit.Caret;
    end;
  WM_COPY:
    if Edit.SelectionAvailable then
      Text2Clipboard( Edit.Selection );
  {$IFNDEF Only_ReadOnly}
  WM_CUT:
    if Edit.SelectionAvailable then
    begin
      Text2Clipboard( Edit.Selection );
      Edit.DeleteSelection;
    end;
  WM_PASTE:
    begin
      S := Clipboard2Text;
      if S = '' then
        {$IFDEF BeepOnError}
        Beep
        {$ENDIF}
      else
        Edit.Selection := S;
    end;
  {$ENDIF}
  END;
end;

{ �������� ��������-��������, ��� �����. }
function NewHilightEdit( AParent: PControl ): PHilightMemo;
var HilightObj: PHilight;
begin
  Result := PHilightMemo( _NewControl( AParent, 'HILIGHTEDIT',
            WS_CHILD or WS_VISIBLE
            or WS_TABSTOP // WS_TABSTOP ����� ��� ����� ������ �����
            or WS_HSCROLL or WS_VSCROLL or WS_BORDER,
            TRUE, nil ) );
  Result.ExStyle := Result.ExStyle or WS_EX_CLIENTEDGE;
  Result.ClsStyle := (Result.ClsStyle or CS_DBLCLKS)
                  and not (CS_HREDRAW or CS_VREDRAW);
  Result.Cursor := LoadCursor( 0, IDC_IBEAM );
  { ��� �������� HilightMemo ��������� � ������������� ������ Edit }
  new( HilightObj, Create );
  HilightObj.FMemo := Result;
  Result.FCustomObj := Pointer( HilightObj );
  { ����������� ���������� ��������� }
  Result.AttachProc( HilightWndFunc );
  { ��������� ��������� }
  Result.Color := clWindow;
  Result.Font.FontName := 'Courier New';
  Result.Font.FontHeight := 16;
  //Result.Tabstop := TRUE;
  //Result.Enabled := TRUE;
  Result.fLookTabKeys := [  ]
end;

{ THilightMemo }

destructor THilightMemo.Destroy;
begin
  inherited;
end;

function THilightMemo.GetEdit: PHilight;
begin
  Result := PHilight( FCustomObj );
end;

procedure THilightMemo.Init;
begin
  inherited;
end;

{ THilight }

procedure THilight.AdjustHScroll;
var SBInfo: TScrollInfo;
begin
  SBInfo.cbSize := Sizeof( SBInfo );
  SBInfo.fMask := SIF_PAGE or SIF_POS or SIF_RANGE;
  SBInfo.nMin := 0;
  SBInfo.nMax := Max( MaxLineWidthOnPage, Caret.X+1 );
  SBInfo.nPage := ColumnsVisiblePartial;
  SBInfo.nPos := FLeftCol;
  SBInfo.nTrackPos := FLeftCol;
  SetScrollInfo( FMemo.Handle, SB_HORZ, SBInfo, TRUE );
  if Assigned(fOnScroll) then fOnScroll(FMemo);
end;

procedure THilight.AdjustVScroll;
var SBInfo: TScrollInfo;
begin
  SBInfo.cbSize := Sizeof( SBInfo );
  SBInfo.fMask := SIF_PAGE or SIF_POS or SIF_RANGE;
  SBInfo.nMin := 0;
  SBInfo.nMax := Count-1;
  SBInfo.nPage := LinesPerPage;
  SBInfo.nPos := TopLine;
  SBInfo.nTrackPos := TopLine;
  SetScrollInfo( FMemo.Handle, SB_VERT, SBInfo, TRUE );
  if Assigned(fOnScroll) then fOnScroll(FMemo);
end;

procedure THilight.AutoAdd2Dictionary(S: PKOLChar);
var From: PKOLChar;
    i, c, L, LItem: Integer;
    W: KOLString;
    handled: Boolean;
begin
  while S^ <> #0 do
  begin
    if {$IFDEF UNICODE_CTRLS}
       (Ord(S^) <= 255) and (Char(Ord(S^)) in [ {$INCLUDE HilightLetters.inc}
               {$IFDEF AutocompletionNunbers}, '0'..'9' {$ENDIF} ])
       or (Ord(S^)>255)
       {$ELSE}
       S^ in [ {$INCLUDE HilightLetters.inc}
               {$IFDEF AutocompletionNunbers}, '0'..'9' {$ENDIF} ]
       {$ENDIF} then
    begin
      From := S; inc( S );
      while {$IFDEF UNICODE_CTRLS}
            (Ord(S^) <= 255) and (Char(Ord(S^)) in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ])
            or (Ord(S^)>255)
            {$ELSE}
            S^ in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ]
            {$ENDIF}
            do inc( S );
      L := (DWORD( S ) - DWORD( From )) div Sizeof( KOLChar );
      if L > AutoCompleteMinWordLength then
      begin
        handled := FALSE;
        for i := 0 to FDictionary.Count-1 do
        begin
          {$IFDEF AutoCompletionCaseSensitive}
          c := StrLComp( From, FDictionary.ItemPtrs[ i ], L );
          {$ELSE}
          {$IFDEF UNICODE_CTRLS}
          c := WAnsiStrLComp( From, FDictionary.ItemPtrs[ i ], L );
          {$ELSE}
          c := AnsiStrLComp( From, FDictionary.ItemPtrs[ i ], L );
          {$ENDIF}
          {$ENDIF}
          if c = 0 then
          begin
            if L < Length( FDictionary.Items[ i ] ) then
            begin
              SetString( W, From, L );
              FDictionary.Insert( i, W );
            end; // ����� ��� ������ ��� ���� � �������
            handled := TRUE;
            break;
          end
            else
          if c > 0 then // ������ ����� ��� ���?
          begin
            LItem := Length( FDictionary.Items[ i ] );
            if (LItem < L) and
               {$IFDEF UNICODE_CTRLS}
               {$IFDEF AutoCompletionCaseSensitive}
               (WStrLComp( From, FDictionary.ItemPtrs[ i ], LItem ) = 0)
               {$ELSE}
               (WAnsiStrLComp( From, FDictionary.ItemPtrs[ i ], LItem ) = 0)
               {$ENDIF}
               {$ELSE}
               {$IFDEF AutoCompletionCaseSensitive}
               (StrLComp( From, FDictionary.ItemPtrs[ i ], LItem ) = 0)
               {$ELSE}
               (AnsiStrLComp( From, FDictionary.ItemPtrs[ i ], LItem ) = 0)
               {$ENDIF}
               {$ENDIF UNICODE_CTRLS}
            then
              continue; // ��� �� �������, ������� ������
            SetString( W, From, L );
            FDictionary.Insert( i, W );
            handled := TRUE;
            break;
          end;
          // ���� c < 0, ���������� ������ ����� ��� �������
          // � ����� ������� ������������� ������������ �� ��������
        end;
        if not handled then // �������� ����� � �����
        begin
          SetString( W, From, L );
          FDictionary.Add( W );
        end;
      end;
    end
      else inc( S );
  end;
end;

procedure THilight.AutoCompleteWord(n: Integer);
var W: KOLString;
    M: TMsg;
begin
  // �������� WM_CHAR, ������� ����� ������ �� ENTER:
  PeekMessage( M, FAutoCompletionList.Handle, WM_CHAR, WM_CHAR, pm_Remove );
  AutoCompletionHide;
  if n < 0 then Exit; // �������� ���� - �� ��������
  W := FDictionary.Items[ FAutoFirst + n ];
  inc( FAutoCount );
  FDictionary.Objects[ FAutoFirst + n ] := FAutoCount;
  SelectWordUnderCursor;
  Selection := W;
  //Caret := MakePoint( Caret.X + Length( W ), Caret.Y );
  CaretToView;
end;

procedure THilight.AutoCompletionClear;
begin
  FDictionary.Clear;
end;

procedure THilight.AutoCompletionHide;
begin
  if Assigned( FAutoCompletionForm ) and FAutoCompletionForm.Visible then
  begin
    FAutoCompletionForm.Hide;
    FMemo.Focused := TRUE;
  end;
end;

procedure THilight.AutoCompletionShow;
var W, W1: KOLString;
    FromPos, Pt: TPoint;
    DR: TRect;
    i, j, BestIdx: Integer;
    BestCounter: DWORD;
    DicW: PKOLChar;
begin
  W := WordAtPos( Caret );
  W1 := W;
  if (W = '') or not( oeAutoCompletion in Options ) then
  begin
    AutoCompletionHide;
    Exit;
  end;
  if Assigned( FAutoCompletionForm ) and FAutoCompletionForm.Visible and
     (FAutoWord = W) and
     (FAutoPos.X = FCaret.X) and (FAutoPos.Y = FCaret.Y) then
     Exit; // ��� ����� ����� ��� ��������
  FAutoPos := Caret;
  FAutoWord := W;
  AutoCompletionHide;
  FromPos := WordAtPosStart( Caret );
  W := Copy( W, 1, Caret.X - FromPos.X );
  if Length( W ) < AutoCompleteMinWordLength then Exit;
  for i := 0 to FDictionary.Count-1 do
  begin
    DicW := FDictionary.ItemPtrs[ i ];
    {$IFDEF UNICODE_CTRLS}
    {$IFDEF AutocompletionCaseSensitive}
    if WStrLComp( PKOLChar( W ), DicW, Length( W ) ) = 0 then
    {$ELSE}
    if WAnsiStrLComp( PKOLChar( W ), DicW, Length( W ) ) = 0 then
    {$ENDIF}
    {$ELSE}
    {$IFDEF AutocompletionCaseSensitive}
    if StrLComp( PChar( W ), DicW, Length( W ) ) = 0 then
    {$ELSE}
    if AnsiStrLComp( PChar( W ), DicW, Length( W ) ) = 0 then
    {$ENDIF}
    {$ENDIF UNICODE_CTRLS}
    begin
      FAutoFirst := i;
      FAutoCount := 0;
      BestIdx := i;
      BestCounter := 0;
      for j := i+1 to FDictionary.Count do
      begin
        DicW := FDictionary.ItemPtrs[ j ];
        if (j >= FDictionary.Count) or
           {$IFDEF UNICODE_CTRLS}
           {$IFDEF AutocompletionCaseSensitive}
           (WStrLComp( PKOLChar( W ), DicW, Length( W ) ) <> 0)
           {$ELSE}
           (WAnsiStrLComp( PKOLChar( W ), DicW, Length( W ) ) <> 0)
           {$ENDIF}
           {$ELSE}
           {$IFDEF AutocompletionCaseSensitive}
           (StrLComp( PChar( W ), DicW, Length( W ) ) <> 0)
           {$ELSE}
           (AnsiStrLComp( PChar( W ), DicW, Length( W ) ) <> 0)
           {$ENDIF}
           {$ENDIF UNICODE_CTRLS}
        then
        begin
          FAutoCount := j-i;
          break;
        end
          else
        if FDictionary.Objects[ j ] > BestCounter then
        begin
          BestCounter := FDictionary.Objects[ j ];
          BestIdx := j;
        end;
      end;
      if FAutoCount > 0 then
      begin
        if (FAutoCount = 1) and
           (AnsiCompareStrNoCase(FDictionary.Items[ FAutoFirst ], W1) = 0) then
           Exit; // ���� ������ 1 ����� � ��� ��������� � ��� ��� ��� ��������
        if FAutoCompletionForm = nil then
        begin
          FAutoCompletionForm := NewForm( Applet, '' ).SetSize( 300, 200 );
          { ��������! �� ��������� ������� Applet ������ �������������� ���
            ��������� ������ KOL.TApplet ! }
          FAutoCompletionForm.Visible := FALSE;
          FAutoCompletionForm.Style := WS_POPUP or WS_TABSTOP or WS_CLIPCHILDREN
            or WS_THICKFRAME or WS_CLIPSIBLINGS;
          //FAutoCompletionForm.OnClose := AutoFormCloseEvent;
          FAutoCompletionForm.MinHeight := 100;
          FAutoCompletionForm.OnShow := AutoFormShowEvent;
          FAutoCompletionList := NewListView( FAutoCompletionForm, lvsDetailNoHeader,
            [ lvoRowSelect, lvoOwnerData ], nil, nil, nil ).SetAlign( caClient );
          FAutoCompletionList.LVColAdd( '', taLeft, FAutoCompletionList.ClientWidth-2 );
          FAutoCompletionList.OnMessage := AutoListMessage;
          FAutoCompletionList.OnLVData := AutoListData;
        end;
        FAutoCompletionForm.Font.Assign( FMemo.Font );
        FAutoCompletionList.LVCount := 0; // ����� - �� ������ ������
        Pt := MakePoint( (Caret.X - LeftCol)*CharWidth, (Caret.Y+1 - TopLine)*LineHeight );
        Pt := FMemo.Client2Screen( Pt );
        DR := GetDesktopRect;
        if Pt.x + FAutoCompletionForm.Width > DR.Right then
          Pt.x := Pt.x - FAutoCompletionForm.Width;
        if Pt.x < DR.Left then Pt.x := DR.Left;
        if Pt.y + FAutoCompletionForm.Height > DR.Bottom then
          Pt.y := Pt.y - LineHeight - FAutoCompletionForm.Height;
        FAutoCompletionForm.Position := Pt;
        FShowAutoCompletion := TRUE;
        FAutoCompletionForm.Show;
        FAutoCompletionForm.BringToFront;
        FAutoCompletionList.LVCount := FAutoCount;
        FAutoCompletionList.LVStyle := lvsList;
        FAutoCompletionList.LVStyle := lvsDetailNoHeader;
        FAutoCompletionList.Focused := TRUE;
        FShowAutoCompletion := FALSE;
        //FAutoCompletionList.LVCurItem := BestIdx;
        //FAutoCompletionList.LVMakeVisible( BestIdx - FAutoFirst, FALSE );
        FAutoBestFirst := BestIdx - FAutoFirst;
      end;
      Exit;
    end;
  end;
end;

{ ���������� ��������� ��� list view �����, � ������� ������� ������ ���� ���
  ��������������� ���������� �� ENTER ��� ����� ����. }
procedure THilight.AutoformCloseEvent(Sender: PObj; var Accept: Boolean);
begin
  Accept := FALSE;
  FAutoCompletionForm.Hide;
end;

procedure THilight.AutoFormShowEvent(Sender: PObj);
begin
  FAutoCompletionList.Postmsg( WM_USER + msgShow, 0, 0 );
end;

procedure THilight.AutoListData(Sender: PControl; Idx, SubItem: Integer;
  var Txt: KOL_String; var ImgIdx: Integer; var State: DWORD;
  var Store: Boolean);
begin
  Txt := FDictionary.Items[ FAutoFirst + Idx ];
  //Store := FALSE; ��� �� ���������
end;

function THilight.AutoListMessage(var Msg: TMsg;
  var Rslt: Integer): Boolean;
begin
  Result := FALSE;
  CASE Msg.message OF
  WM_KILLFOCUS: { ���, �� �� ����� - �������� � ���� }
    begin
      //if Assigned( FAutoCompletionList) and
      //   (DWORD( Msg.wParam ) <> FAutoCompletionList.Handle) then
      if not FShowAutoCompletion then
      begin
        FnotAdd2Dictionary1time := TRUE;
        AutoCompletionHide;
        FnotAdd2Dictionary1time := FALSE;
      end;
    end;
  WM_KEYUP, WM_SYSKEYUP, WM_SYSKEYDOWN, WM_SYSCHAR,
  WM_CHAR: { ��� �� � ���, ������ � HilightMemo }
    FMemo.Perform( Msg.message, Msg.wParam, Msg.lParam );
  WM_KEYDOWN: { � ��� ��������� ������ UP, DOWN, ENTER - ��� ��������� ������
           ������� �� ��������� }
    CASE Msg.wParam OF
    VK_UP, VK_DOWN: ; // ����� list view �����������
    VK_RETURN: AutoCompleteWord( FAutoCompletionList.LVCurItem );
    VK_ESCAPE: AutoCompletionHide;
    else       FMemo.Perform( Msg.message, Msg.wParam, Msg.lParam );
    END;
  WM_LBUTTONDOWN: // ����-��������� �� ����� �� �����, ������� �� ����� ��� ������
    FAutoCompletionList.Postmsg( WM_USER+msgComplete, 0, 0 );
  WM_USER+msgComplete: AutoCompleteWord( FAutoCompletionList.LVCurItem );
  WM_SIZE: // ��������� ������ �������:
    FAutoCompletionList.LVColWidth[ 0 ] := FAutoCompletionList.ClientWidth - 2;
  WM_USER+msgShow:
    begin
      FAutoCompletionList.LVCurItem := FAutoBestFirst;
      FAutoCompletionList.LVMakeVisible( FAutoBestFirst, FALSE );
    end;
  END;
end;

function THilight.CanRedo: Boolean;
begin
  {$IFDEF ProvideUndoRedo}
  Result := FRedoList.Count > 0;
  {$ELSE}
  Result := FALSE;
  {$ENDIF}
end;

function THilight.CanUndo: Boolean;
begin
  {$IFDEF ProvideUndoRedo}
  Result := FUndoList.Count > 0;
  {$ELSE}
  Result := FALSE;
  {$ENDIF}
end;

procedure THilight.CaretToView;
begin
  if Caret.X < LeftCol then
    LeftCol := Caret.X
  else
  if LeftCol + FMemo.ClientWidth div CharWidth < Caret.X + 1 then
    LeftCol := Caret.X + 1 - FMemo.ClientWidth div CharWidth;
  if Caret.Y < TopLine then
    TopLine := Caret.Y
  else
  if TopLine + LinesPerPage <= Caret.Y then
    TopLine := Caret.Y - LinesPerPage + 1;
  Caret := Caret;
end;

procedure THilight.Changed;
var y, k: Integer;
    L: KOLString;
begin
  if FChangeLevel <= 0 then Exit;
  Dec( FChangeLevel );
  if FChangeLevel = 0 then
  begin
    {$IFDEF ProvideUndoRedo}
    if not FUndoingRedoing then
    begin
      if FUndoList.Last[ 1 ] = 'B' then // �� ���� ���������
      begin
        FUndoList.Delete( FUndoList.Count-1 ); Exit;
      end
        else // ����������� ������� ���������
      begin
        FRedoList.Clear;
        FUndoList.Add( 'E' + Int2Str( Caret.X ) + ':' + Int2Str( Caret.Y ) );
        // ������� ����������� ��� ������ ���������������� ���������
        // � �������� ����� ������:
        k := FUndoList.Count;
        if (k >= 6) and
           (FUndoList.Items[ k-2 ][ 1 ] = 'R') and
           (FUndoList.Items[ k-3 ][ 1 ] = 'B') and
           (FUndoList.Items[ k-4 ][ 1 ] = 'E') and
           (FUndoList.Items[ k-5 ][ 1 ] = 'R') and
           (FUndoList.Items[ k-6 ][ 1 ] = 'B') then
        begin
          L := FUndoList.Items[ k-5 ];
          Delete( L, 1, 1 );
          y := Str2Int( L );
          if y = Caret.Y then
          begin // ��, ��������� � ��� �� ������:
            FUndoList.Delete( k-2 );
            FUndoList.Delete( k-3 );
            FUndoList.Delete( k-4 );
            { �� ����� ������ ����������� ������ ��������� ������,
              � ������� ������������ ����� ���������� ������� }
          end;
        end;
      end;
    end;
    {$ENDIF}
    if Assigned( FMemo.OnChange ) then
      FMemo.OnChange( FMemo );
  end;
end;

procedure THilight.Changing;
begin
  Inc( FChangeLevel );
  {$IFDEF ProvideUndoRedo}
  if FUndoingRedoing then Exit;
  if FChangeLevel = 1 then
    FUndoList.Add( 'B' + Int2Str( Caret.X ) + ':' + Int2Str( Caret.Y ) );
  {$ENDIF}
end;

function THilight.CharWidth: Integer;
begin
  if FCharWidth = 0 then
  begin
    FBitmap.Canvas.Font.Assign( FMemo.Font );
    FCharWidth := FMemo.Canvas.TextWidth( 'W' );
  end;
  Result := FCharWidth;
end;

procedure THilight.Clear;
var i: Integer;
begin
  Text := '';
  {$IFDEF ProvideUndoRedo}
  FUndoList.Clear;
  FRedoList.Clear;
  {$ENDIF}
  {$IFDEF ProvideBookmarks}
  for i := 0 to 9 do
    Bookmarks[ i ] := MakePoint( 0, 0 );
  {$ENDIF}
end;

function THilight.Client2Coord(const P: TPoint): TPoint;
begin
  Result := MakePoint( P.X div CharWidth + LeftCol,
                       P.Y div LineHeight + TopLine );
end;

function THilight.ColumnsVisiblePartial: Integer;
begin
  Result := FMemo.ClientWidth div CharWidth;
  if Result * CharWidth < FMemo.ClientWidth then
    Inc( Result );
end;

procedure THilight.DeleteLine(y: Integer; UseScroll: Boolean);
var R: TRect;
begin
  if y >= Count then Exit;
  Changing;
  DeleteLine1( y );
  if (y >= TopLine) and (y < TopLine + LinesVisiblePartial) then
  begin
    if UseScroll and (y < TopLine + LinesPerPage) then
    begin
      R := MakeRect( 0, (y+1 - TopLine)*LineHeight, FMemo.ClientWidth,
           FMemo.ClientHeight );
      ScrollWindowEx( FMemo.Handle, 0, -LineHeight, @ R, nil, 0, nil,
        SW_INVALIDATE );
    end
      else
    begin
      R := MakeRect( 0, (y - TopLine)*LineHeight, FMemo.ClientWidth,
           FMemo.ClientHeight );
      InvalidateRect( FMemo.Handle, @ R, TRUE );
    end;
  end;
  Changed;
  {$IFDEF ProvideBookmarks}
  FixBookmarks( MakePoint( 0, y ), 0, -1 );
  {$ENDIF}
  TopLine := TopLine;
end;

procedure THilight.DeleteLine1(y: Integer);
begin
  if y >= Count then Exit;
  if Assigned( fOnDeleteLine ) then
    fOnDeleteLine( FMemo, y );
  {$IFDEF ProvideUndoRedo}
  if not FUndoingRedoing then
    FUndoList.Add( 'D' + Int2Str( y ) + '=' +  FLines.Items[ y ] );
  {$ENDIF}
  FLines.Delete( y );
end;

procedure THilight.DeleteSelection;
var i, n: Integer;
    L: KOLString;
begin
  Changing;
  Caret := SelBegin;
  i := SelBegin.Y + 1;
  n := 0;
  while i < SelEnd.Y do
  begin // ��������� ������ �������
    DeleteLine1( i );
    dec( FSelEnd.Y );
    inc( n );
  end;
  L := Copy( Lines[ SelBegin.Y ], 1, SelBegin.x );
  if Length( L ) < SelBegin.x then
    L := L + StrRepeat( ' ', SelBegin.x - Length( L ) );
  L := L + CopyEnd( Lines[ SelEnd.y ], SelEnd.x + 1 );
  if SelBegin.y < SelEnd.y then
  begin // ����������� ��� ������
    DeleteLine( SelEnd.y, n = 0 );
  end;
  Lines[ SelBegin.y ] := L;
  if n > 0 then
  begin
    {$IFDEF ProvideBookmarks}
    FixBookmarks( SelBegin, 0, -n );
    {$ENDIF}
    TopLine := TopLine;
    FMemo.Invalidate;
  end;
  SetSel( SelBegin, SelBegin, SelBegin );
  Changed;
  CaretToView;
end;

destructor THilight.Destroy;
begin
  FLines.Free; // �������� �����
  FBitmap.Free;
  {$IFDEF UseBufferBitmap}
  Free_And_Nil( FBufferBitmap );
  {$ENDIF}
  {$IFDEF ProvideUndoRedo}
  FUndoList.Free;
  FRedoList.Free;
  {$ENDIF}
  {$IFDEF ProvideAutoCompletion}
  if Assigned( FAutoCompletionForm ) then
  begin
    FAutoCompletionForm.Close;
    FAutoCompletionForm := nil;
  end;
  Free_And_Nil( FDictionary );
  {$ENDIF}
  inherited;
end;

procedure THilight.DoKeyChar(Key: KOLChar);
var S, S1: KOLString;
    t: Integer;

    procedure InsertChar( C: KOLChar );
    begin
      //if Caret.Y < 0 then Caret := MakePoint( 0, Caret.X );
      S := Lines[ Caret.Y ];
      while Length( S ) < Caret.X do S := S + ' ';
      S := Copy( S, 1, Caret.X ) + C + CopyEnd( S, Caret.X+1 );
      Lines[ Caret.Y ] := S;
    end;

    procedure ReplaceChar( C: KOLChar );
    begin
      S := Lines[ Caret.Y ];
      while Length( S ) < Caret.X do S := S + ' ';
      S := Copy( S, 1, Caret.X ) + C + CopyEnd( S, Caret.X+2 );
      Lines[ Caret.Y ] := S;
    end;

{$IFDEF ProvideAutoCompletion}
var NeedAdd2Dictionary: Integer;
    CanShowAutoCompletion: Boolean;
{$ENDIF}
begin
  if oeReadOnly in Options then Exit;
  Changing;
  {$IFDEF ProvideAutoCompletion}
  NeedAdd2Dictionary := -1;
  CanShowAutoCompletion := FALSE;
  {$ENDIF}
  TRY
    S := Lines[ Caret.Y ];
    S1 := S;
    CASE Key OF
    #27: ; // escape - ���������� (��� ��������� ���� Autocompletion)
    #13: // enter
      begin
        if SelectionAvailable then
        begin
          Caret := SelBegin;
          DeleteSelection;
          if oeOverwrite in Options then
          begin
            CaretToView;
            Changed;
            Exit;
          end;
        end;
        if oeOverwrite in Options then
        begin // ������ ������� � ������ ��������� ������ ��� Overwrite
          if Caret.Y = Count-1 then
            Lines[ Caret.Y+1 ] := '';
          {$IFDEF ProvideAutoCompletion}
          NeedAdd2Dictionary := Caret.Y;
          {$ENDIF}
          Caret := MakePoint( 0, Caret.Y+1 );
        end
          else
        begin // ��������� ������ �� 2 � ������� � ������ ��������� ������
          S := Lines[ Caret.Y ];
          Lines[ Caret.Y ] := Copy( S, 1, Caret.X );
          S := CopyEnd( S, Caret.X+1 );
          {$IFDEF ProvideAutoCompletion}
          NeedAdd2Dictionary := Caret.Y;
          {$ENDIF}
          Caret := MakePoint( 0, Caret.Y+1 );
          {$IFDEF ProvideSmartTabs}
          // ���������� ����������� ����������� �������� ��� SmartTab
          t := 0;
          if Assigned(fOnNewLine) then
            t := fOnNewLine(FMemo, Caret.Y, S)
          else if oeSmartTabs in Options then
          begin
            t := FindNextTabPos( Caret );
            if t > 0 then
              S := StrRepeat( ' ', t ) + S;
          end;
          Caret := MakePoint( t, Caret.Y );
          {$ENDIF}
          InsertLine( Caret.Y, S, TRUE );
        end;
        CaretToView;
      end;
    #9: // tab
      begin
        {$IFDEF ProvideSmartTabs}
        if not SelectionAvailable and (oeOverwrite in Options) then
          SetSel( Caret, MakePoint( Caret.X+1, Caret.Y ), Caret );
        if SelectionAvailable then
        begin
          Caret := SelBegin;
          DeleteSelection;
          CaretToView;
        end;
        S := Lines[ Caret.Y ];
        t := Caret.X;
        if oeSmartTabs in Options then
          t := FindNextTabPos( Caret );
        {$IFDEF ProvideAutoCompletion}
        NeedAdd2Dictionary := Caret.Y;
        {$ENDIF}
        if t > Caret.X then
        begin
          S := Copy( S, 1, Caret.X ) + StrRepeat( ' ', t - Caret.X ) +
               CopyEnd( S, Caret.X + 1 );
          Lines[ Caret.Y ] := S;
          Caret := MakePoint( t, Caret.Y );
          SetSel( Caret, Caret, Caret );
        end
          else
        {$ENDIF ProvideSmartTabs}
        begin
          {$IFDEF ProvideCustomTabs}
          t := GiveNextTabPos( Caret.X );
          S := Copy( S, 1, Caret.X ) + StrRepeat( ' ', t - Caret.X ) +
               CopyEnd( S, Caret.X + 1 );
          Lines[ Caret.Y ] := S;
          Caret := MakePoint( t, Caret.Y );
          SetSel( Caret, Caret, Caret );
          {$ELSE}
          InsertChar( #9 );
          Caret := MakePoint( ((Caret.X + 8) div 8) * 8, Caret.Y );
          {$ENDIF}
        end;
      end;
    #8: // backspace
      begin
        if SelectionAvailable then
        begin
          Caret := SelBegin;
          DeleteSelection;
          CaretToView;
          Exit;
        end;
        if Caret.X > 0 then // �������� �������
        begin
          {$IFDEF ProvideAutoCompletion}
          NeedAdd2Dictionary := Caret.Y;
          {$ENDIF}
          {$IFDEF ProvideSmartTabs}
          t := Caret.X;
          if (oeSmartTabs in Options) and (t > 0) and
             (Trim( Copy( S, 1, t ) ) = '') then
            t := FindPrevTabPos( Caret );
          if t < Caret.X then
          begin
            Delete( S, t+1, Caret.X-t );
            Lines[ Caret.Y ] := S;
            Caret := MakePoint( t, Caret.Y );
          end
            else
          {$ENDIF}
          begin
            Delete( S, Caret.X, 1 );
            Lines[ Caret.Y ] := S;
            Caret := MakePoint( Caret.X-1, Caret.Y );
          end;
        end
          else // ������� ������ � ����������
        begin
          if Caret.Y = 0 then Exit; // �� � ��� �������
          S1 := Lines[ Caret.Y-1 ];
          Caret := MakePoint( Length( S1 ), Caret.Y-1 );
          {$IFDEF ProvideAutoCompletion}
          NeedAdd2Dictionary := Caret.Y;
          {$ENDIF}
          S1 := S1 + S;
          Lines[ Caret.Y ] := S1;
          DeleteLine( Caret.Y+1, TRUE );
        end;
      end;
    else // any char (edit)
      if Key < ' ' then Exit; // ������ ����������� ���� ����������
      if not SelectionAvailable and (oeOverwrite in Options) then
        SetSel( Caret, MakePoint( Caret.X+1, Caret.Y ), Caret );
      if SelectionAvailable and (oeOverwrite in Options) then
      begin
        Caret := SelBegin;
        ReplaceChar( Key );
      end
      else begin
        if SelectionAvailable then
        begin
          Caret := SelBegin;
          DeleteSelection;
          CaretToView;
        end;
        InsertChar( Key );
      end;
      Caret := MakePoint( Caret.X+1, Caret.Y );
      {$IFDEF ProvideAutoCompletion}
      if {$IFDEF UNICODE_CTRLS} (Ord(Key) <= 255) and
         (Char(Ord(Key)) in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ] )
         or (Ord(Key) > 255)
         {$ELSE} Key in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ]
         {$ENDIF} then
        CanShowAutocompletion := TRUE
      else
        NeedAdd2Dictionary := Caret.Y;
      {$ENDIF}
    END;
    SetSel( Caret, Caret, Caret );
  FINALLY
    Changed;
    CaretToView;
  END;
  {$IFDEF ProvideAutoCompletion}
  if (NeedAdd2Dictionary >= 0) and (NeedAdd2Dictionary < Count) then
    AutoAdd2Dictionary( FLines.ItemPtrs[ NeedAdd2Dictionary ] );
  if CanShowAutocompletion then
    AutoCompletionShow
  else
    AutoCompletionHide;
  {$ENDIF}
end;

procedure THilight.DoKeyDown(Key, Shift: Integer);
  procedure MoveLeftUp( NewCaretX, NewCaretY: Integer );
  begin
    {$IFDEF AllowLeftFromColumn0}
    if (NewCaretX < 0) and (NewCaretY > 0) then
    begin
      Dec( NewCaretY );
      NewCaretX := Length( Lines[ NewCaretY ] );
    end;
    {$ENDIF}
    Caret := MakePoint( Max( 0, NewCaretX ),
                        //Min( Count-1, Max( 0, NewCaretY ) ) );
                        Max( 0, Min( Count-1, NewCaretY ) ) );
    CaretToView;
    if Shift and MK_SHIFT <> 0 then SetSel( Caret, SelFrom, SelFrom )
    else SetSel( Caret, Caret, Caret );
  end;
  procedure MoveRightDown( NewCaretX, NewCaretY: Integer );
  begin
    Caret := MakePoint( Max( 0, NewCaretX ),
                        //Min( Count-1, Max( 0, NewCaretY ) ) );
                        Max( 0, Min( Count-1, NewCaretY ) ) );
    CaretToView;
    if Shift and MK_SHIFT <> 0 then SetSel( SelFrom, Caret, SelFrom )
    else SetSel( Caret, Caret, Caret );
  end;
var NewCaret: TPoint;
    S: KOLString;
begin
  Changing;
  TRY
    CASE Key OF
    VK_LEFT:     {$IFDEF CtrlArrowMoveByWords}
                 if Shift and MK_CONTROL <> 0
                 then begin
                      {NewCaret := WordAtPosStart( Caret );
                      if (NewCaret.y = Caret.y) and (NewCaret.x = Caret.y) then
                      NewCaret := FindPrevWord( NewCaret, TRUE );}
                      NewCaret := FindPrevWord( Caret, TRUE );
                      MoveLeftUp   ( NewCaret.X, NewCaret.Y );
                      end
                 else
                 {$ENDIF}
                      MoveLeftUp   ( Caret.X-1, Caret.Y );
    VK_RIGHT:    {$IFDEF CtrlArrowMoveByWords}
                 if Shift and MK_CONTROL <> 0
                 then begin
                      {NewCaret := WordAtPosStart( Caret );
                      Inc( NewCaret.X, Length( WordAtPos( Caret ) ) );
                      if (NewCaret.y = Caret.y) and (NewCaret.x = Caret.y) then
                        NewCaret := FindNextWord( NewCaret, TRUE );}
                      NewCaret := Caret;
                      Inc( NewCaret.X, Length( WordAtPos( NewCaret ) ) );
                      NewCaret := FindNextWord( NewCaret, TRUE );
                      //Inc( NewCaret.X, Length( WordAtPos( NewCaret ) ) );
                      MoveRightDown( NewCaret.X, NewCaret.Y );
                      end
                 else
                 {$ENDIF}
                      MoveRightDown( Caret.X+1, Caret.Y );
    VK_HOME:     if Shift and MK_CONTROL <> 0
                 then MoveLeftUp   ( 0, 0 )
                 else MoveLeftUp   ( 0, Caret.Y );
    VK_END:      if Shift and MK_CONTROL <> 0
                 then MoveRightDown( 0, Count-1 )
                 else MoveRightDown( Length( TrimRight( Lines[ Caret.Y ] ) ),
                                     Caret.Y );
    VK_UP:       MoveLeftUp   ( Caret.X, Caret.Y-1 );
    VK_DOWN:     MoveRightDown( Caret.X, Caret.Y+1 );
    VK_PAGE_UP:  MoveLeftUp   ( Caret.X, Caret.Y - LinesPerPage );
    VK_PAGE_DOWN:MoveRightDown( Caret.X, Caret.Y + LinesPerPage );
    {$IFNDEF Only_ReadOnly}
    VK_DELETE:   if oeReadOnly in Options then
                 begin
                   Changed; Exit;
                 end
                   else
                 if SelectionAvailable then
                 begin
                   if Shift and MK_SHIFT <> 0 then
                     FMemo.Perform( WM_CUT, 0, 0 )
                   else
                   begin
                     Caret := SelBegin;
                     DeleteSelection;
                   end;
                 end
                   else
                 if Caret.X >= Length( Lines[ Caret.Y ] ) then
                 begin // ������� �����
                   if Caret.Y = Count-1 then Exit;
                   S := Lines[ Caret.Y ];
                   while Length( S ) < Caret.X do
                     S := S + ' ';
                   Lines[ Caret.Y ] := S + Lines[ Caret.Y+1 ];
                   DeleteLine( Caret.Y+1, TRUE );
                   SetSel( Caret, Caret, Caret );
                 end
                   else
                 begin // �������� ������ �������
                   S := Lines[ Caret.Y ];
                   Delete( S, Caret.X+1, 1 );
                   Lines[ Caret.Y ] := S;
                 end;
    VK_INSERT:   if oeReadOnly in Options then Exit
                 else
                 if Shift and MK_SHIFT <> 0 then
                   FMemo.Perform( WM_PASTE, 0, 0 )
                 else
                 if Shift and MK_CONTROL <> 0 then
                   FMemo.Perform( WM_COPY, 0, 0 )
                 else
                 {$IFDEF AutoOverwrite}
                 if Shift = 0 then
                 begin
                   if oeOverwrite in Options then
                     Options := Options - [ oeOverwrite ]
                   else
                     Options := Options + [ oeOverwrite ];
                   Caret := Caret;
                 end
                 {$ENDIF}     ;
    {$IFDEF ProcessHotkeys}
    Word( 'V' ): if oeReadOnly in Options then Exit
                 else
                 if Shift and MK_CONTROL <> 0 then
                   FMemo.Perform( WM_PASTE, 0, 0 );
    Word( 'Y' ): if oeReadOnly in Options then Exit
                 else
                 if Shift and MK_CONTROL <> 0 then
                 begin
                   DeleteLine( Caret.Y, TRUE );
                   Caret := Caret;
                 end;
    Word( 'X' ): if oeReadOnly in Options then Exit
                 else
                 if Shift and MK_CONTROL <> 0 then
                   FMemo.Perform( WM_CUT, 0, 0 );
    {$ENDIF}
    {$ENDIF}
    {$IFDEF ProcessHotkeys}
    Word( 'C' ): if Shift and MK_CONTROL <> 0 then
                   FMemo.Perform( WM_COPY, 0, 0 );
    {$IFDEF ProvideUndoRedo}
    Word( 'Z' ): begin
                   while FChangeLevel > 0 do Changed;
                   { ��������� ������ B<x>:<y>, ����������� ������� Changing }
                   if Shift and MK_CONTROL <> 0 then
                   begin
                     if Shift and MK_SHIFT <> 0 then // ctrl+shift+Z - redo
                       Redo
                     else
                       Undo;
                   end;
                   Exit; { ������������� ����� Changed }
                 end;
    {$ENDIF}
    {$ENDIF}
    END;
  FINALLY
    Changed;
  END;
end;

procedure THilight.DoMouseDown(X, Y: Integer; Shift: Integer);
var Pt: TPoint;
begin
  Pt := MakePoint(
    X div CharWidth + LeftCol,
    Y div LineHeight + TopLine
  );
  if Shift and MK_SHIFT <> 0 then
    SetSel( SelFrom, Pt, SelFrom )
  else
    SetSel( Pt, Pt, Pt );
  Caret := Pt;
  FMouseDown := TRUE;
  SetCapture( FMemo.Handle );
end;

procedure THilight.DoMouseMove(X, Y: Integer);
var Pt: TPoint;
begin
  if not FMouseDown then
    Exit; // todo: �������� �������� ������� �� �������� ����?
  if x < 0 then x := 0;
  if y < 0 then y := 0;
  Pt := MakePoint(
    X div CharWidth + LeftCol,
    Y div LineHeight + TopLine
  );
  SetSel( SelFrom, Pt, SelFrom );
  Caret := Pt;
  CaretToView;
end;

procedure THilight.DoPaint(DC: HDC);
var x, y, i, L: Integer;
    R, R0, Rsel, CR: TRect;
    OldClip, NewClip: HRgn;
    P: TPoint;
    Attrs: TTokenAttrs;
    Canvas: PCanvas;
begin
  CR := FMemo.ClientRect;
  NewClip := CreateRectRgnIndirect( FMemo.ClientRect );
  CombineRgn( NewClip, NewClip, FMemo.UpdateRgn, RGN_AND );
  SelectClipRgn( DC, NewClip );
  DeleteObject( NewClip );
  y := 0;
  {$IFDEF UseBufferBitmap}
  if (FBufferBitmap <> nil) and (
     (FBufferBitmap.Width < FMemo.ClientWidth) or
     (FBufferBitmap.Height < LineHeight) ) then
     Free_And_Nil( FBufferBitmap );
  if FBufferBitmap = nil then
    FBufferBitmap := NewBitmap( FMemo.ClientWidth, LineHeight );
  Canvas := FBufferBitmap.Canvas;
  {$ENDIF}
  Canvas.Font.Assign( FMemo.Font );
  for i := TopLine to TopLine + LinesPerPage + 1 do
  begin
    if y >= CR.Bottom then break;
    if i >= Count then break;
    R := MakeRect( 0, y, CR.Right, y + LineHeight );
    R0 := R;
    {$IFDEF UseBufferBitmap}
    OffsetRect( R0, -R0.Left, -R0.Top );
    {$ENDIF}
    if SelectionAvailable and (FSelBegin.Y <= i) and (FSelEnd.Y >= i) then
    begin // �� ������� ���� ����� ������ �������� � ���������:
      FMemo.Canvas.Brush.Color := clHighlight;
      FMemo.Canvas.Font.Color := clHighlightText;
      FMemo.Canvas.Font.FontStyle := [ ];
      Rsel := R;
      if i = SelBegin.Y then
        Rsel.Left := Max( 0, (FSelBegin.X - FLeftCol)*CharWidth );
      if i = SelEnd.Y then
        Rsel.Right := Max( 0, (FSelEnd.X - FLeftCol)*CharWidth );
      if Rsel.Right > Rsel.Left then
      begin
        OldClip := CreateRectRgn( 0,0,0,0 );
        GetClipRgn( DC, OldClip );
        NewClip := CreateRectRgnIndirect( Rsel );
        SelectClipRgn( DC, NewClip );
        FMemo.Canvas.TextRect( R, 0, R.Top,
          CopyEnd( Lines[ i ], FLeftCol+1 ) );
        SelectClipRgn( DC, OldClip );
        ExtSelectClipRgn( DC, NewClip, RGN_DIFF );
        DeleteObject( NewClip );
        DeleteObject( OldClip );
      end;
    end;
    if RectInRegion( FMemo.UpdateRgn, R ) then
    begin
      Canvas.Brush.Color := FMemo.Color;
      Canvas.Font.Color := clWindowText;
      Canvas.Font.FontStyle := [ ];
      {$IFDEF ProvideHighlight}
      if Assigned( FOnScanToken ) and (oeHighlight in Options) then
      begin
        Canvas.FillRect( R0 );
        //Canvas.Brush.BrushStyle := bsClear;
        P := MakePoint( 0, i );
        Attrs.fontcolor := clWindowText;
        Attrs.backcolor := clWindow;
        Attrs.fontstyle := [ ];
        while P.X < LeftCol+ColumnsVisiblePartial do
        begin
          L := OnScanToken( FMemo, P, Attrs );
          if L <= 0 then L := Length( Lines[ i ] ) - P.X;
          if L <= 0 then break;
          if P.X + L >= LeftCol then
          begin
            Canvas.Font.Color := Attrs.fontcolor;
            Canvas.Font.FontStyle := Attrs.fontstyle;
            Canvas.Brush.Color := Attrs.backcolor;
            while L > 0 do
            begin
              Canvas.TextOut( R0.Left + (P.X - LeftCol)*CharWidth, R0.Top,
                              Copy( Lines[ i ], P.X+1, 1 ) );
              Inc( P.X );
              Dec( L );
            end;
          end
            else P.X:= P.X + L;
        end;
        Canvas.Brush.BrushStyle := bsSolid;
        {$IFDEF DrawRightMargin}
        x := (RightMarginChars - LeftCol)*CharWidth;
        {$IFDEF RightZigzagIndicateLongLine}
        if Length( TrimRight( Lines[ i ] ) ) > RightMarginChars then
        begin
          Canvas.Pen.Color := RightMarginColor;
          Canvas.MoveTo( x, R0.Top );
          Canvas.LineTo( x-2, R0.Top + LineHeight div 3 );
          Canvas.LineTo( x+2, R0.Top + LineHeight * 2 div 3 );
          Canvas.LineTo( x, R0.Bottom );
        end
          else
        {$ENDIF}
        begin
          Canvas.Brush.Color := RightMarginColor;
          Canvas.FillRect( MakeRect( x, R0.Top, x+1, R0.Bottom ) );
          Canvas.Brush.Color := FMemo.Color;
        end;
        {$ENDIF DrawRightMargin}
        {$IFDEF UseBufferBitmap}
        BitBlt( DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
                Canvas.Handle, 0, 0, SRCCOPY );
        {$ENDIF}
      end
        else
      {$ENDIF}
      begin
        FMemo.Canvas.Brush.Color := FMemo.Color;
        FMemo.Canvas.Font.Color := clWindowText;
        FMemo.Canvas.Font.FontStyle := [ ];
        FMemo.Canvas.TextRect( R, 0, R.Top, CopyEnd( Lines[ i ], LeftCol + 1 ) );
        {$IFDEF DrawRightMargin}
        x := (RightMarginChars - LeftCol)*CharWidth;
        {$IFDEF RightZigzagIndicateLongLine}
        if Length( TrimRight( Lines[ i ] ) ) > RightMarginChars then
        begin
          FMemo.Canvas.Pen.Color := RightMarginColor;
          FMemo.Canvas.MoveTo( x, R.Top );
          FMemo.Canvas.LineTo( x-2, R.Top + LineHeight div 3 );
          FMemo.Canvas.LineTo( x+2, R.Top + LineHeight * 2 div 3 );
          FMemo.Canvas.LineTo( x, R.Bottom );
        end
          else
        {$ENDIF}
        FMemo.Canvas.Brush.Color := RightMarginColor;
        FMemo.Canvas.FillRect( MakeRect( x, R.Top, x+1, R.Bottom ) );
        FMemo.Canvas.Brush.Color := FMemo.Color;
        {$ENDIF}
      end;
      //GdiFlush;
    end;
    y := y + LineHeight;
  end;
  if y < CR.Bottom then
  begin // ������� ������� �� ������� ��������
    {$IFDEF DrawRightMargin}
    x := (RightMarginChars - LeftCol)*CharWidth;
    R := MakeRect( 0, y, x, CR.Bottom );
    FMemo.Canvas.Brush.Color := FMemo.Color;
    FMemo.Canvas.FillRect( R );
    if x < CR.Right then
    begin
      FMemo.Canvas.Brush.Color := RightMarginColor;
      R.Left := x;
      R.Right := x+1;
      FMemo.Canvas.FillRect( R );
      FMemo.Canvas.Brush.Color := FMemo.Color;
      R.Left := x+1;
      R.Right := CR.Right;
      FMemo.Canvas.FillRect( R );
    end;
    {$ELSE}
    R := MakeRect( 0, y, CR.Right, CR.Bottom );
    FMemo.Canvas.FillRect( R );
    {$ENDIF}
  end;
end;

procedure THilight.DoScroll(Cmd, wParam: DWord);
begin
  CASE Cmd OF
  SC_HSCROLL:
    CASE loWord( wParam ) OF
    SB_LEFT, SB_LINELEFT:  LeftCol := LeftCol-1;
    SB_RIGHT,SB_LINERIGHT: LeftCol := LeftCol+1;
    SB_PAGELEFT:           LeftCol := LeftCol - FMemo.ClientWidth div CharWidth;
    SB_PAGERIGHT:          LeftCol := LeftCol + FMemo.ClientWidth div CharWidth;
    SB_THUMBTRACK:         LeftCol := HiWord( wParam );
    END;
  SC_VSCROLL:
    CASE loWord( wParam ) OF
    SB_LEFT, SB_LINELEFT:  TopLine := TopLine-1;
    SB_RIGHT,SB_LINERIGHT: TopLine := TopLine+1;
    SB_PAGELEFT:           TopLine := TopLine - LinesPerPage;
    SB_PAGERIGHT:          TopLine := TopLine + LinesPerPage;
    SB_THUMBTRACK:         TopLine := HiWord( wParam );
    END;
  END;
end;

procedure THilight.DoUndoRedo(List1, List2: PStrList);
var L1, L2: KOLString;
    x, y: Integer;
begin
  // ������: ������������� ��������� �� ������ List1,
  // ��������� �������� ��������� � ������ List2
  FUndoingRedoing := TRUE;
  Assert( List1.Last[ 1 ] = 'E' );
  List2.Add( 'B' + CopyEnd( List1.Last, 2 ) );
  List1.Delete( List1.Count-1 );
  while TRUE do
  begin
    L1 := List1.Last;
    List1.Delete( List1.Count-1 );
    CASE L1[ 1 ] OF
    'A': // ����: ���������� ������ � �����, ��������: �������� ��������� ������
      begin
        L2 := 'D' + Int2Str( Count-1 ) + '=' + FLines.Last;
        FLines.Delete( Count-1 );
      end;
    'D': // ����: �������� ������, ��������: ������� ������
      begin
        Delete( L1, 1, 1 );
        y := Str2Int( L1 );
        Parse( L1, '=' );
        L2 := 'I' + Int2Str( y );
        InsertLine( y, L1, FALSE );
      end;
    'I': // ����: ������� ������, ��������: �������� ������
      begin
        Delete( L1, 1, 1 );
        y := Str2Int( L1 );
        L2 := 'D' + Int2Str( y ) + '=' + Lines[ y ];
        DeleteLine( y, FALSE );
      end;
    'R': // ����: ��������� ������
      begin
        Delete( L1, 1, 1 );
        y := Str2Int( L1 );
        Parse( L1, '=' );
        L2 := 'R' + Int2Str( y ) + '=' + Lines[ y ];
        Lines[ y ] := L1;
      end;
    'B': // ����� �� ������ ������ ���������
      begin
        L2 := 'E' + CopyEnd( L1, 2 );
        Delete( L1, 1, 1 );
        x := Str2Int( L1 );
        Parse( L1, ':' );
        y := Str2Int( L1 );
        // ����� ������� � ������� �� ������ ����� ���������
        Caret := MakePoint( x, y );
        SetSel( Caret, Caret, Caret );
        CaretToView;
      end;
    END;
    List2.Add( L2 );
    if L2[ 1 ] = 'E' then break;
  end;
  FUndoingRedoing := FALSE;
  AdjustHScroll;
  AdjustVScroll;
  // �� ���������, ������� OnChange:
  if Assigned( FMemo.OnChange ) then
    FMemo.OnChange( FMemo );
end;

procedure THilight.FastFillDictionary;
type
  TByteArray = array[ 0..100000 ] of Byte;
  PByteArray = ^TByteArray;
var i: Integer;
    HashTable: PByteArray;
    S, From: PKOLChar;
    TempMemStream: PStream;
    ChkSum: DWORD;
    EOL: KOLChar;
    DicAsTxt: KOLString;
begin
  FDictionary.Clear;
  HashTable := AllocMem( 65536 ); // ����� ��� 512� 1-������ ������� "�����������"
  TempMemStream := NewMemoryStream; // ���� ����� ����������� �����
  EOL := #13;
  TRY
    for i := 0 to FLines.Count-1 do
    begin
      S := FLines.ItemPtrs[ i ];
      while S^ <> #0 do
      begin
        if {$IFDEF UNICODE_CTRLS}
           (Ord(S^) <= 255) and (Char(Ord(S^)) in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ])
           or (Ord(S^) > 255)
           {$ELSE} S^ in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ]
           {$ENDIF} then
        begin
          From := S;
          ChkSum := Byte( From^ );
          inc( S );
          while {$IFDEF UNICODE_CTRLS}
                (Ord(S^) <= 255) and (Char(Ord(S^)) in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ])
                or (Ord(S^) > 255)
                {$ELSE} S^ in [ {$INCLUDE HilightLetters.inc}, '0'..'9' ]
                {$ENDIF} do
          begin
            {$IFDEF UNICODE_CTRLS}
            if Ord(S^) > 255 then
            ChkSum := (( ChkSum shl 1) or (ChkSum shr 18) and 1 ) xor Ord(S^)
            else
            {$ENDIF UNICODE_CTRLS}
            ChkSum := (( ChkSum shl 1) or (ChkSum shr 18) and 1 ) xor
              {$IFDEF AutocompletionCaseSensitive}
              Ord( S^ )
              {$ELSE}
              Ord( Upper[ Char(Ord( S^ )) ] )
              {$ENDIF}
              ;
            inc( S );
          end;
          if DWORD(S) - DWORD(From) > DWORD(AutoCompleteMinWordLength) then
          begin
            ChkSum := ChkSum and $7FFFF;
            if HashTable[ ChkSum shr 3 ] and (1 shl (ChkSum and 7)) = 0 then
            begin
              HashTable[ ChkSum shr 3 ] := HashTable[ ChkSum shr 3 ] or
                (1 shl (ChkSum and 7));
              TempMemStream.Write( From^, DWORD( S ) - DWORD( From ) );
              TempMemStream.Write( EOL, Sizeof( KOLChar ) );
            end;
          end;
        end
          else Inc( S );
      end;
    end;
    if TempMemStream.Position > 0 then
    begin
      SetString( DicAsTxt, PKOLChar( TempMemStream.Memory ),
                 TempMemStream.Position div Sizeof( KOLChar ) );
      FDictionary.Text := DicAsTxt;
      FDictionary.Sort(
        {$IFDEF AutocompletionCaseSensitive}
        TRUE
        {$ELSE}
        FALSE
        {$ENDIF}
      );
    end;
  FINALLY
    TempMemStream.Free;
    FreeMem( HashTable );
  END;
end;

function THilight.FindNextTabPos(const FromPos: TPoint): Integer;
var P, P1, P2: TPoint;
begin
  P := FromPos;
  P1 := P;
  Result := P.X;
  while (P.Y > 0) or (P.X > 0) do
  begin
    P2 := P;
    P := FindPrevWord( P2, FALSE );
    if (P.X = P2.X) and (P.Y = P2.Y) then
    begin
      Result := P.X;
      break;
    end
      else
    if (P.X >= FromPos.X) and ((Result = FromPos.X) or (P.Y = P1.Y)) then
    begin
      Result := P.X;
      P1 := P;
    end
      else
    if (P.Y < P1.Y) or (P.X <= FromPos.X) then  break;
  end;
end;

function THilight.FindNextWord(const FromPos: TPoint;
         LookForLettersDigits: Boolean): TPoint;
var S: KOLString;
    i, y: Integer;
begin
  y := FromPos.Y;
  i := FromPos.X;
  while TRUE do
  begin
    S := Lines[ y ];
    while i < Length( S )-1 do
    begin
      inc( i );
      if LookForLettersDigits and IsLetterDigit( S[ i+1 ] ) or
         not LookForLettersDigits and (S[ i+1 ] > ' ') then
      begin // ������� ��������� �����
        Result := MakePoint( i, y );
        Exit;
      end;
    end;
    // ����� �� ����� ������, ����� ��� �� �������
    if y = Count-1 then // ��� ��������� ������
      break;
    i := -1;
    inc( y );
  end;
  Result := MakePoint( i, y );
end;

function THilight.FindPrevTabPos(const FromPos: TPoint): Integer;
var P, P2: TPoint;
begin
  P := FromPos;
  Result := P.X;
  while (P.Y > 0) or (P.X > 0) do
  begin
    P2 := P;
    P := FindPrevWord( P, FALSE );
    if (P.X = P2.X) and (P.Y = P2.Y) or
       (P.X < FromPos.X) then
    begin
      Result := P.X;
      break;
    end;
  end;
end;

function THilight.FindPrevWord(const FromPos: TPoint;
         LookForLettersDigits: Boolean): TPoint;
var S: KOLString;
    i, y: Integer;
begin
  Result := FromPos;
  y := FromPos.Y;
  i := FromPos.X;
  while TRUE do
  begin
    S := Lines[ y ];
    if i = -1 then i := Length( S )+1
              else dec( i );
    while i > 0 do
    begin
      dec( i );
      if (LookForLettersDigits and
          not IsLetterDigit( (Copy( S, i+1, 1 ) + ' ')[ 1 ] ) or
          not LookForLettersDigits and
          (Copy( S, i+1, 1 ) <= ' '))
         and (i+2 <= Length( S ) )
         and
         (LookForLettersDigits and
          IsLetterDigit( (Copy( S, i+2, 1 ) + ' ')[ 1 ] ) or
          not LookForLettersDigits and
          (Copy( S, i+2, 1 ) > ' ')) then
      begin // ������� ����������� �����
        Result := MakePoint( i+1, y );
        Exit;
      end
        else
      if (i = 0) and (Length( S ) > 0) and IsLetterDigit( S[ 1 ] ) then
      begin
        Result := MakePoint( 0, y );
        Exit;
      end;
    end;
    // ����� �� ������ ������, ����� ��� �� �������
    if y = 0 then // ��� ������ ������
      Exit;
    i := -1;
    dec( y );
  end;
  Result := MakePoint( i, y );
end;

function THilight.FindReplace( S: KOLString; const replaceTo: KOLString;
         const FromPos: TPoint; FindReplaceOptions: TFindReplaceOptions;
         SelectFound: Boolean): TPoint;
var P: TPoint;
    L: KOLString;
    i: Integer;

    function CompareSubstr( var i: Integer ): Boolean;
    var j: Integer;
    begin
      Result := FALSE;
      i := 1;
      j := 1;
      while j <= Length( S ) do
      begin
        if P.X + i > Length( L ) then Exit;
        if not(froSpaces in FindReplaceOptions) and
           (S[ j ] = ' ') then
        begin
          inc( j );
          if not((L[ P.X + i ] = #9) or (L[ P.X+1 ] =' ')) then Exit;
          while (P.X + i <= Length( L )) and
                ((L[ P.X + i ] = #9) or (L[ P.X+1 ] =' ')) do inc( i );
        end
          else
        if froCase in FindReplaceOptions then
        begin
          if L[ P.X + i ] <> S[ j ] then Exit;
          inc( i );
          inc( j );
        end
          else
        begin
          {$IFDEF UNICODE_CTRLS}
          if ( Ord(L[ P.X+i ]) > 255 ) or ( Ord( S[ j ] ) > 255 ) then
          begin
            if L[ P.X + i ] <> S[ j ] then Exit;
          end
            else
          {$ENDIF UNICODE_CTRLS}
          begin
            if Upper[ Char( Ord( L[ P.X + i ] ) ) ] <> Upper[ Char( Ord( S[ j ] ) ) ] then Exit;
          end;
          inc( i );
          inc( j );
        end;
      end;
      Result := TRUE;
    end;
begin
  Result := FromPos;
  if not( froSpaces in FindReplaceOptions ) then
  begin
    {$IFDEF UNICODE_CTRLS}
    while WStrReplace( S, #9, ' ' ) do;
    while WStrReplace( S, '  ', ' ' ) do;
    {$ELSE}
    while StrReplace( S, #9, ' ' ) do;
    while StrReplace( S, '  ', ' ' ) do;
    {$ENDIF}
  end;
  P := FromPos;
  L := Lines[ P.Y ];
  while TRUE do
  begin
    if froBack in FindReplaceOptions then
    begin
      Dec( P.X );
      if P.X < 0 then
      begin
        Dec( P.Y );
        L := Lines[ P.Y ];
        if P.Y < 0 then Exit;
        P.X := Length( L );
        continue;
      end;
    end
    else
    begin
      Inc( P.X );
      if P.X >= Length( L ) then
      begin
        P.X := 0;
        Inc( P.Y );
        if P.Y >= Count then Exit;
        L := Lines[ P.Y ];
      end;
    end;
    if CompareSubstr( i ) then
    begin
      if froReplace in FindReplaceOptions then
      begin
        SelBegin := P;
        SelEnd := MakePoint( P.X+i-1, P.Y );
        Selection := ReplaceTo;
        SelEnd := Caret;
      end
        else
      if SelectFound then
      begin
        SelBegin := P;
        SelEnd := MakePoint( P.X+i-1, P.Y );
        Caret := SelEnd;
      end;
      if not( froReplace in FindReplaceOptions ) or
         not( froAll in FindReplaceOptions ) then
        break;
    end;
  end;
  CaretToView;
  Result := P;
end;

{$IFDEF ProvideBookmarks}
procedure THilight.FixBookmarks(const FromPos: TPoint; deltaX,
  deltaY: Integer);
var i: Integer;
begin
  for i := 0 to 9 do
    if (FBookmarks[ i ].X >= 0) and (FBookmarks[ i ].Y >= 0) then
    begin
      if (FBookmarks[ i ].Y = FromPos.Y) and
         (FBookmarks[ i ].X >= FromPos.X) then
        Inc( FBookmarks[ i ].X, deltaX );
      if (FBookmarks[ I ].Y >= FromPos.Y) then
        Inc( FBookmarks[ i ].Y, deltaY );
    end;
  if Assigned(FOnBookmark) then FOnBookmark(@Self);
end;
{$ENDIF}

function THilight.GetBookMark(IDx: Integer): TPoint;
begin
  if (Idx < 0) or (Idx > 9) then Exit;
  Result := FBookmarks[ Idx ];
end;

function THilight.GetCount: Integer;
begin
  Result := FLines.Count;
end;

function THilight.GetLineData(Idx: Integer): DWORD;
begin
  Result := FLines.Objects[ Idx ];
end;

function THilight.GetLines(Idx: Integer): KOLString;
var i, j: Integer;
begin
  Result := FLines.Items[ Idx ];
  if Assigned( FOnGetLine ) then
    FOnGetLine( FMemo, Idx, Result );
  // ��� ������� ��������� ������������ � ����������� ���������� ��������:
  i := 0;
  while i < Length( Result ) do
  begin
    if Result[ i+1 ] = #9 then
    begin
      j := GiveNextTabPos(i);
      Result := Copy( Result, 1, i ) + StrRepeat( ' ', j-i ) +
                CopyEnd( Result, i+2 );
    end;
    inc( i );
  end;
  if not( oeKeepTrailingSpaces in Options) then
    Result := TrimRight( Result );
end;

function THilight.GetSelection: KOLString;
var i: Integer;
    S: KOLString;
begin
  Result := '';
  // ������� ��� ������ � ��������� ����� ���������� �������
  for i := SelBegin.Y to SelEnd.Y do
  begin
    S := Lines[ i ];
    if i = SelEnd.Y then
      S := Copy( S, 1, SelEnd.X );
    if i = SelBegin.Y then
      S := CopyEnd( S, SelBegin.X+1 );
    if i > SelBegin.Y then
      Result := Result + #13#10;
    Result := Result + S;
  end;
end;

function THilight.GetTabSize: Integer;
begin
  Result := fTabSize;
  if Result <= 0 then Result := 8;
end;

function THilight.GetText: KOLString;
begin
  Result := FLines.Text;
end;

function THilight.GiveNextTabPos(FromPos: Integer): Integer;
var t: Integer;
begin
  t := TabSize;
  Result := ( (FromPos + t) div t ) * t;
end;

procedure THilight.Indent(delta: Integer);
var y, i, k: Integer;
    S: KOLString;
begin
  Changing;
  for y := FSelBegin.y to FSelEnd.y do
  begin
    if (FSelEnd.y > FSelBegin.y) and (FSelEnd.y = y) and (FSelEnd.x = 0) then
      break;
    S := Lines[ y ];
    if delta > 0 then
    begin
      S := StrRepeat( ' ', delta ) + S;
      {$IFDEF ProvideBookmarks}
      FixBookmarks( MakePoint( 0, y ), delta, 0 );
      {$ENDIF}
    end
    else
    if delta < 0 then
    begin
      k := 0;
      for i := 1 to Length( S ) do
        if S[ i ] > ' ' then break
        else inc( k );
      if -delta < k then k := -delta;
      if k > 0 then
      begin
        Delete( S, 1, k );
        {$IFDEF ProvideBookmarks}
        FixBookmarks( MakePoint( 0, y ), -k, 0 );
        {$ENDIF}
      end;
    end
    else
      break;
    Lines[ y ] := S;
  end;
  if (FSelEnd.x = 0) and (FSelEnd.y > FSelBegin.y) then
  SetSel( MakePoint( FSelBegin.x + delta, FSelBegin.y ),
          FSelEnd,
          MakePoint( FSelBegin.x + delta, FSelBegin.y ) )
  else
  SetSel( MakePoint( FSelBegin.x + delta, FSelBegin.y ),
          MakePoint( FSelEnd.x + delta, FSelEnd.y ),
          MakePoint( FSelFrom.x + delta, FSelBegin.y ) );
  Changed;
  CaretToView;
end;

procedure THilight.Init;
{$IFDEF ProvideBookmarks} var i: Integer;{$ENDIF}
begin
  {$IFDEF UNICODE_CTRLS}
    {$IFDEF UseStrListEx}
    FLines := NewWStrListEx;
    {$ELSE}
    FLines := NewWStrList;
    {$ENDIF}
  {$ELSE}
    {$IFDEF UseStrListEx}
    FLines := NewStrListEx;
    {$ELSE}
    FLines := NewStrList;
    {$ENDIF}
  {$ENDIF UNICODE_CTRLS}
  FBitmap := NewDibBitmap( 1, 1, pf32bit );
  {$IFDEF ProvideUndoRedo}
  FUndoList := NewStrList;
  FRedoList := NewStrList;
  {$ENDIF}
  {$IFDEF DrawRightMargin}
  RightMarginChars := 80;
  RightMarginColor := clBlue;
  {$ENDIF}
  {$IFDEF ProvideAutoCompletion}
    {$IFDEF UNICODE_CTRLS}
      FDictionary := NewWStrListEx;
    {$ELSE}
      FDictionary := NewStrListEx;
    {$ENDIF UNICODE_CTRLS}
  {$ENDIF}
  AutoCompleteMinWordLength := 2;
  {$IFDEF ProvideBookmarks}
  for i := 0 to 9 do
    FBookmarks[i].Y := -1;
  {$ENDIF}
end;

procedure THilight.InsertLine(y: Integer; const S: KOLString; UseScroll: Boolean);
var R: TRect;
    str: KOLString;
begin
  Changing;
  str := S;
  if Assigned( fOnInsertLine ) then
    fOnInsertLine( FMemo, y, str );
  while Count < y do
  begin
    FLines.Add( '' );
    {$IFDEF ProvideUndoRedo}
    if not FUndoingRedoing then
      FUndoList.Add( 'A' );
    {$ENDIF}
    UseScroll := FALSE;
  end;
  FLines.Insert( y, str );
  {$IFDEF ProvideBookmarks}
  FixBookmarks( MakePoint( 0, y ), 0, 1 );
  {$ENDIF}
  {$IFDEF ProvideUndoRedo}
  if not FUndoingRedoing then
    FUndoList.Add( 'I' + Int2Str( y ) );
  {$ENDIF}
  if UseScroll and (y >= TopLine) and (y < TopLine + LinesPerPage) then
  begin
    R := MakeRect( 0, (y - TopLine)*LineHeight, FMemo.ClientWidth,
         FMemo.ClientHeight );
    ScrollWindowEx( FMemo.Handle, 0, LineHeight, @ R, nil, 0, nil,
         SW_INVALIDATE );
    //InvalidateLine( y );
  end
    else
  begin
    R := MakeRect( 0, (y - TopLine)*LineHeight, FMemo.ClientWidth,
         FMemo.ClientHeight );
    InvalidateRect( FMemo.Handle, @ R, TRUE );
  end;
  Changed;
end;

procedure THilight.InvalidateLine(y: Integer);
var R: TRect;
begin
  if y < TopLine then Exit;
  if y > TopLine + LinesVisiblePartial then Exit;
  R := MakeRect( 0, (y - TopLine)*LineHeight, FMemo.ClientWidth,
                    (y+1 - TopLine)*LineHeight );
  InvalidateRect( FMemo.Handle, @ R, TRUE );
end;

procedure THilight.InvalidateSelection;
var y: Integer;
    R: TRect;
begin
  // ����������� ��� ������� ������, � ��, �� ���, ������� ��������
  // ����� ���������, �������� ��� ����������� - ��� �����������.
  for y := Max( TopLine, SelBegin.Y ) to
           Min( TopLine + LinesVisiblePartial - 1, SelEnd.Y ) do
  begin
    R := MakeRect( 0, (y - TopLine)*LineHeight, FMemo.ClientWidth,
                   FMemo.ClientHeight );
    InvalidateRect( FMemo.Handle, @ R, TRUE );
  end;
end;

function THilight.LineHeight: Integer;
begin
  if FLineHeight = 0 then
  begin
    FBitmap.Canvas.Font.Assign( FMemo.Font );
    FLineHeight := FBitmap.Canvas.TextHeight( 'A/_' );
  end;
  Result := FLineHeight;
  if Result = 0 then Result := 16;
end;

function THilight.LinesPerPage: Integer;
begin
  Result := FMemo.ClientHeight div LineHeight;
end;

function THilight.LinesVisiblePartial: Integer;
begin
  Result := FMemo.ClientHeight div LineHeight;
  if Result * LineHeight < FMemo.ClientHeight then
    Inc( Result );
end;

function THilight.MaxLineWidthOnPage: Integer;
{$IFNDEF AlwaysHorzScrollBar_ofsize_MaxLineWidth}
var i: Integer;
{$ENDIF}
begin
  {$IFDEF AlwaysHorzScrollBar_ofsize_MaxLineWidth}
  Result := MaxLineWidth;
  {$ELSE}
  Result := 0;
  for i := TopLine to TopLine + (FMemo.Height+LineHeight-1) div LineHeight - 1 do
  begin
    if i >= Count then break;
    Result := Max( Result, Length( Lines[ i ] ) );
  end;
  {$ENDIF}
end;

procedure THilight.Redo;
begin
  {$IFDEF ProvideUndoRedo}
  if not CanRedo then Exit;
  DoUndoRedo( FRedoList, FUndoList );
  {$ENDIF}
end;

function THilight.SelectionAvailable: Boolean;
begin
  Result := ((SelBegin.X <> SelEnd.X) or (SelBegin.Y <> SelEnd.Y))
    and ((SelBegin.Y < Count-1) or
         (SelBegin.Y = Count-1) and
         (SelBegin.X < Length( FLines.Last )));
end;

procedure THilight.SelectWordUnderCursor;
var WordStart, WordEnd: TPoint;
    W: KOLString;
begin
  W := WordAtPos( Caret );
  if W = '' then Exit;
  WordStart := WordAtPosStart( Caret );
  WordEnd := WordStart;
  inc( WordEnd.X, Length( W ) );
  SetSel( WordStart, WordEnd, WordStart );
  Caret := WordEnd;
  CaretToView;
end;

procedure THilight.SetBookmark( Idx: Integer; const Value: TPoint );
begin
  if (Idx < 0) or (Idx > 9) then Exit;
  FBookmarks[ Idx ] := Value;
  if Assigned(FOnBookmark) then FOnBookmark(@Self);
end;

procedure THilight.SetCaret(const Value: TPoint);
begin
  {$IFDEF ProvideAutoCompletion}
  if (FCaret.Y < Count) and (FCaret.Y >= 0) and (FCaret.Y <> Value.Y) and
     not FnotAdd2Dictionary1time then
    AutoAdd2Dictionary( FLines.ItemPtrs[ FCaret.Y ] );
  if (FCaret.x <> Value.x) or (FCaret.y <> Value.y) then
    AutoCompletionHide;
  {$ENDIF}
  FCaret := Value;
  if (FCaret.Y >= TopLine) and
     (FCaret.Y < TopLine + LinesVisiblePartial) and
     (FCaret.X >= LeftCol) and
     (FCaret.X <= LeftCol + ColumnsVisiblePartial) and
     {(FMemo.Focused) and} (GetFocus = FMemo.Handle) then
  begin
    {$IFDEF AutoOverwrite}
    if oeOverwrite in Options then
      CreateCaret( FMemo.Handle, 0, CharWidth, LineHeight )
    else
    {$ENDIF}
      CreateCaret( FMemo.Handle, 0, 1, LineHeight );
    SetCaretPos( (FCaret.X - LeftCol) * CharWidth,
                 (FCaret.Y - TopLine) * LineHeight );
    ShowCaret( FMemo.Handle );
  end
    else
  HideCaret( FMemo.Handle );
  AdjustHScroll;
end;

procedure THilight.SetLeftCol(const Value: Integer);
var WasLeftCol: Integer;
begin
  WasLeftCol := FLeftCol;
  if WasLeftCol <> Value then
  begin
    FLeftCol := Value;
    if FLeftCol < 0 then
      FLeftCol := 0;
    if FLeftCol >= MaxLineWidth then
      FLeftCol := MaxLineWidth;
    if FLeftCol < 0 then
      FLeftCol := 0;
    ScrollWindowEx( FMemo.Handle, (-FLeftCol + WasLeftCol)*CharWidth,
      0, nil, nil, 0, nil, SW_INVALIDATE );
    Caret := Caret;
  end;
  // ���������� �������������� �������� � ���������� ���������:
  AdjustHScroll;
  if Assigned(FOnScroll) then FOnScroll(FMemo);
end;

procedure THilight.SetLineData(Idx: Integer; const Value: DWORD);
begin
  FLines.Objects[ Idx ] := Value;
end;

procedure THilight.SetLines(Idx: Integer; const Value: KOLString);
var U: KOLString;
begin
  Changing;
  if Assigned( FOnSetLine ) then
  begin
    U := Value;
    if not FOnSetLine( FMemo, Idx, U ) then Exit;
  end;
  while FLines.Count <= Idx do
  begin
    FLines.Add( '' );
    {$IFDEF ProvideUndoRedo}
    if not FUndoingRedoing then
      FUndoList.Add( 'A' );
    {$ENDIF}
  end;
  if FLines.Items[ Idx ] <> Value then
  begin
    {$IFDEF ProvideUndoRedo}
    if not FUndoingRedoing then
    begin
      U := 'R' + Int2Str( Idx ) + '=';
      if Copy( FUndoList.Last, 1, Length( U ) ) <> U then
        FUndoList.Add( U + FLines.Items[ Idx ] );
    end;
    {$ENDIF}
    FLines.Items[ Idx ] := Value;
  end;
  InvalidateLine( Idx );
  Changed;
end;

procedure THilight.SetOnScanToken(const Value: TOnScanToken);
begin
  FOnScanToken := Value;
  FMemo.Invalidate;
end;

procedure THilight.SetSel(const Pos1, Pos2, PosFrom: TPoint);
begin
  if (Pos1.Y > Pos2.Y) or (Pos1.Y = Pos2.Y) and (Pos1.X > Pos2.X) then
  begin
    SelBegin := Pos2;
    SelEnd := Pos1;
  end
    else
  begin
    SelBegin := Pos1;
    SelEnd := Pos2;
  end;
  SelFrom := PosFrom;
end;

procedure THilight.SetSelBegin(const Value: TPoint);
begin
  if (FSelBegin.X = Value.X) and (FSelBegin.Y = Value.Y) then Exit;
  InvalidateSelection; // ��������� ����� ����������, ��� ��������� ���������
  FSelBegin := Value;
  if (FSelEnd.Y < FSelBegin.Y) or
     (FSelEnd.Y = FSelBegin.Y) and
     (FSelEnd.X < FSelBegin.X) then
     FSelEnd := FSelBegin;
  InvalidateSelection; // �������� ����� ���������
  if Assigned( FMemo.OnSelChange ) then
    FMemo.OnSelChange( FMemo );
end;

procedure THilight.SetSelection(const Value: KOLString);
var S1, L: KOLString;
    {$IFDEF FastReplaceSelection}
    SL: PStrList;
    y: Integer;
    {$ELSE}
    S: KOLString;
    MoreLinesLeft: Boolean;
      {$IFDEF ProvideBookmarks}
      deltaX: Integer;
      {$ENDIF}
    {$ENDIF}
begin
  // ������� ���������, �������� ����� �������� ������, ��� �������� � �����
  Changing;
  DeleteSelection;
  {$IFDEF FastReplaceSelection}
  if Value <> '' then
  begin
    SL := NewStrList;
    TRY
      SL.Text := Value;
      if (Value <> '') and ((Value[ Length( Value ) ] = #13) or
                            (Value[ Length( Value ) ] = #10) ) then
         SL.Add( '' );
      L := Lines[ Caret.Y ];
      if Length( L ) < Caret.X then
        L := L + StrRepeat( ' ', Caret.X - Length( L ) );
      S1 := ''; // ����� ��������� � ��������� ������
      if SL.Count = 1 then
      begin
        L := Copy( L, 1, Caret.X ) + SL.Items[ 0 ] + CopyEnd( L, Caret.X+1 );
        FCaret.x := FCaret.x+Length( SL.Items[ 0 ] );
        Lines[ Caret.Y ] := L;
      end
      else
      begin
        S1 := CopyEnd( L, Caret.X+1 );
        L := Copy( L, 1, Caret.X ) + SL.Items[ 0 ];
        //S1 := SL.Items[ Count-1 ];
        Lines[ Caret.Y ] := L;
        {$IFDEF ProvideBookmarks}
        FixBookmarks( Caret, Length( SL.Items[ 0 ] ) - Length( S1 ), SL.Count-1 );
        {$ENDIF}
        for y := 1 to SL.Count-2 do
        begin
          L := SL.Items[ y ];
          InsertLine( Caret.Y+y, L, FALSE );
        end;
        y := SL.Count-1;
        L := S1; // + Lines[ Caret.y+y ];
        InsertLine( Caret.Y+y, SL.Last + L, FALSE );
        //Lines[ Caret.y+y ] := L;
        Caret := MakePoint( Length( SL.Last ), Caret.y+y );
      end;
    FINALLY
      SL.Free;
    END;
  end;
  {$ELSE} // ��������� �������
  {$IFDEF ProvideBookmarks}
  deltaX := -1;
  {$ENDIF}
  S := Value;
  MoreLinesLeft := FALSE;
  while (S <> '') or MoreLinesLeft do
  begin
    MoreLinesLeft := (pos( #13, S ) > 0) or (pos( #10, S ) > 0);
    S1 := Parse( S, #13#10 );
    {$IFDEF ProvideBookmarks}
    if deltaX < 0 then
    begin
      deltaX := Length( S1 );
      FixBookmarks( Caret, deltaX, 0 );
    end;
    {$ENDIF}
    if (S <> '') and (S[ 1 ] = #10) then
      Delete( S, 1, 1 );
    L := Lines[ Caret.Y ];
    while Length( L ) < Caret.X do
      L := L + ' ';
    if MoreLinesLeft then
    begin
      Lines[ FCaret.Y ] := Copy( L, 1, Caret.X ) + S1;
      L := CopyEnd( L, Caret.X+1 );
      InsertLine( Caret.Y+1, L, FALSE );
      Caret := MakePoint( 0, Caret.Y+1 );
    end
      else
    begin
      Lines[ Caret.Y ] := Copy( L, 1, Caret.X ) + S1 + CopyEnd( L, Caret.X+1 );
      Caret := MakePoint( Caret.X + Length( S1 ), Caret.Y );
    end;
  end;
  {$ENDIF}
  AdjustHScroll;
  AdjustVScroll;
  SetSel( Caret, Caret, Caret );
  CaretToView;
  Changed;
end;

procedure THilight.SetSelEnd(const Value: TPoint);
begin
  if (FSelEnd.X = Value.X) and (FSelEnd.Y = Value.Y) then Exit;
  InvalidateSelection; // ��������� ����� ����������, ��� ��������� ���������
  FSelEnd := Value;
  if (FSelBegin.Y > FSelEnd.Y) or
     (FSelBegin.Y = FSelEnd.Y) and
     (FSelBegin.X > FSelEnd.X) then
     FSelBegin := FSelEnd;
  InvalidateSelection; // �������� ����� ���������
  if Assigned( FMemo.OnSelChange ) then
    FMemo.OnSelChange( FMemo );
end;

procedure THilight.SetTabSize(Value: Integer);
begin
  if Value <= 0 then Value := 8;
  fTabSize := Value;
end;

procedure THilight.SetText(Value: KOLString);
var i: Integer;
begin
  if (Pos(#13#10, Value) = 0) and (Pos(#10, Value) + Pos(#13, Value) > 0) then
  begin
    i := 1;
    while i <= Length(Value) do
    begin
      if (Value[i] = #13) and ((i = Length(Value)) or (Value[i + 1] <> #10)) then
        Insert(#10, Value, i + 1)
      else if (Value[i] = #10) and ((i = 1) or (Value[i - 1] <> #13)) then
        Insert(#13, Value, i);
      Inc(i);
    end;
  end; 
  FLines.Text := Value;
  TopLine := TopLine;
  FMemo.Invalidate;
  {$IFDEF ProvideAutoCompletion}
  AutoCompletionHide;
  {$IFDEF AutocompletionFastFillDictionary}
  FastFillDictionary;
  {$ELSE}
  FDictionary.Clear;
  for i := 0 to FLines.Count-1 do
    AutoAdd2Dictionary( FLines.ItemPtrs[ i ] );
  {$ENDIF}
  {$ENDIF}
end;

procedure THilight.SetTopLine(const Value: Integer);
var WasTopLine: Integer;
begin
  WasTopLine := FTopLine;
  FTopLine := Value;
  if FTopLine < 0 then
    FTopLine := 0;
  if FTopLine >= Count then
    FTopLine := Count;
  if Count = 0 then
  begin
    Exit;
  end;
  if FTopLine + LinesPerPage >= Count then
    FTopLine := Count - LinesPerPage;
  if FTopLine < 0 then
    FTopLine := 0;
  if WasTopLine <> FTopLine then
  begin
    ScrollWindowEx( FMemo.Handle, 0, (WasTopLine - FTopLine)*LineHeight,
      nil, nil, 0, nil, SW_INVALIDATE );
    Caret := Caret;
  end;
  // ���������� ������������ �������� � ���������� ���������:
  AdjustVScroll;
  if Assigned(FOnScroll) then FOnScroll(FMemo);
end;

procedure THilight.Undo;
begin
  {$IFDEF ProvideUndoRedo}
  if not CanUndo then Exit;
  DoUndoRedo( FUndoList, FRedoList );
  {$ENDIF}
end;

function THilight.WordAtPos(const AtPos: TPoint): KOLString;
var FromPos: TPoint;
    S: KOLString;
    i: Integer;
begin
  Result := '';
  if AtPos.Y >= Count then Exit;
  FromPos := WordAtPosStart( AtPos );
  S := Lines[ FromPos.Y ];
  i := FromPos.X;
  while TRUE do
  begin
    inc( i );
    if i >= Length( S ) then break;
    if not IsLetterDigit( S[ i+1 ] ) then break;
  end;
  Result := Trim( Copy( S, FromPos.X+1, i-FromPos.X ) );
end;

function THilight.WordAtPosStart(const AtPos: TPoint): TPoint;
var S: KOLString;
    i: Integer;
begin
  Result := AtPos;
  if AtPos.Y >= Count then Exit;
  S := Lines[ AtPos.Y ];
  if (AtPos.X < Length( S )) and
     IsLetterDigit( S[ AtPos.X+1 ] ) then
    i := AtPos.X
  else
  if (AtPos.X-1 > 0) and
     (AtPos.X-1 < Length( S )) and
     IsLetterDigit( S[ AtPos.X ] ) then
    i := AtPos.X-1
  else Exit;
  while i > -1 do
  begin
    Dec( i );
    if (i < 0) or not IsLetterDigit( S[ i+1 ] ) then
    begin
      Result.X := i+1;
      break;
    end;
  end;
end;

initialization
  InitUpper;

end.
