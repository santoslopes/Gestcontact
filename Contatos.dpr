program Contatos;

uses
  Forms,
  entrada in 'entrada.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gestor de Contatos';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
