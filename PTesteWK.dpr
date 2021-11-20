program PTesteWK;

uses
  Vcl.Forms,
  UTeste in 'UTeste.pas' {frmTeste},
  DMTeste in 'DMTeste.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTeste, frmTeste);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
