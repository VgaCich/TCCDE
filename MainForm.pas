{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit MainForm;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL, KOLadd {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls, mckCtrls, mckObjs, Graphics {$IFEND},
  Types, KOLHilightEdit, Gutter, Hilighter, InputDialog, SearchForm, OptionsForm, AboutForm;
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  PEditorPage = ^TEditorPage;
  TEditorPage = object(TObj)
  public
    FileName: string;
    Modified: Boolean;
    Editor: PHilightMemo;
    Gutter: PControl;
    Hilighter: PCHilighter;
    SearchOptions: TFindReplaceOptions;
    SearchPoint: TPoint;
    FindText, ReplaceText: string;
    destructor Destroy; virtual;
    procedure Change(Sender: PObj);
    function NewLine(Sender: PControl; LineNo: Integer; var S: KOLString): Integer;
  end;
  {$IF Defined(KOL_MCK)}
  {$DEFINE MCK_ACTIONS}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFormMainclass.inc} {$ELSE OBJECTS} PFormMain = ^TFormMain; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFormMain.inc}{$ELSE} TFormMain = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFormMain = class(TForm)
  {$IFEND KOL_MCK}
    KOLProject: TKOLProject;
    KOLForm: TKOLForm;
    MainMenu: TKOLMainMenu;
    ActionList: TKOLActionList;
    Toolbar: TKOLToolbar;
    ToolsTabs: TKOLTabControl;
    ProjectSplitter: TKOLSplitter;
    EditorPanel: TKOLPanel;
    MessagesList: TKOLListBox;
    MessagesSplitter: TKOLSplitter;
    EditorTabs: TKOLTabControl;
    ActionExit: TKOLAction;
    KOLApplet: TKOLApplet;
    PageSymbols: TKOLTabPage;
    ActionOpen: TKOLAction;
    ActionClose: TKOLAction;
    ActionSave: TKOLAction;
    ActionNew: TKOLAction;
    ToolbarImageList: TKOLImageList;
    SourceFileDialog: TKOLOpenSaveDialog;
    ActionSaveAs: TKOLAction;
    ActionUndo: TKOLAction;
    ActionRedo: TKOLAction;
    ActionCut: TKOLAction;
    ActionCopy: TKOLAction;
    ActionPaste: TKOLAction;
    ActionSelectAll: TKOLAction;
    EditorMenu: TKOLPopupMenu;
    ActionCloseAll: TKOLAction;
    ActionGoto: TKOLAction;
    ActionIndent: TKOLAction;
    ActionUnindent: TKOLAction;
    PageProject: TKOLTabPage;
    ActionSearch: TKOLAction;
    ActionFindNext: TKOLAction;
    ActionHilight: TKOLAction;
    ActionOptions: TKOLAction;
    ActionSaveAll: TKOLAction;
    ProjectTree: TKOLTreeView;
    ProjectTreeMenu: TKOLPopupMenu;
    ActionNewProject: TKOLAction;
    ProjectTreeImageList: TKOLImageList;
    ActionProjectAdd: TKOLAction;
    ActionProjectRemove: TKOLAction;
    ActionCloseProject: TKOLAction;
    ActionProjectOptions: TKOLAction;
    ActionProjectProperties: TKOLAction;
    ActionProjectBuild: TKOLAction;
    ActionProjectRebuild: TKOLAction;
    ActionProjectRun: TKOLAction;
    ActionProjectClean: TKOLAction;
    ActionAbout: TKOLAction;
    procedure ActionExitExecute(Sender: PObj);
    procedure KOLFormFormCreate(Sender: PObj);
    procedure ActionNewExecute(Sender: PObj);
    procedure ActionOpenExecute(Sender: PObj);
    procedure ActionSaveExecute(Sender: PObj);
    procedure ActionSaveAsExecute(Sender: PObj);
    procedure ActionCloseExecute(Sender: PObj);
    procedure EditorTabsMouseDblClk(Sender: PControl; var Mouse: TMouseEventData);
    procedure ActionCopyExecute(Sender: PObj);
    procedure ActionCutExecute(Sender: PObj);
    procedure ActionPasteExecute(Sender: PObj);
    procedure ActionSelectAllExecute(Sender: PObj);
    procedure ActionUndoExecute(Sender: PObj);
    procedure ActionRedoExecute(Sender: PObj);
    procedure KOLFormClose(Sender: PObj; var Accept: Boolean);
    procedure EditorMenuToggleBookmark(Sender: PMenu; Item: Integer);
    procedure EditorMenuGotoBookmark(Sender: PMenu; Item: Integer);
    procedure EditorMenuPopup(Sender: PObj);
    procedure ActionCloseAllExecute(Sender: PObj);
    procedure ActionGotoExecute(Sender: PObj);
    procedure ActionIndentExecute(Sender: PObj);
    procedure ActionUnindentExecute(Sender: PObj);
    procedure ActionSearchExecute(Sender: PObj);
    procedure ActionFindNextExecute(Sender: PObj);
    procedure ActionHilightExecute(Sender: PObj);
    procedure EditorTabsDropFiles(Sender: PControl; const FileList: KOL_String; const Pt: TPoint);
    procedure ActionOptionsExecute(Sender: PObj);
    procedure ActionSaveAllExecute(Sender: PObj);
    procedure KOLFormShow(Sender: PObj);
    procedure ProjectTreeMenuPopup(Sender: PObj);
    procedure ActionNewProjectExecute(Sender: PObj);
    procedure ActionProjectAddExecute(Sender: PObj);
    procedure ActionListUpdateActions(Sender: PObj);
    procedure ActionAboutExecute(Sender: PObj);
  private
    procedure CloseEditorTab(Tab: Integer);
    function EditorPage(Tab: Integer): PEditorPage;
    function NewEditorTab(const Caption: string): PEditorPage;
    procedure OpenFile(const FileName: string);
    procedure SaveFile(Tab: Integer);
    procedure SetEditorOptions(Page: PEditorPage);
    procedure ReadWriteFormPosition(Mode: TIniFileMode);
    procedure SetHilighter(Page: PEditorPage);
  public
    destructor Destroy; virtual;
  end;

