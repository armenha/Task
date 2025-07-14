unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Grids,System.Generics.Collections,System.Threading,System.Types,System.StrUtils,
  Vcl.Menus;

 const
 WM_FILESEARCH_FOUND=WM_USER+1;
 WM_Cancle_Task= WM_USER+2;
 WM_Info_Msg= WM_User+3;
 wm_terminated=WM_User+5;
type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Caption1: TMenuItem;
    Timer1: TTimer;
    CategoryPanelGroup1: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    Button3: TButton;
    Button1: TButton;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    CategoryPanel2: TCategoryPanel;
    Button5: TButton;
    Recursive: TCheckBox;
    SearchTextEdit: TEdit;
    PaternEdit: TEdit;
    PathEdit: TEdit;
    CategoryPanel3: TCategoryPanel;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Memo1: TMemo;
    Button7: TButton;
    Button6: TButton;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CategoryPanel4: TCategoryPanel;
    Button2: TButton;
    StringGrid2: TStringGrid;
    Label4: TLabel;
    ComandEdit: TEdit;
    Edit1: TEdit;
    Label5: TLabel;
    RadioGroup1: TRadioGroup;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);

    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Caption1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure MsgCancelLog(var msg: TMessage); message WM_Cancle_Task;
    procedure MsgFoundLog(var msg: TMessage); message WM_FILESEARCH_FOUND;
    procedure MsgInfo(var msg: TMessage); message WM_Info_Msg;
    procedure MsgProcInfo(var msg: TMessage);message wm_terminated;

    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: Char);



  private
    { Private declarations }

   taskdic:TDictionary<integer,itask>;
   DLLInstance1,DLLInstance2:Thandle;
   currow,currow2:integer;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;


//function FileSearch(const handle:Thandle;const PathName, FileName : string;
//   txtToSearch : string; const InDir):itask; external 'TaskLibrary.dll';
//function Offsets (handle:thandle;const filename,patern:ansistring):itask;external 'TestLibrary.dll';

implementation

{$R *.dfm}
uses FileCtrl,system.IOUtils,Winapi.ShellAPI;



procedure TForm1.Button1Click(Sender: TObject);

type
TOffsets=function (handle:thandle;const filename:string;const patern:Tarray<Tbytes>):itask;
var
r:integer;
ctask:itask;
Offsets : TOffsets;
pat:Tarray<Tbytes>;
strs:Tarray<string>;
i,j:integer;
s:ansistring;
begin
if labeledEdit1.Text='' then
begin
    MessageDlg('Path is Empty', mtError, [mbOK], 0);
    Exit;
 end;


if DLLInstance1=0 then
  DLLInstance1:= loadlibrary('TaskLibrary.dll');
if DLLInstance1 = 0 then begin
    MessageDlg('Unable to load DLL.', mtError, [mbOK], 0);
    Exit;
          end;
@Offsets := GetProcAddress(DLLInstance1, 'Offsets');

  if @Offsets <> nil then

  begin
  if radiogroup1.ItemIndex=0 then
    begin
  if labeledEdit2.Text='' then
begin
    MessageDlg('Patern is Empty', mtError, [mbOK], 0);
    Exit;
 end;

  strs:=splitstring(LabeledEdit2.Text,'|');
  setlength(pat,(length(strs)));
for I := Low(strs) to High(strs) do
begin
s:=strs[i];
pat[i]:=Bytesof(s)
end;
      end
   else
 begin  //Hex
   if Edit1.Text='' then
begin
    MessageDlg('Patern is Empty', mtError, [mbOK], 0);
    Exit;
 end;

 strs:=splitstring(Edit1.Text,'|');
 setlength(pat,(length(strs)));
 for I := Low(strs) to High(strs) do
begin
 if length(strs[i]) mod 2<>0 then
 begin
  MessageDlg('Length of Hex Paterns must be Even', mtError, [mbOK], 0);
    Exit;
 end;
