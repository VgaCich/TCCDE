unit Gutter;

interface

uses
  Windows, Types, KOL, KOLHilightEdit;

function NewGutter(AParent: PControl; Editor: PHilightMemo): PControl;

implementation

{$R Gutter.res}

type
  PGutter = ^TGutter;
  TGutter = object(TObj)
  private
    FGutter: PControl;
    FEditor: PHilightMemo;
    FBookmarks: PImageList;
    procedure EraseBkgnd(Sender: PControl; DC: HDC);
    procedure Paint(Sender: PControl; DC: HDC);
  public
    procedure Init; virtual;
    destructor Destroy; virtual;
    procedure Update(Sender: PObj);
  end;

function NewGutter(AParent: PControl; Editor: PHilightMemo): PControl;
var
  Gutter: PGutter;
begin
  Result := NewPanel(AParent, esLowered).SetBorder(0);
  Result.Font.Assign(Editor.Font);
  New(Gutter, Create);
  Gutter.FGutter := Result;
  Gutter.FEditor := Editor;
  Result.CustomObj := Gutter;
  Result.OnPaint := Gutter.Paint;
  Result.OnEraseBkgnd := Gutter.EraseBkgnd;
  Editor.Edit.OnScroll := Gutter.Update;
  Editor.Edit.OnBookmark := Gutter.Update;
end;

{ TGutter }

destructor TGutter.Destroy;
begin
  Free_And_Nil(FBookmarks);
  inherited;
end;

procedure TGutter.Update(Sender: PObj);
var
  Width: Integer;
begin
  FGutter.Invalidate;
  Width := FGutter.Canvas.TextWidth(Int2Str(FEditor.Edit.TopLine + FEditor.Edit.LinesVisiblePartial)) + 16;
  if Width > FGutter.Width then
    FGutter.Width := Width;
end;

procedure TGutter.Init;
begin
  inherited;
  FBookmarks := NewImageList(FGutter);
  FBookmarks.ShareImages := true;
  FBookmarks.ImgWidth := 11;
  FBookmarks.ImgHeight := 14;
  FBookmarks.LoadBitmap('EDITORBOOKMARKS', clFuchsia);
end;

procedure TGutter.EraseBkgnd(Sender: PControl; DC: HDC);
begin
  FGutter.Canvas.Brush.Color := FGutter.Color;
  FGutter.Canvas.FillRect(FGutter.ClientRect);
end;

procedure TGutter.Paint(Sender: PControl; DC: HDC);
var
  i: Integer;

  function LineNum: string;
  begin
    if FEditor.Edit.TopLine + i < FEditor.Edit.Count then
      Result := Int2Str(FEditor.Edit.TopLine + i + 1)
    else
      Result := '';
  end;

begin
  for i := 0 to FEditor.Edit.LinesVisiblePartial - 1 do
  begin
    FGutter.Canvas.Brush.Color := FGutter.Color;
    if FEditor.Edit.TopLine + i = FEditor.Edit.Caret.Y then
    begin
      FGutter.Canvas.Brush.Color := FGutter.Color1;
      FGutter.Canvas.FillRect(Rect(0, i * FEditor.Edit.LineHeight, FGutter.Width, (i + 1) * FEditor.Edit.LineHeight));
    end;
    FGutter.Canvas.TextOut(FGutter.Width - FGutter.Canvas.TextWidth(LineNum) - 15, i * FEditor.Edit.LineHeight, LineNum);
  end;
  for i := 0 to 9 do
    with FEditor.Edit.Bookmarks[i] do
      if (Y >= FEditor.Edit.TopLine) and (Y <= FEditor.Edit.TopLine + FEditor.Edit.LinesVisiblePartial - 1) then
        FBookmarks.Draw(i, FGutter.Canvas.Handle, FGutter.Width - 13, (Y - FEditor.Edit.TopLine) * FEditor.Edit.LineHeight);
end;

end.
