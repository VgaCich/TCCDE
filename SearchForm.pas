{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit SearchForm;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls, mckCtrls, mckObjs, Graphics {$IFEND (place your units here->)},
  KOLHilightEdit;
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFormSearchclass.inc} {$ELSE OBJECTS} PFormSearch = ^TFormSearch; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFormSearch.inc}{$ELSE} TFormSearch = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFormSearch = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm: TKOLForm;
    Label1: TKOLLabel;
    ReplaceCheck: TKOLCheckBox;
    CaseCheck: TKOLCheckBox;
    AllCheck: TKOLCheckBox;
    OKButton: TKOLButton;
    CancelButton: TKOLButton;
    BackCheck: TKOLCheckBox;
    FindCombo: TKOLComboBox;
    ReplaceCombo: TKOLComboBox;
    function KOLFormMessage(var Msg: TMsg; var Rslt: Integer): Boolean;
    procedure KOLFormShow(Sender: PObj);
    procedure OKButtonClick(Sender: PObj);
    procedure CancelButtonClick(Sender: PObj);
    procedure ReplaceCheckClick(Sender: PObj);
    procedure KOLFormHide(Sender: PObj);
  private
    procedure AddHistory(Combo: TKOLComboBox; Line: string);
    procedure SetOption(Option: TFindReplaceOption; Enable: Boolean);
    { Private declarations }
  public
    Find, Replace: string;
    Options: TFindReplaceOptions;
  end;

const
  MaxHistory = 8;

var
  FormSearch {$IFDEF KOL_MCK} : PFormSearch {$ELSE} : TFormSearch {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFormSearch( var Result: PFormSearch; AParent: PControl );
{$ENDIF}

implementation

uses
  MainForm;

{$IF Defined(KOL_MCK)}{$ELSE}{$R *.DFM}{$IFEND}

{$IFDEF KOL_MCK}
{$I SearchForm_1.inc}
{$ENDIF}

procedure TFormSearch.AddHistory(Combo: TKOLComboBox; Line: string);
var
  i: Integer;
begin
  Combo.Insert(0, Line);
  for i := Combo.Count - 1 downto 1 do
    if SameText(Combo.Items[i], Line) then
      Combo.Delete(i);
  while Combo.Count > MaxHistory do
    Combo.Delete(MaxHistory);
end;

function TFormSearch.KOLFormMessage(var Msg: TMsg; var Rslt: Integer): Boolean;
begin
  Result := false;
  if Msg.message = WM_CLOSE then Form.Hide;
end;

procedure TFormSearch.KOLFormShow(Sender: PObj);
begin
  Form.ModalResult := 0;
  FindCombo.Insert(0, Find);
  FindCombo.CurIndex := 0;
  ReplaceCheck.Checked := froReplace in Options;
  AllCheck.Checked := froAll in Options;
  CaseCheck.Checked := froCase in Options;
  BackCheck.Checked := froBack in Options;
  ReplaceCheckClick(nil);
  FindCombo.SelectAll;
  FindCombo.Focused := true;
end;

procedure TFormSearch.OKButtonClick(Sender: PObj);
begin
  Form.ModalResult := ID_OK;
  Form.Close;
end;

procedure TFormSearch.CancelButtonClick(Sender: PObj);
begin
  Form.Close;
end;

procedure TFormSearch.ReplaceCheckClick(Sender: PObj);
begin
  ReplaceCombo.Visible := ReplaceCheck.Checked;
  AllCheck.Visible := ReplaceCheck.Checked;
  SetOption(froReplace, ReplaceCheck.Checked);
end;

procedure TFormSearch.SetOption(Option: TFindReplaceOption; Enable: Boolean);
begin
  if Enable then
    Options := Options + [Option]
  else
    Options := Options - [Option];
end;

procedure TFormSearch.KOLFormHide(Sender: PObj);
begin
  Find := FindCombo.Text;
  FindCombo.Delete(0);
  if Form.ModalResult = ID_OK then
    AddHistory(FindCombo, Find);
  if ReplaceCheck.Checked then
  begin
    Replace := ReplaceCombo.Text;
    if Form.ModalResult = ID_OK then
      AddHistory(ReplaceCombo, Replace);
  end
    else Replace := '';
  SetOption(froReplace, ReplaceCheck.Checked);
  SetOption(froAll, AllCheck.Checked);
  SetOption(froCase, CaseCheck.Checked);
  SetOption(froBack, BackCheck.Checked);
end;

end.


