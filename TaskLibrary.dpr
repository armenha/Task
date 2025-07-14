library TaskLibrary;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters.

  Important note about VCL usage: when this DLL will be implicitly
  loaded and this DLL uses TWicImage / TImageCollection created in
  any unit initialization section, then Vcl.WicImageInit must be
  included into your library's USES clause. }

uses
  System.SysUtils,System.Threading,WinApi.Messages,WinApi.Windows,
   System.Classes,System.Types,System.StrUtils,System.IOUtils,System.AnsiStrings;

{$R *.res}

const
 WM_FILESEARCH_FOUND=WM_USER+1;
 WM_Cancle_Task= WM_User+2;
 WM_Info_Msg= WM_User+3;

 var
 i:integer;
 tpool: TThreadPool;

{function Offsets (handle:thandle;const filename:string;const patern:ansistring):itask;export

var
ofsets:String;
st:tbytesstream;
buffer,Seq:Tbytes;
paterns:TStringDynArray;
p:ansistring;
log:tstringlist;
ctask:Itask;
fs:tfilestream;
buflen:Nativeint;
LReadCount:Nativeint;
Foffset:Int64;

 begin
ctask:=TTask.Create(procedure
var
fcount, i:integer;


Procedure FindByteSequenceCompareMem(const Data: TBytes; const Sequence: TBytes;ofs:int64);
var
  i: Int64;
begin
  if (Length(Data) = 0) or (Length(Sequence) = 0) or (Length(Sequence) > Length(Data)) then
    Exit;

  for i := 0 to Length(Data) - Length(Sequence) do
     begin
     //sleep(1);

    if CompareMem(@Data[i], @Sequence[0], Length(Sequence)) then
    begin
    ofsets:=ofsets+inttostr(ofs+i)+',';
    inc(fcount);
    PostMessage(handle,WM_FILESEARCH_FOUND,ctask.id,fcount)
    end


     end;

   end;
begin
log:=tstringlist.Create;
log.Add('File:'+ filename);
fs:=tfilestream.Create(filename,fmopenread);

p:=patern;
paterns:=splitstring(p,'|');

try
 try
for I := Low(paterns) to High(paterns) do
     begin
fcount:=0;
fs.position:=0;
ctask.CheckCanceled;
 p:=paterns[i];
 seq:=BytesOf(p);
 ofsets:='';
// buflen:=length(p)*1000000
 setlength(buffer,length(p)*5000000);
Foffset:=0;
 SendTextMessage(handle,WM_Info_Msg,ctask.Id,paterns[i]);
 repeat
    LReadCount := fs.Read(Buffer[0], Length(Buffer));
    if LReadCount > 0 then
    begin
    FindByteSequenceCompareMem(buffer,seq,Foffset);
    fs.Position:=fs.Position-length(seq);
    Foffset:=fs.Position;

    end;
 until LReadCount < Length(Buffer);
   log.Add(p +' '+ ofsets);

      end;
 except
   on EOperationCancelled do  SendMessage(handle,WM_Cancle_Task,ctask.Id,0);
   //  SendMessage(handle,WM_Cancle_Task,ctask.Id,0);
   //  raise;
   //TThread.Synchronize(TThread.Current, procedure
   //                    begin form1.memo1.lines.add('task '+inttostr(ctask.Id)+' canseled on '+p) end);
    end;

// log.SaveToFile('Log_'+extractfilename(filename)+'_'+patern+'.log')
 log.SaveToFile('.\Log\Log_'+Tpath.GetFileNameWithoutExtension(filename)+'_'+
       Tpath.GetExtension(filename)+'_'+System.AnsiStrings.StringReplace(patern,'|','_',[rfReplaceAll]) +'.log')

finally
 fs.Free;
 log.Free;
 end; end);
result:=ctask.Start
end; }

function Offsets (handle:thandle;const filename:string;const patern:Tarray<Tbytes>):itask;export

