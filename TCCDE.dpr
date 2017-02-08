{ KOL MCK } // Do not remove this line!
program TCCDE;

uses
KOL,
  MainForm in 'MainForm.pas' {FormMain},
  SearchForm in 'SearchForm.pas' {FormSearch},
  OptionsForm in 'OptionsForm.pas' {FormOptions},
  AboutForm in 'AboutForm.pas' {FormAbout};

{$R *.res}
{$R Manifest.res}

begin // PROGRAM START HERE -- Please do not remove this comment

{$IF Defined(KOL_MCK)} {$I TCCDE_0.inc} {$ELSE}

  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormSearch, FormSearch);
  Application.CreateForm(TFormOptions, FormOptions);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;

{$IFEND}

end.

