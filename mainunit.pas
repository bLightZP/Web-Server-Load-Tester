 unit mainunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wininet, syncobjs;

type
  TMainForm = class(TForm)
    GoButton: TButton;
    LabelThreads: TLabel;
    LabelCounter: TLabel;
    procedure GoButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TLoadTestThread = Class(TThread)
    procedure execute; override;
  public
  end;

var
  MainForm            : TMainForm;
  globalThreadCounter : Integer = 0;

implementation

{$R *.dfm}


var
  csWork : TCriticalSection;

procedure TLoadTestThread.execute;
const
  DLBufSize  = 965536;
type
  DLBufType  = Array[0..DLBufSize-1] of Char;
var
  NetHandle  : HINTERNET;
  URLHandle  : HINTERNET;
  DLBuf      : ^DLBufType;
  BytesRead  : DWord;
  ByteCount  : Integer;
  infoBuffer : Array [0..512] of char;
  bufLen     : DWORD;
  Tmp        : DWord;
  pReferer   : PChar;
  URL        : String;
  Referer    : String;
  fStream    : TMemoryStream;
  Status     : String;
  TimeOut    : DWord;
  B          : Boolean;
begin
  FreeOnTerminate := True;

  fStream := TMemoryStream.Create;
  Referer := '';
  TimeOut := 0;
  URL     := 'http://localhost:8081/v/clubhouse/gallery?code=GLR.000B401F.00009C0B.0332.9C6D';

  NetHandle := InternetOpen('bla bla',INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  If Assigned(NetHandle) then
  Begin
    If TimeOut > 0 then
    Begin
      InternetSetOption(NetHandle,INTERNET_OPTION_CONNECT_TIMEOUT,@TimeOut,Sizeof(TimeOut));
      InternetSetOption(NetHandle,INTERNET_OPTION_SEND_TIMEOUT   ,@TimeOut,Sizeof(TimeOut));
      InternetSetOption(NetHandle,INTERNET_OPTION_RECEIVE_TIMEOUT,@TimeOut,Sizeof(TimeOut));
    End;

    If Referer <> '' then
    Begin
      Referer := 'Referer: '+Referer;
      pReferer := PChar(Referer);
    end
    Else pReferer := nil;

    UrlHandle := InternetOpenUrl(NetHandle,PChar(URL),pReferer,Length(Referer),INTERNET_FLAG_RELOAD,0);
    If Assigned(UrlHandle) then
    Begin
      tmp    := 0;
      bufLen := Length(infoBuffer);
      B      := HttpQueryInfo(UrlHandle,HTTP_QUERY_STATUS_CODE,@infoBuffer[0],bufLen,tmp);
      Status := infoBuffer;

      If (B = True) and (Status = '200') then
      Begin
        New(DLBuf);
        ByteCount := 0;
        Repeat
          ZeroMemory(DLBuf,DLBufSize);
          If InternetReadFile(UrlHandle,DLBuf,DLBufSize,BytesRead) = True then
          Begin
            If BytesRead > 0 then fStream.Write(DLBuf^,BytesRead);
            Inc(ByteCount,BytesRead);
          End
            else
          Begin
          End;
        Until (BytesRead = 0);
        Dispose(DLBuf);
      End;
      InternetCloseHandle(UrlHandle);
    End;
    InternetCloseHandle(NetHandle);
  End;

  fStream.Free;

  csWork.Enter;
  Try
    Dec(globalThreadCounter);
    MainForm.LabelCounter.Caption := IntToStr(globalThreadCounter);
    Application.ProcessMessages;
  Finally
    csWork.Leave;
  End;
end;


procedure TMainForm.GoButtonClick(Sender: TObject);
const
  threadCount : Integer = 100;
var
  I : Integer;
begin
  Inc(globalThreadCounter,threadCount);
  For I := 0 to threadCount-1 do TLoadTestThread.Create(False);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  csWork := TCriticalSection.Create;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  csWork.Free;
end;

end.
