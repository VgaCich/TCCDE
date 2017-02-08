unit Hilighter;

interface

uses
  Windows, KOL, KOLHilightEdit;

type
  THilightStyle = (hsDefault, hsKeyword, hsPreprocessor, hsComment, hsString, hsNumber);
  THilightStyles = array[THilightStyle] of TTokenAttrs;
  PCHilighter=^TCHilighter;
  TCHilighter = object(TObj)
  private
    FStyles: THilightStyles;
    FDefStart: Integer;
  public
    procedure Init; virtual;
    destructor Destroy; virtual;
    function ScanToken(Sender: PControl; const FromPos: TPoint; var Attrs: TTokenAttrs): Integer;
    property Styles: THilightStyles read FStyles write FStyles;
  end;

const
  StyleNames: array[THilightStyle] of string =
    ('Default', 'Keyword', 'Preprocessor', 'Comment', 'String', 'Number');
  DefStyles: THilightStyles = (
    (fontstyle: [];         fontcolor: clBlack;  backcolor: clWhite),
    (fontstyle: [fsBold];   fontcolor: clNavy;   backcolor: clWhite),
    (fontstyle: [];         fontcolor: clGreen;  backcolor: clWhite),
    (fontstyle: [fsItalic]; fontcolor: clTeal;   backcolor: clWhite),
    (fontstyle: [];         fontcolor: clBlue;   backcolor: clWhite),
    (fontstyle: [];         fontcolor: clMaroon; backcolor: clWhite));

implementation

const
  Keywords: array[0..34] of string = ('sizeof', 'typedef', 'auto', 'register', 'extern', 'static',
    'char', 'short', 'int', 'long', 'signed', 'unsigned', 'float', 'double', 'void',
    'struct', 'enum', 'union', 'do', 'for', 'while', 'if', 'else', 'switch', 'case', 'default',
    'break', 'continue', 'goto', 'return', 'inline', 'restrict', '_Bool', '_Complex', '_Imaginary');
  Letters: set of Char = ['_', 'a'..'z', 'A'..'Z', '0'..'9'];
  Digits: set of Char = ['0'..'9', 'a'..'f', 'x', 'b', '.', 'L', 'f'];

procedure TCHilighter.Init;
begin
  inherited;
  FDefStart := -2;
  FStyles := DefStyles;
end;

destructor TCHilighter.Destroy;
begin
  inherited;
end;

function TCHilighter.ScanToken(Sender: PControl; const FromPos: TPoint; var Attrs: TTokenAttrs ): Integer;
var
  Text: string;
  i: Integer;
begin
  Attrs := FStyles[hsDefault];
  Text := PHilightMemo(Sender).Edit.Lines[FromPos.Y];
  Delete(Text, 1, FromPos.X);
  if Text = '' then
  begin
    Result := 0;
  end
  else if FromPos.Y = FDefStart + 1 then
  begin
    Result := Length(Text);
    Attrs := FStyles[hsPreprocessor];
    if Text[Length(Text)] = '\' then
      FDefStart := FromPos.Y;
  end
  else if Text[1] <= ' ' then
  begin
    i := 1;
    while (i < Length(Text) - 1) and (Text[i] <= ' ') do
      Inc(i);
    Result := i - 1;
  end
  else if Text[1] in ['0'..'9'] then
  begin
    i := 2;
    while (i < Length(Text)) and (Text[i] in Digits) do
      Inc(i);
    Result := i - 1;
    Attrs := FStyles[hsNumber];
  end
  else if Text[1] in Letters then
  begin
    i := 1;
    while (i < Length(Text) - 1) and (Text[i] in Letters) do
      Inc(i);
    Result := i - 1;
    Text := Copy(Text, 1, Result);
    for i := 0 to High(Keywords) do
      if Text = Keywords[i] then
      begin
        Attrs := FStyles[hsKeyword];
        Break;
      end;
  end
  else if Text[1] = '#' then
  begin
    Result := Length(Text);
    Attrs := FStyles[hsPreprocessor];
    if (Copy(Text, 1, 7) = '#define') and (Text[Length(Text)] = '\') then
      FDefStart := FromPos.Y;
  end
  else if Text[1] in ['''', '"'] then
  begin
    Result := Pos(Text[1], Copy(Text, 2, MaxInt)) + 1;
    Attrs := FStyles[hsString];
  end
  else if Copy(Text, 1, 2) = '//' then
  begin
    Result := Length(Text);
    Attrs := FStyles[hsComment];
  end
    else Result := 1;
end;

end.
