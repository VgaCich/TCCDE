{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit OptionsForm;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL, KOLMHFontDialog {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls, mckCtrls, mckObjs, Graphics,  MCKMHFontDialog {$IFEND (place your units here->)},
  Types, KOLHilightEdit, Gutter, Hilighter;
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MCKMHFontDialog;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFormOptionsclass.inc} {$ELSE OBJECTS} PFormOptions = ^TFormOptions; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFormOptions.inc}{$ELSE} TFormOptions = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFormOptions = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm: TKOLForm;
    OKButton: TKOLButton;
    CancelButton: TKOLButton;
    OptionsTabs: TKOLTabControl;
    PageGeneral: TKOLTabPage;
    PageEditor: TKOLTabPage;
    SmartTabsCheck: TKOLCheckBox;
    GutterCheck: TKOLCheckBox;
    AutocompletionCheck: TKOLCheckBox;
    HilightCheck: TKOLCheckBox;
    KeepSpacesCheck: TKOLCheckBox;
    OverwriteCheck: TKOLCheckBox;
    TabSizeEdit: TKOLEditBox;
    RightMarginEdit: TKOLEditBox;
    AutocompleteEdit: TKOLEditBox;
    Label1: TKOLLabel;
    ColorDialog: TKOLColorDialog;
    FontPanel: TKOLPanel;
    FontButton: TKOLButton;
    StyleCombo: TKOLComboBox;
    FontColorPanel: TKOLPanel;
    BackColorPanel: TKOLPanel;
    BoldCheck: TKOLCheckBox;
    ItalicCheck: TKOLCheckBox;
    UnderlineCheck: TKOLCheckBox;
    StrikeCheck: TKOLCheckBox;
    EditorPanel: TKOLPanel;
    CurLineColorPanel: TKOLPanel;
    RightMarginColorPanel: TKOLPanel;
    FontDialog: TKOLMHFontDialog;
    ResetStylesButton: TKOLButton;
    SavePosCheck: TKOLCheckBox;
    HotkeysList: TKOLListView;
    HotkeysCheck: TKOLCheckBox;
    ColorMenu: TKOLPopupMenu;
    StylesGroupBox: TKOLGroupBox;
    function KOLFormMessage(var Msg: TMsg; var Rslt: Integer): Boolean;
    procedure CancelButtonClick(Sender: PObj);
    procedure OKButtonClick(Sender: PObj);
    procedure KOLFormShow(Sender: PObj);
    procedure KOLFormFormCreate(Sender: PObj);
    procedure StyleComboChange(Sender: PObj);
    procedure StyleCheckClick(Sender: PObj);
    procedure ColorPanelClick(Sender: PObj);
    procedure AutocompleteEditChange(Sender: PObj);
    procedure AutocompletionCheckClick(Sender: PObj);
    procedure GutterCheckClick(Sender: PObj);
    procedure HilightCheckClick(Sender: PObj);
    procedure KeepSpacesCheckClick(Sender: PObj);
    procedure OverwriteCheckClick(Sender: PObj);
    procedure RightMarginEditChange(Sender: PObj);
    procedure SmartTabsCheckClick(Sender: PObj);
    procedure TabSizeEditChange(Sender: PObj);
    procedure FontButtonClick(Sender: PObj);
    procedure HotkeysListKeyDown(Sender: PControl; var Key: Integer; Shift: Cardinal);
    procedure HotkeysListMouseDblClk(Sender: PControl; var Mouse: TMouseEventData);
    procedure ResetStylesButtonClick(Sender: PObj);
    procedure HotkeysListLeave(Sender: PObj);
    procedure HotkeysListMouseDown(Sender: PControl; var Mouse: TMouseEventData);
    procedure HotkeysCheckClick(Sender: PObj);
    procedure ColorMenuSelect(Sender: PMenu; Item: Integer);
    procedure ColorMenuCustom(Sender: PMenu; Item: Integer);
  private
    procedure SetOption(Option: TOptionEdit; State: Boolean);
    procedure SetPanelColor(Panel: PControl; Color: TColor);
    { Private declarations }
  public
    Ini: PIniFile;
    SampleEditor: PHilightMemo;
    SampleGutter: PControl;
    SampleHilighter: PCHilighter;
    procedure ReadWriteSettings(Mode: TIniFileMode);
  end;

