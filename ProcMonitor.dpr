library ProcMonitor;

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
  System.SysUtils,Winapi.Windows,Winapi.Messages,
  System.Classes,System.Generics.Collections,system.Threading;

{$R *.res}

const
wm_terminated=WM_User+5;


function RunAndMonitore(handle:thandle;comline:string):Cardinal;export;
var
ProcessInfo: TProcessInformation;
StartupInfo: TStartupInfo;
CreateOK:boolean;

begin

FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
  FillChar(ProcessInfo, SizeOf(TProcessInformation), 0);
  StartupInfo.cb := SizeOf(TStartupInfo);
   CreateOK := CreateProcess(
    nil,                   // lpApplicationName: Use command line
    PChar(comLine),    // lpCommandLine: Path to executable and arguments
    nil,                   // lpProcessAttributes: Default security
    nil,                   // lpThreadAttributes: Default security
    False,                 // bInheritHandles: Don't inherit handles
    0,                     // dwCreationFlags: No special flags
    nil,                   // lpEnvironment: Use parent's environment
    nil,                   // lpCurrentDirectory: Use parent's current directory
    StartupInfo,           // lpStartupInfo: Startup information
    ProcessInfo            // lpProcessInformation: Process information
  );
if  CreateOK then
begin

result:= ProcessInfo.dwProcessId;


//{TTask.run(procedure
TThread.CreateAnonymousThread(procedure
var
procresult:Cardinal;

begin
procresult:=0;
 repeat
  //GetExitCodeProcess(List.Items[i].hProcess,procresult);
  GetExitCodeProcess(ProcessInfo.hProcess,procresult);
   sleep(2000);
until procresult <> Still_Active;
sendmessage(handle,wm_terminated,ProcessInfo.dwProcessId,procresult);
end).Start;

end
else
result:=0;

end;

exports  RunAndMonitore;




begin
end.