setlength(pat[i],length(strs[i]) div 2);
HexToBin(Pchar(strs[i]),0,pat[i],0,length(pat[i]));
end;
  end;

  ctask:=Offsets(handle,LabeledEdit1.Text,pat);
  taskdic.Add(ctask.id,ctask);

 with StringGrid1 do
   begin
    Cells[0,currow] := inttostr(ctask.id);
    Cells[1,currow] := Labelededit1.Text;
    Cells[2,currow] := Labelededit2.Text;;
    Cells[5,currow] := 'Running';
   end;
   inc(currow);
  end;

end;


procedure TForm1.Button2Click(Sender: TObject);
type TRunAndMonitore= function (handle:thandle;comline:string):Cardinal;
var
  FilePath: string;
  RunAndMonitore:TRunAndMonitore;
  procid:Cardinal;

begin
 // FilePath := 'D:\MyDocuments\Python\Open3d\elipsee.py';
  //ShellExecute(memo2.handle, 'open', PChar(FilePath), nil, nil, SW_SHOWNORMAL);

  if DLLInstance2=0 then
  DLLInstance2:= loadlibrary('ProcMonitor.dll');
if DLLInstance2 = 0 then begin
    MessageDlg('Unable to load DLL.', mtError, [mbOK], 0);
    Exit;
          end;

@RunAndMonitore:= GetProcAddress(DLLInstance2, 'RunAndMonitore');
 procid:= RunAndMonitore(handle,ComandEdit.Text);
 if procid>0 then
 begin
 stringgrid2.Cells[0,currow2]:=inttostr(procid);
 stringgrid2.Cells[1,currow2]:=ComandEdit.Text;
 stringgrid2.Cells[2,currow2]:='Running';
 inc(currow2);
 end
 else
 MessageDlg('Error in comand Line', mtError, [mbOK], 0);

end;

procedure TForm1.Button3Click(Sender: TObject);
var
Dir:String;
begin
if opendialog1.Execute then
LabeledEdit1.Text:=opendialog1.FileName
end;

procedure TForm1.Button5Click(Sender: TObject);
type
TFileSearch=function (const handle:Thandle;const PathName, FileName ,
   txtToSearch : string; const InDir:boolean):itask;
var
ctask:itask;
FileSearch:TFileSearch;
begin
if DLLInstance1=0 then
  DLLInstance1:= loadlibrary('TaskLibrary.dll');
if DLLInstance1 = 0 then begin
    MessageDlg('Unable to load DLL.', mtError, [mbOK], 0);
    Exit;
          end;

@FileSearch:= GetProcAddress(DLLInstance1, 'FileSearch');
ctask:= FileSearch(handle,pathEdit.Text,PaternEdit.Text,SearchTextEdit.Text,recursive.Checked);
taskdic.Add(ctask.id,ctask);


with StringGrid1 do
   begin
    Cells[0,currow] := inttostr(ctask.id);
    Cells[1,currow] := PathEdit.Text;
    Cells[2,currow] := SearchTextEdit.Text;;
    Cells[3,currow] := PaternEdit.Text;;
    Cells[5,currow] := 'Running';
   end;
 inc(currow);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
memo1.Lines.Clear;
end;

procedure TForm1.Button7Click(Sender: TObject);

const
  SELDIRHELP = 1000;
var
  Dir: string;
begin
  Dir := 'C:\Windows';
  if FileCtrl.SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
    PathEdit.Text := Dir;

end;

procedure TForm1.Caption1Click(Sender: TObject);
begin
if StringGrid1.Row>0 then
 if  StringGrid1.Cells[0,StringGrid1.Row]<>'' then
  if taskdic.ContainsKey(strtoint(StringGrid1.Cells[0,StringGrid1.Row])) then
   taskdic.items[strtoint(StringGrid1.Cells[0,StringGrid1.Row])].Cancel;
//memo1.Lines.Add(StringGrid1.Cells[1,StringGrid1.Row])

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9','A'..'F','a'..'f',#8,'|']) then
    Key := #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not DirectoryExists(ExtractFilePath(application.ExeName)+'Log') then
   TDirectory.CreateDirectory( ExtractFilePath(application.ExeName)+'Log');

