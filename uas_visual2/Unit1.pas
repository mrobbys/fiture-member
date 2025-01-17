unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection, frxClass,
  frxDBSet;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    btnbaru: TButton;
    btnsimpan: TButton;
    btnedit: TButton;
    btnhapus: TButton;
    btnbatal: TButton;
    Label7: TLabel;
    Label8: TLabel;
    DBGrid1: TDBGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    ComboBox1: TComboBox;
    btncetak: TButton;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
  procedure FormCreate(Sender: TObject);
  procedure btnCloseClick(Sender: TObject);
  procedure btnbatalClick(Sender: TObject);
  procedure ComboBox1Change(Sender: TObject);
    procedure btnbaruClick(Sender: TObject);
    procedure btnsimpanClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnhapusClick(Sender: TObject);
    procedure btneditClick(Sender: TObject);
    procedure btncetakClick(Sender: TObject);
private
  { Private declarations }
  procedure baru();

public
  { Public declarations }
end;

var
  Form1: TForm1;
  id: String;

implementation

{$R *.dfm}

procedure TForm1.baru;
begin
  edit1.Clear;
  edit2.Clear;
  edit3.Clear;
  edit4.Clear;
  edit5.Clear;
  btnsimpan.Enabled := True;
  btnedit.Enabled := False;
  btnhapus.Enabled := False;
  ComboBox1.Text := 'Pilih--';
  Label8.Caption := 'TERISI OTOMATIS';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  baru();
  ComboBox1.Items.Add('Yes');
  ComboBox1.Items.Add('No');

end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.btnbatalClick(Sender: TObject);
begin
   edit1.Clear;
   edit2.clear;
   edit3.clear;
   edit4.clear;
   edit5.Clear;
   ComboBox1.Text := 'Pilih--';
  Label8.Caption := 'TERISI OTOMATIS';

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.Text = 'Yes' then
    Label8.Caption := 'Diskon: 10%'
  else if ComboBox1.Text = 'No' then
  Label8.Caption := 'Diskon: 5%';
end;



procedure TForm1.btnbaruClick(Sender: TObject);
begin
baru();
end;

procedure TForm1.btnsimpanClick(Sender: TObject);
begin
if edit1.Text= '' then
	MessageDlg('NIK belum diisi!', mtWarning, [mbOK], 0)
else if edit2.Text= '' then
	MessageDlg('Nama belum diisi!', mtWarning, [mbOK], 0)
else if edit3.Text= '' then
	MessageDlg('Nomor Telepon belum diisi!', mtWarning, [mbOK], 0)
else if edit4.Text= '' then
	MessageDlg('Email belum diisi!', mtWarning, [mbOK], 0)
else if edit5.Text= '' then
	MessageDlg('Alamat belum diisi!', mtWarning, [mbOK], 0)
else if ComboBox1.Text= '' then
	MessageDlg('Member belum Dipilih!', mtWarning, [mbOK], 0)
else
begin
ZQuery1.SQL.Clear;
ZQuery1.SQL.Add('Insert into kustomer (nik,nama,telp,email,alamat,member) values (:nik, :nama, :telp, :email, :alamat, :member)');
ZQuery1.ParamByName('nik').AsString := edit1.text;
ZQuery1.ParamByName('nama').AsString := edit2.text;
ZQuery1.ParamByName('telp').AsString := edit3.text;
ZQuery1.ParamByName('email').AsString := edit4.text;
ZQuery1.ParamByName('alamat').AsString := edit5.text;
ZQuery1.ParamByName('member').AsString := ComboBox1.text;
ZQuery1.ExecSQL;
baru();
ZQuery1.SQL.Clear;
ZQuery1.SQL.Add('select * from kustomer');
ZQuery1.Open;
ShowMessage('Data Kustomer berhasil ditambahkan!');
ZQuery1.refresh
end;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
btnsimpan.Enabled := False;
btnedit.Enabled := True;
btnhapus.Enabled := True;
id := zquery1.fields[0].AsString;
edit1.text:=zquery1.fields[1].AsString;
edit2.text:=zquery1.fields[2].AsString;
edit3.text:=zquery1.fields[3].AsString;
edit4.text:=zquery1.fields[4].AsString;
edit5.text:=zquery1.fields[5].AsString;
ComboBox1.text:=zquery1.fields[6].AsString;

if ComboBox1.Text = 'Yes' then
    Label8.Caption := 'Diskon: 10%'
  else if ComboBox1.Text = 'No' then
  Label8.Caption := 'Diskon: 5%';
end;

procedure TForm1.btnhapusClick(Sender: TObject);
begin
if MessageDlg('Apakah Anda yakin ingin menghapus data ini?', mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
Zquery1.sql.clear;
zquery1.sql.add('delete from kustomer where id= "'+id+'"');
zquery1.execsql;
baru();
ZQuery1.SQL.Clear;
ZQuery1.SQL.Add('select * from kustomer');
ZQuery1.Open;
ShowMessage('Data Kustomer berhasil dihapus!');
ZQuery1.refresh;
  end;
end;


procedure TForm1.btneditClick(Sender: TObject);
begin
if edit1.Text= '' then
	MessageDlg('Data Belum Dipilih!', mtWarning, [mbOK], 0)
else if edit2.Text= '' then
	MessageDlg('Data Belum Dipilih!', mtWarning, [mbOK], 0)
else if edit3.Text= '' then
	MessageDlg('Data Belum Dipilih!', mtWarning, [mbOK], 0)
else if edit4.Text= '' then
	MessageDlg('Data Belum Dipilih!', mtWarning, [mbOK], 0)
else if edit5.Text= '' then
	MessageDlg('Data Belum Dipilih!', mtWarning, [mbOK], 0)
else if ComboBox1.Text= '' then
	MessageDlg('Data Belum Dipilih!', mtWarning, [mbOK], 0)
else
begin
ZQuery1.SQL.Clear;
Zquery1.sql.add('update kustomer set nik="'+edit1.text+'",nama="'+edit2.text+'",telp="'+edit3.text+'",email="'+edit4.text+'",alamat="'+edit5.text+'",member="'+combobox1.text+'" where id="'+id+'"');
zquery1.execsql;

zquery1.sql.clear;
zquery1.sql.add('select * from kustomer');
zquery1.Open;
ShowMessage('Data satuan berhasil diperbarui!');
zquery1.Refresh;
end;end;

procedure TForm1.btncetakClick(Sender: TObject);
begin
frxreport1.LoadFromFile(extractfilepath(application.Exename)+'\data_kustomer.fr3');
frxreport1.ShowReport();
end;

end.

