{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit AboutForm;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IF Defined(KOL_MCK)}{$ELSE}, mirror, Classes, Controls, mckCtrls, mckObjs, Graphics {$IFEND (place your units here->)};
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
{$ENDIF}

type
  {$IF Defined(KOL_MCK)}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I TFormAboutclass.inc} {$ELSE OBJECTS} PFormAbout = ^TFormAbout; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TFormAbout.inc}{$ELSE} TFormAbout = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TFormAbout = class(TForm)
  {$IFEND KOL_MCK}
    KOLForm: TKOLForm;
    LogoPaintBox: TKOLPaintBox;
    NameLabel: TKOLLabelEffect;
    CopyrightLabel: TKOLLabel;
    procedure KOLFormKeyUp(Sender: PControl; var Key: Integer; Shift: Cardinal);
    function KOLFormMessage(var Msg: TMsg; var Rslt: Integer): Boolean;
    procedure KOLFormFormCreate(Sender: PObj);
    procedure LogoPaintBoxPaint(Sender: PControl; DC: HDC);
  private
    FLogo: PBitmap;
  public
    { Public declarations }
  end;

var
  FormAbout {$IFDEF KOL_MCK} : PFormAbout {$ELSE} : TFormAbout {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewFormAbout( var Result: PFormAbout; AParent: PControl );
{$ENDIF}

implementation

{$R About.res}

function nrv2e_decompress(src: Pointer; src_len: Cardinal; dst: Pointer; var dst_len: Cardinal; wrkmem: Pointer): Integer; cdecl;
asm
  pop EBP
  db 85,87,86,83,81,82,131,236,8,137,227,252,139,115,36,139
  db 123,44,137,248,139,83,48,3,2,15,130,137,1,0,0,137
  db 3,137,240,3,67,40,15,130,124,1,0,0,137,67,4,131
  db 205,255,49,201,235,24,59,116,36,4,15,131,58,1,0,0
  db 59,60,36,15,131,81,1,0,0,164,0,219,117,15,59,116
  db 36,4,15,131,34,1,0,0,138,30,70,16,219,114,215,49
  db 192,64,0,219,117,15,59,116,36,4,15,131,10,1,0,0
  db 138,30,70,16,219,17,192,15,136,36,1,0,0,0,219,117
  db 15,59,116,36,4,15,131,239,0,0,0,138,30,70,16,219
  db 114,30,72,0,219,117,15,59,116,36,4,15,131,217,0,0
  db 0,138,30,70,16,219,17,192,15,136,243,0,0,0,235,178
  db 61,2,0,0,1,15,135,230,0,0,0,131,232,3,114,58
  db 193,224,8,59,116,36,4,15,131,173,0,0,0,172,131,240
  db 255,15,132,152,0,0,0,15,137,196,0,0,0,209,248,137
  db 197,115,40,0,219,117,15,59,116,36,4,15,131,137,0,0
  db 0,138,30,70,16,219,17,201,235,74,0,219,117,11,59,116
  db 36,4,115,118,138,30,70,16,219,114,216,65,0,219,117,11
  db 59,116,36,4,115,100,138,30,70,16,219,114,198,0,219,117
  db 11,59,116,36,4,115,83,138,30,70,16,219,17,201,120,106
  db 0,219,117,11,59,116,36,4,115,64,138,30,70,16,219,115
  db 220,131,193,2,129,253,0,251,255,255,131,209,2,137,242,137
  db 254,1,206,114,69,59,52,36,119,64,137,254,1,238,115,65
  db 59,116,36,44,114,59,243,164,137,214,233,219,254,255,255,59
  db 60,36,119,38,59,116,36,4,118,7,184,55,255,255,255,235
  db 5,116,3,72,176,51,43,124,36,44,139,84,36,48,137,58
  db 131,196,8,90,89,91,94,95,93,195,184,54,255,255,255,235
  db 229,184,53,255,255,255,235,222,131,200,255,235,217,144,144,144
end;

{$IF Defined(KOL_MCK)}{$ELSE}{$R *.DFM}{$IFEND}

{$IFDEF KOL_MCK}
{$I AboutForm_1.inc}
{$ENDIF}

procedure TFormAbout.KOLFormKeyUp(Sender: PControl; var Key: Integer; Shift: Cardinal);
begin
  if (Key = VK_RETURN) or (Key = VK_ESCAPE) then
    Form.Close;
end;

function TFormAbout.KOLFormMessage(var Msg: TMsg; var Rslt: Integer): Boolean;
begin
  Result := false;
  if Msg.message = WM_CLOSE then Form.Hide;
end;

procedure TFormAbout.KOLFormFormCreate(Sender: PObj);
var
  Data: PStream;
  BufSize, DecSize: Cardinal;
  Buf, Val: Pointer;
begin
  Form.Caption := Form.Caption + ' ' + Applet.Caption;
  BufSize := GetFileVersionInfoSize(PChar(ExePath), DecSize);
  if BufSize > 0 then
  begin
    GetMem(Buf, BufSize);
    try
      if not GetFileVersionInfo(PChar(ExePath), DecSize, BufSize, Buf) then Exit;
      if VerQueryValue(Buf, '\StringFileInfo\040904E4\LegalCopyright', Val, DecSize) then
        CopyrightLabel.Caption := PChar(Val);
      if VerQueryValue(Buf, '\StringFileInfo\040904E4\FileDescription', Val, DecSize) then
        NameLabel.Caption := PChar(Val);
      if VerQueryValue(Buf, '\', Val, DecSize) then
        with PVSFixedFileInfo(Val)^ do
          NameLabel.Caption := NameLabel.Caption + ' ' + Int2Str(HiWord(dwFileVersionMS)) + '.' + Int2Str(LoWord(dwFileVersionMS));
    finally
      FreeMem(Buf);
    end;
  end;
  Data := NewMemoryStream;
  try
    Resource2Stream(Data, hInstance, 'TCCLOGO', RT_RCDATA);
    Data.Position := 0;
    Data.Read(DecSize, SizeOf(DecSize));
    BufSize := Data.Size - Data.Position;
    GetMem(Buf, BufSize);
    try
      Data.Read(Buf^, BufSize);
      Data.Size := DecSize;
      if (nrv2e_decompress(Buf, BufSize, Data.Memory, DecSize, nil) <> 0) or (DecSize <> Data.Size) then Exit; 
    finally
      FreeMem(Buf);
    end;
    FLogo := NewBitmap(0, 0);
    Data.Position := 0;
    FLogo.LoadFromStream(Data);
    LogoPaintBox.Invalidate;
  finally
    Free_And_Nil(Data);
  end;
end;

procedure TFormAbout.LogoPaintBoxPaint(Sender: PControl; DC: HDC);
begin
  if Assigned(FLogo) then
    FLogo.Draw(LogoPaintBox.Canvas.Handle, 0, 0);
end;

end.



