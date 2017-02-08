unit InputDialog;

interface

uses
  Windows, Types, KOL;

function InputDialogBox(Parent: PControl; const Caption, Def: string): string;

implementation

function InputDialogBox(Parent: PControl; const Caption, Def: string): string;
var
  Form, Edit, Button: PControl;

  procedure ButtonClick(Self: PControl; Sender: PObj);
  begin
    Self.ModalResult := ID_OK;
    Self.Close;
  end;

  procedure OnKeyDown(Self: PControl; Sender: PObj; var Key: Longint; Shift: DWORD);
  begin
    if Key = VK_ESCAPE then
      Self.Close;
  end;

begin
  Result := '';
  Form := NewForm(Parent, Caption);
  Form.ExStyle := Form.ExStyle or WS_EX_TOOLWINDOW;
  Form.SetClientSize(200, 34);
  Form.CenterOnParent;
  Form.CanResize := false;
  //Form.Font.Assign(Parent.Font);
  Form.OnKeyDown := TOnKey(MakeMethod(Form, @OnKeyDown));
  Edit := NewEditBox(Form, []).SetPosition(5, 5).SetSize(135, 24);
  Edit.Color := clWindow;
  Edit.Text := Def;
  Edit.Focused := true;
  Edit.SelectAll;
  Edit.OnKeyDown := TOnKey(MakeMethod(Form, @OnKeyDown));
  Button := NewButton(Form, 'OK').SetPosition(145, 5).SetSize(50, 24);
  Button.DefaultBtn := true;
  Button.OnClick := TOnEvent(MakeMethod(Form, @ButtonClick));
  Form.Add2AutoFree(Edit);
  Form.Add2AutoFree(Button);
  if Form.ShowModal = ID_OK then
    Result := Edit.Text;
  Form.Free;
end;

end.