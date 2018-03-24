unit entrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CoolTrayIcon, Menus, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractConnection, ZConnection, StdCtrls, Buttons, Grids,
  DBGrids, Mask, DBCtrls, ExtCtrls,shellapi;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    Autot1: TMenuItem;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ZQuery1id: TIntegerField;
    ZQuery1nome: TStringField;
    ZQuery1movel: TStringField;
    ZQuery1email: TStringField;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    Edit4: TEdit;
    BitBtn4: TBitBtn;
    PgeraChave: TPanel;
    BitBtn5: TBitBtn;
    Label6: TLabel;
    Edit5: TEdit;
    lblChave: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    Label8: TLabel;
    DBEdit3: TDBEdit;
    DBMemo1: TDBMemo;
    ZQuery1texto: TMemoField;
    ZQuery1chave: TStringField;
    ZQuery1data: TDateTimeField;
    DBEdit4: TDBEdit;
    BitBtn6: TBitBtn;
    MainMenu1: TMainMenu;
    Registos1: TMenuItem;
    Novo1: TMenuItem;
    odos1: TMenuItem;
    help1: TMenuItem;
    Close2: TMenuItem;
    Label9: TLabel;
    Label10: TLabel;
    Howitworks1: TMenuItem;
    WebPage1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure CoolTrayIcon1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Close1Click(Sender: TObject);
    procedure Autot1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure odos1Click(Sender: TObject);
    procedure Close2Click(Sender: TObject);
    procedure WebPage1Click(Sender: TObject);
    procedure Howitworks1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  fileName,chave : string;
  myFile   : TextFile;
begin
if fileexists('chave.txt') then
begin
fileName := 'chave.txt';
AssignFile(myFile, fileName);
reset(myfile);
 while not Eof(myFile) do
   begin
     ReadLn(myFile, chave);
   end;


lblchave.Caption:=chave;
groupbox1.Visible:=true;
closefile(myfile);
end
else
begin
  Pgerachave.Visible:=true;
end;
 //application.ShowMainForm:=false;

end;


procedure TForm1.CoolTrayIcon1Click(Sender: TObject);
begin

form1.Show;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//form1.Visible:=false;
//Action:=caNone;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
application.Terminate;
end;

procedure TForm1.Autot1Click(Sender: TObject);
begin
showmessage('Dúvidas, questões - geral@programamos.pt');
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
zquery1.close;
zquery1.SQL.Clear;
zquery1.SQL.Add('insert into contatos (nome,email,movel,chave,texto) values (:a,:b,:c,:d,:e)');
zquery1.ParamByName('a').AsString:=edit1.Text;
zquery1.ParamByName('b').AsString:=edit3.Text;
zquery1.ParamByName('c').AsString:=edit2.Text;
zquery1.ParamByName('d').AsString:=lblchave.Caption;
zquery1.ParamByName('e').AsString:=memo1.Text;
zquery1.ExecSQL;
showmessage('Elemento adicionado a base de dados');
edit1.Text:='';
edit2.Text:='';
edit3.Text:='';
memo1.Text:='';
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
groupbox2.Visible:=true;
groupbox1.Visible:=false;
zquery1.close;
zquery1.SQL.clear;
zquery1.sql.Add('select * from contatos where chave=:a order by nome');
zquery1.ParamByName('a').AsString:=lblchave.Caption;
zquery1.Open;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
groupbox1.Visible:=true;
groupbox2.Visible:=false;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
if edit4.Text<>'' then
begin
zquery1.SQL.clear;
zquery1.SQL.Add('select * from contatos where nome like "%":a"%" and chave=:b');
zquery1.ParamByName('a').AsString:=edit4.Text;
zquery1.ParamByName('b').AsString:=lblchave.Caption;
zquery1.Open;
end
else
begin
zquery1.SQL.clear;
zquery1.SQL.Add('select * from contatos where chave=:a order by nome');
zquery1.ParamByName('a').AsString:=lblchave.Caption;
zquery1.Open;
end;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var
  fileName : string;
  myFile   : TextFile;
begin

fileName := 'chave.txt';
AssignFile(myFile, fileName);
ReWrite(myFile);
Write(myFile, edit5.text);
closefile(myfile);
showmessage('Chave gerada! Pode usar o programa.');
groupbox2.Visible:=true;
pgerachave.Visible:=false;

end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
close;
end;

procedure TForm1.Novo1Click(Sender: TObject);
begin
groupbox1.Visible:=true;
groupbox2.Visible:=false;
end;

procedure TForm1.odos1Click(Sender: TObject);
begin
groupbox1.Visible:=false;
groupbox2.Visible:=true;
groupbox2.Visible:=true;
groupbox1.Visible:=false;
zquery1.close;
zquery1.SQL.clear;
zquery1.sql.Add('select * from contatos where chave=:a order by nome');
zquery1.ParamByName('a').AsString:=lblchave.Caption;
zquery1.Open;
end;

procedure TForm1.Close2Click(Sender: TObject);
begin
close;
end;

procedure TForm1.WebPage1Click(Sender: TObject);
begin
ShellExecute(0, 'open', PChar('http://www.programamos.pt/programa-gratis-gestao-contatos-clientes/'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.Howitworks1Click(Sender: TObject);
begin
ShellExecute(0, 'open', PChar('https://youtu.be/TGdXKXoPM2g'), nil, nil, SW_SHOWNORMAL);


end;

end.