var
  FormMain {$IFDEF KOL_MCK} : PFormMain {$ELSE} : TFormMain {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFormMain( var Result: PFormMain; AParent: PControl );
{$ENDIF}

function SameText(const S1, S2: string): Boolean;

implementation

{$R Icons.res}

const
  SSearchCompleted = 'Search completed';
  SGotoLine = 'Go to line:';
  SUnnamed = 'Unnamed';
  SUnsavedFile = 'File "%s" has unsaved modifications. Save now?';
  SUnsavedFiles = 'Some files has unsaved modifications. Save now?';

{$IF Defined(KOL_MCK)}{$ELSE}{$R *.DFM}{$IFEND}

{$IFDEF KOL_MCK}
{$I MainForm_1.inc}
{$ENDIF}

function SameText(const S1, S2: string): Boolean;
begin
  Result := AnsiCompareTextA(S1, S2) = 0;
end;

function Token(var S: string; const Delim: string): string;
var
  P: Integer;
begin
  P := Pos(Delim, S);
  if P = 0 then
    P := Length(S) + 1;
  Result := Copy(S, 1, P - 1);
  Delete(S, 1, P + Length(Delim) - 1);
end;

function LastChar(const S: string): Char;
begin
  if S <> '' then
    Result := S[Length(S)]
  else
    Result := #0;
end;

{TEditorPage}

destructor TEditorPage.Destroy;
begin
  FileName := '';
  FindText := '';
  ReplaceText := '';
  inherited;
end;

procedure TEditorPage.Change(Sender: PObj);
var
  i: Integer;
begin
  if Modified then Exit;
  Modified := true;
  with FormMain.EditorTabs^ do
    for i := 0 to Count - 1 do
      if Pages[i].CustomObj = @Self then
        TC_Items[i] := TC_Items[i] + '*';
end;

function TEditorPage.NewLine(Sender: PControl; LineNo: Integer; var S: KOLString): Integer;
var
  i: Integer;
  PrevLine, Prefix: string;
begin
  Result := 0;
  while (LineNo > 0) and (PHilightMemo(Sender).Edit.Lines[LineNo - 1] = '') do
    Dec(LineNo);
  if LineNo = 0 then Exit;
  PrevLine := PHilightMemo(Sender).Edit.Lines[LineNo - 1];
  Prefix := '';
  for i := 1 to Length(PrevLine) do
    if PrevLine[i] in [#9, #32] then
      Prefix := Prefix + PrevLine[i]
    else
      Break;
  if (LastChar(PrevLine) = '{') and (oeSmartTabs in PHilightMemo(Sender).Edit.Options) then
    Prefix := Prefix + #9;
  S := Prefix + S;
  for i := 1 to Length(Prefix) do
    if Prefix[i] = #9 then
      Result := PHilightMemo(Sender).Edit.GiveNextTabPos(Result)
    else
      Inc(Result);
end;

{TFormMain}

destructor TFormMain.Destroy;
begin
  inherited;
end;

procedure TFormMain.ActionExitExecute(Sender: PObj);
begin
  Form.Close;
end;

procedure TFormMain.KOLFormFormCreate(Sender: PObj);
begin
  ToolBar.Perform(TB_SETMAXTEXTROWS, 0, 0);
end;

function TFormMain.NewEditorTab(const Caption: string): PEditorPage;
var
  Tab: PControl;
begin
  Tab := EditorTabs.TC_Insert(EditorTabs.Count, Caption, 0);
  EditorTabs.CurIndex := EditorTabs.Count - 1;
  New(Result, Create);
  Tab.CustomObj := Result;
  New(Result.Hilighter, Create);
  Result.Add2AutoFree(Result.Hilighter);
  Result.Modified := false;
  Result.Editor := NewHilightEdit(Tab);
  with Result.Editor^ do
  begin
    Border := 0;
    Align := caClient;
    ExStyle := (ExStyle and not WS_EX_CLIENTEDGE) or WS_EX_STATICEDGE;
    OnChange := Result.Change;
    Edit.OnNewLine := Result.NewLine;
    SetAutoPopupMenu(EditorMenu);
    Edit.OnScanToken := Result.Hilighter.ScanToken;
    Focused := true;
  end;
  Result.Gutter := NewGutter(Tab, Result.Editor).SetSize(32, 0).SetAlign(caLeft);
  Result.Gutter.SetAutoPopupMenu(EditorMenu);
  SetEditorOptions(Result);
end;

procedure TFormMain.ActionNewExecute(Sender: PObj);
begin
  NewEditorTab(SUnnamed);
end;

procedure TFormMain.ActionOpenExecute(Sender: PObj);
var
  Path, BasePath: string;
begin
  SourceFileDialog.OpenDialog := true;
  SourceFileDialog.Filename := '';
  if not SourceFileDialog.Execute then Exit;
  Path := SourceFileDialog.Filename;
  if Pos(#13, Path) > 0 then
  begin
    BasePath := IncludeTrailingPathDelimiter(Token(Path, #13));
    while Length(Path) > 0 do
      OpenFile(BasePath + Token(Path, #13));
  end
    else OpenFile(Path);
end;

procedure TFormMain.ActionSaveExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  SaveFile(EditorTabs.CurIndex);
end;

procedure TFormMain.ActionSaveAsExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  SourceFileDialog.OpenDialog := false;
  SourceFileDialog.Filename := Page.FileName;
  if not SourceFileDialog.Execute then Exit;
  Page.FileName := SourceFileDialog.Filename;
  SaveFile(EditorTabs.CurIndex);
end;

procedure TFormMain.ActionCloseExecute(Sender: PObj);
begin
  if EditorTabs.Count = 0 then Exit;
  CloseEditorTab(EditorTabs.CurIndex);
end;

procedure TFormMain.CloseEditorTab(Tab: Integer);
var
  Index: Integer;
  Page: PEditorPage;
begin
  Page := EditorPage(Tab);
  if not Assigned(Page) then Exit;
  if Page.Modified then
    case MsgBox(Format(SUnsavedFile, [Page.FileName]), MB_ICONQUESTION or MB_YESNOCANCEL) of
      ID_YES: SaveFile(Tab);
      ID_CANCEL: Exit;
    end;
  Index := EditorTabs.CurIndex;
  EditorTabs.TC_Remove(Tab).Free;
  if EditorTabs.Count > 0 then
    EditorTabs.CurIndex := Min(Index, EditorTabs.Count - 1);
end;

function TFormMain.EditorPage(Tab: Integer): PEditorPage;
begin
  if (Tab < 0) or (Tab >= EditorTabs.Count) then
    Result := nil
  else
    Result := PEditorPage(EditorTabs.Pages[Tab].CustomObj);
end;

procedure TFormMain.EditorTabsMouseDblClk(Sender: PControl; var Mouse: TMouseEventData);
begin
  CloseEditorTab(EditorTabs.TC_TabAtPos(Mouse.X, Mouse.Y));
end;

procedure TFormMain.OpenFile(const FileName: string);
var
  i: Integer;
  Page: PEditorPage;
begin
  if not FileExists(FileName) then Exit;
  for i := 0 to EditorTabs.Count - 1 do
    if SameText(FileName, EditorPage(i).FileName) then
    begin
      EditorTabs.CurIndex := i;
      EditorPage(i).Editor.Focused := true;
      Exit;
    end;
  Page := NewEditorTab(ExtractFileName(FileName));
  Page.FileName := FileName;
  SetHilighter(Page);
  Page.Editor.Edit.Text := StrLoadFromFile(FileName);
end;

procedure TFormMain.SaveFile(Tab: Integer);
var
  Page: PEditorPage;
begin
  Page := EditorPage(Tab);
  if not Assigned(Page) then Exit;
  if Page.FileName = '' then
  begin
    SourceFileDialog.OpenDialog := false;
    SourceFileDialog.Filename := Page.FileName;
    if not SourceFileDialog.Execute then Exit;
    Page.FileName := SourceFileDialog.Filename;
  end;
  EditorTabs.TC_Items[Tab] := ExtractFileName(Page.FileName);
  Page.Modified := false;
  StrSaveToFile(Page.FileName, Page.Editor.Edit.Text);
end;

procedure TFormMain.ActionCopyExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  Page.Editor.Perform(WM_COPY, 0, 0);
end;

procedure TFormMain.ActionCutExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  Page.Editor.Perform(WM_CUT, 0, 0);
end;

procedure TFormMain.ActionPasteExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  Page.Editor.Perform(WM_PASTE, 0, 0);
end;

procedure TFormMain.ActionSelectAllExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  Page.Editor.Edit.SetSel(Point(0, 0), Point(0, Page.Editor.Edit.Count), Point(0, 0));
end;

procedure TFormMain.ActionUndoExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  Page.Editor.Edit.Undo;
end;

procedure TFormMain.ActionRedoExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  Page.Editor.Edit.Redo;
end;

procedure TFormMain.KOLFormClose(Sender: PObj; var Accept: Boolean);
var
  i: Integer;
  Modified: Boolean;
begin
  Modified := false;
  for i := 0 to EditorTabs.Count - 1 do
    if EditorPage(i).Modified then
      Modified := true;
  Accept := true;
  ReadWriteFormPosition(ifmWrite);
  if Modified then
    case MsgBox(SUnsavedFiles, MB_ICONQUESTION or MB_YESNOCANCEL) of
      ID_YES: for i := 0 to EditorTabs.Count - 1 do
        if EditorPage(i).Modified then
          SaveFile(i);
      ID_CANCEL: Accept := false;
    end;
end;

procedure TFormMain.EditorMenuToggleBookmark(Sender: PMenu; Item: Integer);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  if Page.Editor.Edit.Bookmarks[EditorMenu.Items[Item].Tag].Y = Page.Editor.Edit.Caret.Y then
    Page.Editor.Edit.Bookmarks[EditorMenu.Items[Item].Tag] := Point(0, -1)
  else
    Page.Editor.Edit.Bookmarks[EditorMenu.Items[Item].Tag] := Page.Editor.Edit.Caret;
end;

procedure TFormMain.EditorMenuGotoBookmark(Sender: PMenu; Item: Integer);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  if (Page.Editor.Edit.Bookmarks[EditorMenu.Items[Item].Tag].Y >= 0) then
  begin
    Page.Editor.Edit.Caret := Page.Editor.Edit.Bookmarks[EditorMenu.Items[Item].Tag];
    Page.Editor.Edit.CaretToView;
  end;
end;

procedure TFormMain.EditorMenuPopup(Sender: PObj);
var
  i: Integer;
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  for i := 0 to EditorMenu.Count - 1 do
    if (EditorMenu.ParentItem(i) <> -1) and (EditorMenu.Items[EditorMenu.ItemHandle[EditorMenu.ParentItem(i)]].Tag = 42) then
      EditorMenu.ItemChecked[i] := Page.Editor.Edit.Bookmarks[EditorMenu.Items[EditorMenu.ItemHandle[i]].Tag].Y >= 0;
  ActionHilight.Checked := Assigned(Page.Editor.Edit.OnScanToken);    
end;

procedure TFormMain.ActionCloseAllExecute(Sender: PObj);
begin
  while EditorTabs.Count > 0 do
    CloseEditorTab(0);
end;

procedure TFormMain.ActionGotoExecute(Sender: PObj);
var
  Page: PEditorPage;
  S: string;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  S := InputDialogBox(Form, SGotoLine, Int2Str(Page.Editor.Edit.Caret.Y + 1));
  if S = '' then Exit;
  Page.Editor.Edit.Caret := Point(0, Max(0, Min(Str2Int(S) - 1, Page.Editor.Edit.Count - 1)));
  Page.Editor.Edit.CaretToView;
end;

procedure TFormMain.ActionIndentExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  Page.Editor.Edit.Indent(Page.Editor.Edit.TabSize);
end;

procedure TFormMain.ActionUnindentExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  Page.Editor.Edit.Indent(-Page.Editor.Edit.TabSize);
end;

procedure TFormMain.ActionSearchExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  if Page.Editor.Edit.SelectionAvailable and (Pos(#13, Page.Editor.Edit.Selection) = 0) then
    FormSearch.Find := Page.Editor.Edit.Selection
  else
    FormSearch.Find := Page.Editor.Edit.WordAtPos(Page.Editor.Edit.Caret);
  FormSearch.Options := FormSearch.Options - [froReplace];
  if FormSearch.Form.ShowModal <> ID_OK then Exit;
  Page.SearchPoint := Page.Editor.Edit.Caret;
  Page.SearchOptions := FormSearch.Options;
  Page.FindText := FormSearch.Find;
  Page.ReplaceText := FormSearch.Replace;
  ActionFindNext.Execute;
end;

procedure TFormMain.ActionFindNextExecute(Sender: PObj);
var
  Page: PEditorPage;
  OldPos: TPoint;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  OldPos := Page.SearchPoint;
  Page.SearchPoint := Page.Editor.Edit.FindReplace(Page.FindText, Page.ReplaceText, Page.SearchPoint, Page.SearchOptions + [froSpaces], true);
  if (Page.SearchPoint.X = OldPos.X) and (Page.SearchPoint.Y = OldPos.Y) then
    MsgBox(SSearchCompleted, MB_ICONINFORMATION);
end;

procedure TFormMain.ActionHilightExecute(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  if not Assigned(Page) then Exit;
  if Assigned(Page.Editor.Edit.OnScanToken) then
    Page.Editor.Edit.OnScanToken := nil
  else
    Page.Editor.Edit.OnScanToken := Page.Hilighter.ScanToken;
  Page.Editor.Invalidate;
end;

procedure TFormMain.EditorTabsDropFiles(Sender: PControl; const FileList: KOL_String; const Pt: TPoint);
var
  List: string;
begin
  List := FileList;
  while Length(List) > 0 do
    OpenFile(Token(List, #13));
end;

procedure TFormMain.SetHilighter(Page: PEditorPage);
const
  CExtensions: array[0..1] of string = ('.c', '.h');
var
  i: Integer;
begin
  for i := 0 to High(CExtensions) do
    if SameText(ExtractFileExt(Page.FileName), CExtensions[i]) then
    begin
      Page.Editor.Edit.OnScanToken := Page.Hilighter.ScanToken;
      Exit;
    end;
  Page.Editor.Edit.OnScanToken := nil;
end;

procedure TFormMain.ActionOptionsExecute(Sender: PObj);
var
  i: Integer;
begin
  if FormOptions.Form.ShowModal <> ID_OK then Exit;
  for i := 0 to EditorTabs.Count - 1 do
    SetEditorOptions(EditorPage(i));
end;

procedure TFormMain.ActionSaveAllExecute(Sender: PObj);
var
  i: Integer;
begin
  for i := 0 to EditorTabs.Count - 1 do
    SaveFile(i);
end;

procedure TFormMain.SetEditorOptions(Page: PEditorPage);
begin
  if not Assigned(Page) then Exit;
  with Page^, FormOptions^ do
  begin
    Gutter.Color1 := SampleGutter.Color1;
    Gutter.Font.Assign(SampleGutter.Font);
    Gutter.Visible := SampleGutter.Visible;
    Editor.Font.Assign(SampleEditor.Font);
    Editor.Edit.Options := SampleEditor.Edit.Options - [oeReadOnly];
    Editor.Edit.AutoCompleteMinWordLength := SampleEditor.Edit.AutoCompleteMinWordLength;
    Editor.Edit.RightMarginChars := SampleEditor.Edit.RightMarginChars;
    Editor.Edit.RightMarginColor := SampleEditor.Edit.RightMarginColor;
    Editor.Edit.TabSize := SampleEditor.Edit.TabSize;
    Hilighter.Styles := SampleHilighter.Styles;
  end;
end;

procedure TFormMain.ReadWriteFormPosition(Mode: TIniFileMode);
begin
  FormOptions.Ini.Mode := Mode;
  with FormOptions.Ini^ do
  begin
    Section := 'MainForm';
    if not FormOptions.SavePosCheck.Checked then
    begin
      ClearSection;
      Exit;
    end;
    Form.WindowState := TWindowState(ValueInteger('State', Integer(Form.WindowState)));
    if Form.WindowState <> wsMaximized then
    begin
      Form.Left := ValueInteger('Left', Form.Left);
      Form.Top := ValueInteger('Top', Form.Top);
      Form.Width := ValueInteger('Width', Form.Width);
      Form.Height := ValueInteger('Height', Form.Height);
    end;
    ToolsTabs.Width := ValueInteger('ToolsSize', ToolsTabs.Width);
    MessagesList.Height := ValueInteger('MessagesSize', MessagesList.Height);
  end;
end;

procedure TFormMain.KOLFormShow(Sender: PObj);
var
  i: Integer;
begin
  ReadWriteFormPosition(ifmRead);
  for i := 1 to ParamCount + 1 do
    OpenFile(ParamStr(i));
end;

procedure TFormMain.ActionListUpdateActions(Sender: PObj);
var
  Page: PEditorPage;
begin
  Page := EditorPage(EditorTabs.CurIndex);
  ActionSave.Enabled := Assigned(Page) and Page.Modified;
  ActionSaveAs.Enabled := ActionSave.Enabled;
  ActionSaveAll.Enabled := EditorTabs.Count > 0;
  ActionClose.Enabled := Assigned(Page);
  ActionCloseAll.Enabled := EditorTabs.Count > 0;
  ActionCopy.Enabled := Assigned(Page) and Page.Editor.Edit.SelectionAvailable;
  ActionCut.Enabled := ActionCopy.Enabled;
  ActionPaste.Enabled := Assigned(Page);
  ActionSelectAll.Enabled := Assigned(Page);
  ActionRedo.Enabled := Assigned(Page) and Page.Editor.Edit.CanRedo;
  ActionUndo.Enabled := Assigned(Page) and Page.Editor.Edit.CanUndo;
  ActionSearch.Enabled := Assigned(Page);
  ActionFindNext.Enabled := Assigned(Page) and (Page.FindText <> '');
  ActionGoto.Enabled := Assigned(Page);
  ActionHilight.Enabled := Assigned(Page);
  ActionIndent.Enabled := Assigned(Page) and Page.Editor.Edit.SelectionAvailable;
  ActionUnindent.Enabled := ActionIndent.Enabled;
  ActionProjectAdd.Enabled := ProjectTree.TVSelected <> 0;
end;

procedure TFormMain.ProjectTreeMenuPopup(Sender: PObj);
begin
  PMenu(Sender).NotPopup := ProjectTree.TVSelected = 0;
end;

procedure TFormMain.ActionNewProjectExecute(Sender: PObj);
var
  Item: Cardinal;
begin
  Item := ProjectTree.TVInsert(TVI_ROOT, TVI_FIRST, 'New project');
  ProjectTree.TVItemImage[Item] := 2;
  ProjectTree.TVItemSelImg[Item] := 2;
end;

procedure TFormMain.ActionProjectAddExecute(Sender: PObj);
var
  Item: Cardinal;
begin
  if ProjectTree.TVSelected = 0 then Exit;
  Item := ProjectTree.TVInsert(ProjectTree.TVSelected, TVI_LAST, 'New file');
  ProjectTree.TVExpand(ProjectTree.TVSelected, TVE_EXPAND);
  ProjectTree.TVItemImage[Item] := 0;
  ProjectTree.TVItemSelImg[Item] := 0;
end;

procedure TFormMain.ActionAboutExecute(Sender: PObj);
begin
  FormAbout.Form.ShowModal;
end;

end.