var
ofsets:String;
st:tbytesstream;
buffer,Seq:Tbytes;
paterns:TStringDynArray;
pp,p:ansistring;
log:tstringlist;
ctask:Itask;
fs:tfilestream;
buflen:Nativeint;
LReadCount:Nativeint;
Foffset:Int64;

 begin
ctask:=TTask.Create(procedure
var
fcount, i:integer;


Procedure FindByteSequenceCompareMem(const Data: TBytes; const Sequence: TBytes;ofs:int64);
var
  i: Int64;
begin
  if (Length(Data) = 0) or (Length(Sequence) = 0) or (Length(Sequence) > Length(Data)) then
    Exit;

  for i := 0 to Length(Data) - Length(Sequence) do
     begin
     //sleep(1);

    if CompareMem(@Data[i], @Sequence[0], Length(Sequence)) then
    begin
    ofsets:=ofsets+inttostr(ofs+i)+',';
    inc(fcount);
    PostMessage(handle,WM_FILESEARCH_FOUND,ctask.id,fcount)
    end


     end;

   end;
begin
log:=tstringlist.Create;
log.Add('File:'+ filename);
fs:=tfilestream.Create(filename,fmopenread);


//p:=patern;


//paterns:=splitstring(p,'|');

try
 try
for I := Low(patern) to High(patern) do
     begin
 setlength(p,length(patern[i])*2);
 BinToHex(PansiChar(patern[i]),PansiChar(p),length(patern[i]));
 pp:=pp+p+'_';
fcount:=0;
fs.position:=0;
ctask.CheckCanceled;
 //p:=paterns[i];
// seq:=BytesOf(p);
 ofsets:='';
// buflen:=length(p)*1000000
 setlength(buffer,length(p)*5000000);
Foffset:=0;
 SendTextMessage(handle,WM_Info_Msg,ctask.Id,string(p));
 repeat
    LReadCount := fs.Read(Buffer[0], Length(Buffer));
    if LReadCount > 0 then
    begin
    FindByteSequenceCompareMem(buffer,patern[i],Foffset);
    fs.Position:=fs.Position-length(seq);
    Foffset:=fs.Position;

    end;
 until LReadCount < Length(Buffer);
   log.Add(p +' '+ ofsets);

      end;
 except
   on EOperationCancelled do  SendMessage(handle,WM_Cancle_Task,ctask.Id,0);
   //  SendMessage(handle,WM_Cancle_Task,ctask.Id,0);
   //  raise;
   //TThread.Synchronize(TThread.Current, procedure
   //                    begin form1.memo1.lines.add('task '+inttostr(ctask.Id)+' canseled on '+p) end);
    end;

// log.SaveToFile('Log_'+extractfilename(filename)+'_'+patern+'.log')
 log.SaveToFile('.\Log\Log_'+Tpath.GetFileNameWithoutExtension(filename)+'_'+
       Tpath.GetExtension(filename)+'_'+pp +'.log')

finally
 fs.Free;
 log.Free;
 end; end);
result:=ctask.Start
end;



function FileSearch(const handle:Thandle;const PathName,FilePatern , txtToSearch : string; const InDir:boolean):itask;export;

var