var
  FormOptions {$IFDEF KOL_MCK} : PFormOptions {$ELSE} : TFormOptions {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFormOptions( var Result: PFormOptions; AParent: PControl );
{$ENDIF}

implementation

uses
  MainForm;

const
  SPressButton = 'Press key...';

{$IF Defined(KOL_MCK)}{$ELSE}{$R *.DFM}{$IFEND}

{$IFDEF KOL_MCK}
{$I OptionsForm_1.inc}
{$ENDIF}

function TFormOptions.KOLFormMessage(var Msg: TMsg; var Rslt: Integer): Boolean;
begin
  Result := false;
  if Msg.message = WM_CLOSE then Form.Hide;
end;

procedure TFormOptions.CancelButtonClick(Sender: PObj);
begin
  Form.Close; //TODO: reset SampleEditor/Hilighter/Gutter settings
end;

procedure TFormOptions.OKButtonClick(Sender: PObj);
var
  i: Integer;
begin
  for i := 0 to HotkeysList.LVCount - 1 do
    FormMain.ActionList.Actions[i].Accelerator := TMenuAccelerator(HotkeysList.LVItemData[i]);
  ReadWriteSettings(ifmWrite);
  Form.ModalResult := ID_OK;
  Form.Close;
end;

procedure TFormOptions.KOLFormShow(Sender: PObj);
var
  i: Integer;
begin
  Form.ModalResult := 0;
  ReadWriteSettings(ifmRead);
  HotkeysList.Enabled := HotkeysCheck.Checked;
  HotkeysList.Clear;
  for i := 0 to FormMain.ActionList.Count - 1 do
  begin
    HotkeysList.LVItemAdd(FormMain.ActionList.Actions[i].Hint);
    HotkeysList.LVItemData[i] := Cardinal(FormMain.ActionList.Actions[i].Accelerator);
    HotkeysList.LVItems[i, 1] := GetAcceleratorText(FormMain.ActionList.Actions[i].Accelerator);
  end;
  AutocompletionCheck.Checked := oeAutoCompletion in SampleEditor.Edit.Options;
  HilightCheck.Checked := oeHighlight in SampleEditor.Edit.Options;
  KeepSpacesCheck.Checked := oeKeepTrailingSpaces in SampleEditor.Edit.Options;
  OverwriteCheck.Checked := oeOverwrite in SampleEditor.Edit.Options;
  SmartTabsCheck.Checked := oeSmartTabs in SampleEditor.Edit.Options;
  GutterCheck.Checked := SampleGutter.Visible;
  AutocompleteEdit.Visible := AutocompletionCheck.Checked;
  AutocompleteEdit.Text := Int2Str(SampleEditor.Edit.AutoCompleteMinWordLength);
  RightMarginEdit.Text := Int2Str(SampleEditor.Edit.RightMarginChars);
  TabSizeEdit.Text := Int2Str(SampleEditor.Edit.TabSize);
  FontPanel.Font.Assign(SampleEditor.Font);
  FontPanel.Caption := FontPanel.Font.FontName;
  StyleCombo.CurIndex := 0;
  StyleCombo.OnChange(StyleCombo);
  CurLineColorPanel.Visible := GutterCheck.Checked;
  SetPanelColor(CurLineColorPanel, SampleGutter.Color1);
  SetPanelColor(RightMarginColorPanel, SampleEditor.Edit.RightMarginColor);
end;

procedure TFormOptions.KOLFormFormCreate(Sender: PObj);
var
  i: Integer;
  Bitmap: PBitmap;
  Style: THilightStyle;
begin
  Ini := OpenIniFile(ChangeFileExt(ExePath, '.ini'));
  for i := 1 to ColorMenu.Count - 1 do
  begin
    Bitmap := NewBitmap(GetSystemMetrics(SM_CXMENUCHECK), GetSystemMetrics(SM_CXMENUCHECK));
    Bitmap.Canvas.Pen.Color := clBlack;
    Bitmap.Canvas.Brush.Color := Integer(ColorMenu.Items[ColorMenu.ItemHandle[i]].Tag);
    Bitmap.Canvas.Rectangle(0, 0, Bitmap.Width, Bitmap.Height);
    ColorMenu.ItemBitmap[i] := Bitmap.Handle;
    ColorMenu.Add2AutoFree(Bitmap);
  end;
  New(SampleHilighter, Create);
  Form.Add2AutoFree(SampleHilighter);
  SampleEditor := NewHilightEdit(EditorPanel);
  with SampleEditor^ do
  begin
    Border := 0;
    Align := caClient;
    ExStyle := (ExStyle and not WS_EX_CLIENTEDGE) or WS_EX_STATICEDGE;
    Edit.Options := [oeReadOnly, oeSmartTabs, oeHighlight, oeAutoCompletion];
    Edit.TabSize := 4;
    Edit.RightMarginColor := clSilver;
    Edit.OnScanToken := SampleHilighter.ScanToken;
    Edit.Text := '//Highlighting sample'#13#10+
      '#include <stdio.h>'#13#10#13#10+
      'int main(void)'#13#10+
      '{'#13#10+
      #9'printf("Hello World!\n");'#13#10+
      #9'return 0;'#13#10+
      '}';
  end;
  SampleGutter := NewGutter(EditorPanel, SampleEditor).SetSize(32, 0).SetAlign(caLeft);
  SampleGutter.Color1 := clSkyBlue;
  for Style := Low(THilightStyle) to High(THilightStyle) do
    StyleCombo.ItemData[StyleCombo.Add(StyleNames[Style])] := Integer(Style);
  ReadWriteSettings(ifmRead);
end;

procedure TFormOptions.StyleComboChange(Sender: PObj);
begin
  with SampleHilighter.Styles[THilightStyle(StyleCombo.ItemData[StyleCombo.CurIndex])] do
  begin
    SetPanelColor(FontColorPanel, fontcolor);
    SetPanelColor(BackColorPanel, backcolor);
    BoldCheck.Checked := fsBold in fontstyle;
    ItalicCheck.Checked := fsItalic in fontstyle;
    UnderlineCheck.Checked := fsUnderline in fontstyle;
    StrikeCheck.Checked := fsStrikeOut in fontstyle;
  end;
end;

procedure TFormOptions.StyleCheckClick(Sender: PObj);
begin
  with SampleHilighter.Styles[THilightStyle(StyleCombo.ItemData[StyleCombo.CurIndex])] do
  begin
    fontstyle := [];
    if BoldCheck.Checked then
      fontstyle := fontstyle + [fsBold];
    if ItalicCheck.Checked then
      fontstyle := fontstyle + [fsItalic];
    if UnderlineCheck.Checked then
      fontstyle := fontstyle + [fsUnderline];
    if StrikeCheck.Checked then
      fontstyle := fontstyle + [fsStrikeOut];
  end;
  SampleEditor.Invalidate;
end;

procedure TFormOptions.ColorPanelClick(Sender: PObj);
var
  i: Integer;
  P: TPoint;
begin
  ColorMenu.Tag := Cardinal(Sender);
  with PControl(Sender)^ do
  begin
    P := Point(Left, Top + Height);
    ClientToScreen(ParentWindow, P);
    ColorMenu.ItemChecked[0] := true;
    for i := 1 to ColorMenu.Count - 1 do
    begin
      ColorMenu.ItemChecked[i] := TColor(ColorMenu.Items[ColorMenu.ItemHandle[i]].Tag) = Color;
      if ColorMenu.ItemChecked[i] then
        ColorMenu.ItemChecked[0] := false;
    end;
  end;
  ColorMenu.Popup(P.X, P.Y);
end;

procedure TFormOptions.SetPanelColor(Panel: PControl; Color: TColor);
begin
  Panel.Color := Color;
  if 74 * (Color and $FF) + 163 * ((Color shr 8) and $FF) + 19 * ((Color shr 16) and $FF) >= 32768 then
    Panel.Font.Color := clBlack
  else
    Panel.Font.Color := clWhite;
end;

procedure TFormOptions.AutocompleteEditChange(Sender: PObj);
begin
  SampleEditor.Edit.AutoCompleteMinWordLength := Str2Int(AutocompleteEdit.Text);
end;

procedure TFormOptions.AutocompletionCheckClick(Sender: PObj);
begin
  SetOption(oeAutoCompletion, AutocompletionCheck.Checked);
  AutocompleteEdit.Visible := AutocompletionCheck.Checked;
end;

procedure TFormOptions.GutterCheckClick(Sender: PObj);
begin
  SampleGutter.Visible := GutterCheck.Checked;
  CurLineColorPanel.Visible := GutterCheck.Checked;
end;

procedure TFormOptions.HilightCheckClick(Sender: PObj);
begin
  SetOption(oeHighlight, HilightCheck.Checked); 
end;

procedure TFormOptions.KeepSpacesCheckClick(Sender: PObj);
begin
  SetOption(oeKeepTrailingSpaces, KeepSpacesCheck.Checked);
end;

procedure TFormOptions.OverwriteCheckClick(Sender: PObj);
begin
  SetOption(oeOverwrite, OverwriteCheck.Checked);
end;

procedure TFormOptions.RightMarginEditChange(Sender: PObj);
begin
  SampleEditor.Edit.RightMarginChars := Str2Int(RightMarginEdit.Text);
  SampleEditor.Invalidate;
end;

procedure TFormOptions.SetOption(Option: TOptionEdit; State: Boolean);
begin
  if State then
    SampleEditor.Edit.Options := SampleEditor.Edit.Options + [Option]
  else
    SampleEditor.Edit.Options := SampleEditor.Edit.Options - [Option];
  SampleEditor.Invalidate;
end;

procedure TFormOptions.SmartTabsCheckClick(Sender: PObj);
begin
  SetOption(oeSmartTabs, SmartTabsCheck.Checked);
end;

procedure TFormOptions.TabSizeEditChange(Sender: PObj);
begin
  SampleEditor.Edit.TabSize := Str2Int(TabSizeEdit.Text);
  SampleEditor.Invalidate;
end;

procedure TFormOptions.FontButtonClick(Sender: PObj);
begin
  FontDialog.InitFont.Assign(FontPanel.Font);
  FontDialog.Font.Assign(FontPanel.Font);
  if not FontDialog.Execute then Exit;
  FontPanel.Font.Assign(FontDialog.Font);
  FontPanel.Caption := FontPanel.Font.FontName;
  SampleEditor.Font.Assign(FontDialog.Font);
  SampleGutter.Font.Assign(FontDialog.Font);
end;

procedure TFormOptions.HotkeysListKeyDown(Sender: PControl; var Key: Integer; Shift: Cardinal);
begin
  if (HotkeysList.Tag > 0) and not (Key in [VK_ALT, VK_CONTROL, VK_SHIFT, VK_ESCAPE]) then
  begin
    if (GetKeyState(VK_MENU) and $80) <> 0 then
      Shift := Shift or FALT;
    HotkeysList.LVItemData[HotkeysList.Tag - 1] := Cardinal(MakeAccelerator(Shift or FVIRTKEY, Key));
    HotkeysListLeave(Sender);
  end;
end;

procedure TFormOptions.HotkeysListMouseDblClk(Sender: PControl; var Mouse: TMouseEventData);
begin
  if HotkeysList.LVCurItem >= 0 then
  begin
    HotkeysList.Tag := HotkeysList.LVCurItem + 1;
    HotkeysList.LVItems[HotkeysList.LVCurItem, 1] := SPressButton;
  end;
end;

procedure TFormOptions.ReadWriteSettings(Mode: TIniFileMode);
var
  i: Integer;
  Style: THilightStyle;
begin
  Ini.Mode := Mode;
  Ini.Section := 'General';
  SavePosCheck.Checked := Ini.ValueBoolean('SaveFormPosition', SavePosCheck.Checked);
  Ini.Section := 'Accelerators';
  HotkeysCheck.Checked := Ini.ValueBoolean('Use', HotkeysCheck.Checked);
  if HotkeysCheck.Checked then
    with FormMain.ActionList^ do
      for i := 0 to Count - 1 do
        Actions[i].Accelerator := TMenuAccelerator(Ini.ValueInteger(Actions[i].Name, Integer(Actions[i].Accelerator)))
  else
    Ini.ClearSection;    
  Ini.Section := 'Editor';
  with SampleEditor.Edit^ do
  begin
    SetOption(oeAutocompletion, Ini.ValueBoolean('Autocomplete', oeAutocompletion in Options));
    SetOption(oeHighlight, Ini.ValueBoolean('Highlight', oeHighlight in Options));
    SetOption(oeKeepTrailingSpaces, Ini.ValueBoolean('KeepSpaces', oeKeepTrailingSpaces in Options));
    SetOption(oeOverwrite, Ini.ValueBoolean('Overwrite', oeOverwrite in Options));
    SetOption(oeSmartTabs, Ini.ValueBoolean('SmartTabs', oeSmartTabs in Options));
    AutoCompleteMinWordLength := Ini.ValueInteger('CompleteAfter', AutoCompleteMinWordLength);
    RightMarginChars := Ini.ValueInteger('RightMargin', RightMarginChars);
    RightMarginColor := Ini.ValueInteger('RightMarginColor', RightMarginColor);
    TabSize := Ini.ValueInteger('TabSize', TabSize);
  end;
  SampleEditor.Font.FontName := Ini.ValueString('FontName', SampleEditor.Font.FontName);
  SampleEditor.Font.FontHeight := Ini.ValueInteger('FontHeight', SampleEditor.Font.FontHeight);
  SampleGutter.Font.Assign(SampleEditor.Font);
  SampleGutter.Visible := Ini.ValueBoolean('Gutter', SampleGutter.Visible);
  SampleGutter.Color1 := Ini.ValueInteger('CurLineColor', SampleGutter.Color1);
  Ini.Section := 'Styles';
  for Style := Low(THilightStyle) to High(THilightStyle) do
    with SampleHilighter.Styles[Style] do
    begin
      fontcolor := Ini.ValueInteger(StyleNames[Style] + '.FontColor', fontcolor);
      backcolor := Ini.ValueInteger(StyleNames[Style] + '.BackColor', backcolor);
      fontstyle := TFontStyle(Byte(Ini.ValueInteger(StyleNames[Style] + '.Style', Byte(fontstyle))));
    end;
end;

procedure TFormOptions.ResetStylesButtonClick(Sender: PObj);
begin
  SampleHilighter.Styles := DefStyles;
  SampleEditor.Invalidate;
end;

procedure TFormOptions.HotkeysListLeave(Sender: PObj);
begin
  if HotkeysList.Tag > 0 then
    HotkeysList.LVItems[HotkeysList.Tag - 1, 1] := GetAcceleratorText(TMenuAccelerator(HotkeysList.LVItemData[HotkeysList.Tag - 1]));
  HotkeysList.Tag := 0;
end;

procedure TFormOptions.HotkeysListMouseDown(Sender: PControl; var Mouse: TMouseEventData);
begin
  HotkeysListLeave(Sender);
end;

procedure TFormOptions.HotkeysCheckClick(Sender: PObj);
begin
  HotkeysList.Enabled := HotkeysCheck.Checked;
end;

procedure TFormOptions.ColorMenuSelect(Sender: PMenu; Item: Integer);
var
  Color: TColor;
begin
  Color := TColor(Sender.Items[Item].Tag);
  SetPanelColor(PControl(Sender.Tag), Color);
  with SampleHilighter.Styles[THilightStyle(StyleCombo.ItemData[StyleCombo.CurIndex])] do
  begin
    if PControl(Sender.Tag) = FontColorPanel then
      fontcolor := Color;
    if PControl(Sender.Tag) = BackColorPanel then
      backcolor := Color;
  end;
  if PControl(Sender.Tag) = CurLineColorPanel then
    SampleGutter.Color1 := Color;
  if PControl(Sender.Tag) = RightMarginColorPanel then
    SampleEditor.Edit.RightMarginColor := Color;
  SampleEditor.Invalidate;
end;

procedure TFormOptions.ColorMenuCustom(Sender: PMenu; Item: Integer);
begin
  ColorDialog.CustomColors[1] := PControl(Sender.Tag).Color;
  ColorDialog.Color := PControl(Sender.Tag).Color;
  if ColorDialog.Execute then
  begin
    Sender.Items[Item].Tag := Cardinal(ColorDialog.Color);
    ColorMenuSelect(Sender, Item);
  end;
end;

end.



