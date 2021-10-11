program ICQStatus_DBG;

uses
  Forms,
  mainFM in 'mainFM.pas' {mainFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ICQ Statusiki';
  Application.CreateForm(TmainFrm, mainFrm);
  Application.Run;
end.