currow:=1;
currow2:=1;

taskdic:=TDictionary<integer,itask>.create;
dllInstance1:=0;
dllInstance2:=0;
StringGrid1.ColWidths[0]:=50;
StringGrid1.ColWidths[1]:=200;
StringGrid1.ColWidths[2]:=150;
StringGrid1.ColWidths[3]:=80;
StringGrid1.ColWidths[4]:=100;
StringGrid1.ColWidths[5]:=80;
with StringGrid1 do
  begin
    Cells[0,0] := 'TaskId';
    Cells[1,0] := 'File or Folder Name';
    Cells[2,0] := 'SearchPatern';
    Cells[3,0] := 'Mask';
    Cells[4,0] := 'Found';
    Cells[5,0] := 'Status';

  end;

StringGrid2.ColWidths[0]:=70;
StringGrid2.ColWidths[1]:=450;
StringGrid2.ColWidths[2]:=120;

with StringGrid2 do
  begin
    Cells[0,0] := 'ProcessId';
    Cells[1,0] := 'Command';
    Cells[2,0] := 'Process Status';
  end;

end;

procedure TForm1.FormDestroy(Sender: TObject);
var
 ReleaseThreadPool:procedure;
begin
 taskdic.Free;
 if DLLInstance1<>0 then
 begin
  @ReleaseThreadPool:= GetProcAddress(DLLInstance1,'ReleaseThreadPool');
  ReleaseThreadPool;
  FreeLibrary(DLLInstance1);

 end;
 if DLLInstance2<>0 then
   FreeLibrary(DLLInstance2);

end;

procedure TForm1.LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
begin
if not ( ord(key) in [0..255]) then
 Key:=#0;

end;

procedure TForm1.MsgCancelLog(var msg: TMessage);
begin
if msg.LParam=0 then
memo1.Lines.Add('Task '+inttostr(msg.WParam)+ ' Canceled')
else
memo1.Lines.Add('Task '+inttostr(msg.WParam)+ 'Running')
end;

procedure TForm1.MsgFoundLog(var msg: TMessage);
var
i:integer;
begin
//Memo1.Lines.Add('From task '+inttostr(msg.WParam)+' Found '+inttostr(msg.LParam)+' Files');
with stringgrid1 do
if cols[0].IndexOf(inttostr(msg.WParam))>0 then
cells[4,cols[0].IndexOf(inttostr(msg.WParam))]:=inttostr(msg.LParam);


end;

procedure TForm1.MsgInfo(var msg: TMessage);
begin
memo1.Lines.Add('Task '+inttostr(msg.WParam)+' Working on Patern '+string(msg.LParam))
end;

procedure TForm1.MsgProcInfo(var msg: TMessage);
begin
with stringgrid2 do
if cols[0].IndexOf(inttostr(msg.WParam))>0 then
cells[2,cols[0].IndexOf(inttostr(msg.WParam))]:='Terminated';

 memo1.Lines.Add('Proc Term') ;
  memo1.Lines.Add(inttostr(msg.LParam)) ;
    memo1.Lines.Add(inttostr(Still_Active)) ;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
task:itask;
i:integer;
begin
if stringgrid1.RowCount>1 then
 for i:=1  to currow-1   do
  begin
 if stringgrid1.Cells[0,i]<>'' then
 begin
 task:=taskdic.Items[strtoint(stringgrid1.Cells[0,i])];

 case task.Status of
   TTaskStatus.Running:stringgrid1.Cells[5,i]:='Running' ;
   TTaskStatus.Completed:stringgrid1.Cells[5,i]:='Completed' ;
   TTaskStatus.Canceled:stringgrid1.Cells[5,i]:='Canceled';
   TTaskStatus.Exception:stringgrid1.Cells[5,i]:='Exception';

  end;
end;
 end;
end;
end.