ctask:Itask;
pp:pansichar;
sst:Tstringstream;
i:integer;
log:Tstringlist;


 begin
 sst:=Tstringstream.Create;
 log:=Tstringlist.Create;

 ctask:=TTask.Create(
 procedure

 procedure Search(const PathName, FilePatern : string; txtToSearch : string; const InDir,reset : boolean);


 var Rec  : TSearchRec;
 Path : string;
 found:Boolean;


begin

 if reset then
 begin

log.Clear ;
log.Add('LogFile for Search PathName '+PathName+' FilePatern '+FilePatern+' txtToSearch '+txtToSearch);
 i:=0;
 end;

sst.SetSize(0);

Path := IncludeTrailingBackslash(PathName);
if FindFirst(Path + FilePatern, faAnyFile - faDirectory, Rec) = 0 then
 try

   repeat
   found:=True;
   if trim(txtToSearch)<>''  then
      begin
     sst.LoadFromFile(Path+Rec.Name);
     if not ContainsStr(sst.DataString, txtToSearch) then
       found:=false
      end ;

   if found then
    begin

       inc(i);
       log.Add(Path + Rec.Name);

  //    SendTextMessage(Handle, WM_FILESEARCH_FOUND,i,Path + Rec.Name);
      //sleep(100);
      ctask.CheckCanceled;
      SendMessage (Handle,WM_FILESEARCH_FOUND,ctask.id,i);

//
      end ;


   until FindNext(Rec) <> 0;



 finally
  System.SysUtils.FindClose(Rec);

 end;

If not InDir then
 begin
  //PostMessage (Handle, WM_FILESEARCH_FINISHED, 1,0);
  sst.free;
  Exit;
 end;



if FindFirst(Path + '*.*', faDirectory, Rec) = 0 then

 try

   repeat

    if ((Rec.Attr and faDirectory) <> 0)  and (Rec.Name<>'.') and (Rec.Name<>'..') then

     Search(Path + Rec.Name, FilePatern, txtToSearch,True, False);



   until FindNext(Rec) <> 0;
 finally

  System.SysUtils.FindClose(Rec);

  end;




end;

 begin
 try
  try
Search(PathName,FilePatern, txtToSearch,InDir,True);
log.SaveToFile('.\Log\Log_Task'+inttostr(ctask.id)+'.log');
 except on EOperationCancelled do sendmessage(handle, WM_Cancle_Task,ctask.Id,0)
  end;
 finally
 log.Free;
 sst.Free;
 end;
 end,tpool);

 result:=ctask;
 result.start

end;


procedure ReleaseThreadPool;export;
begin
  FreeAndNil(tpool);
end;

function FileSearch2(const handle:Thandle;const PathName,FilePatern : string; txtToSearch : string; const InDir:boolean):itask;export;
 var
 ctask:itask;
begin
ctask:=TTask.Create(procedure
var
sst:Tstringstream;
//log:Tstringlist;
so:TSearchOption;
list:Tarray<string>;
F: TextFile;
fcount,i:Nativeint;

begin
try
if trim(txtToSearch)<>'' then
sst:=Tstringstream.Create;
//log:=Tstringlist.Create;

if indir then so:=TSearchOption.soAllDirectories
else
so:=TSearchOption.soTopDirectoryOnly;
fcount:=0;
list:=tdirectory.GetFiles(PathName,FilePatern,so,
function (const path:string;const rec:TSearchRec):Boolean
begin
ctask.CheckCanceled;
result:=True;
inc(fcount);
//sleep(5);
if trim(txtToSearch)<>'' then
 begin
 sst.SetSize(0);
 sst.LoadFromFile(path+'\'+rec.Name);
 if not ContainsStr(sst.DataString, txtToSearch) then
 begin
   result:=False;
   dec(fcount)
 end;
 end;
SendMessage(handle,WM_FILESEARCH_FOUND,ctask.Id,fcount);
end); //filterfunc


// AssignFile(F, 'Task'+inttostr(ctask.id)+'_'+DateTimeToStr(Now)+'.log');
 AssignFile(F, '.\Log\Log_Task'+inttostr(ctask.id)+'.log');
 Rewrite(F);  // default record size is 128 bytes
 Writeln(F,'LogFile for Search PathName '+PathName+' FilePatern '+FilePatern+' txtToSearch '+txtToSearch );
 for i := 0 to High(list) do
  Writeln(F,list[i]);
  CloseFile(F);
except  on EOperationCancelled do  SendMessage(handle,WM_Cancle_Task,ctask.Id,0);
 end;

end //end proc
 , tpool );

result:=ctask.Start;

end;

exports  Offsets,FileSearch,FileSearch2,ReleaseThreadPool;

begin
 tpool := TThreadPool.Create;
end.
