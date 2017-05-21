unit frm_TestBlurMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TfrmTestBlurMain }

  TfrmTestBlurMain = class(TForm)
    btnUp: TButton;
    btnDown: TButton;
    Button3: TButton;
    imgBackground: TImage;
    Image2: TImage;
    pnlForeground: TPanel;
    Panel2: TPanel;
    Shape1: TShape;
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    extraImage: TImage;
    panelImage: TImage;
    procedure Draw;
  end;

var
  frmTestBlurMain: TfrmTestBlurMain;

implementation

{$DEFINE DRAW_WITH_WINDOWS}

{$IFDEF DRAW_WITH_WINDOWS}
uses Windows, Win32Extra;

{$ENDIF}

{$R *.lfm}

{ TfrmTestBlurMain }

procedure TfrmTestBlurMain.FormCreate(Sender: TObject);
{$IFDEF DRAW_WITH_WINDOWS}
var
  Style: LONG;
{$ENDIF}
begin
  frmTestBlurMain.DoubleBuffered := True;
  pnlForeground.DoubleBuffered := True;

  // This can only be used in Windows
  {$IFDEF DRAW_WITH_WINDOWS}
  pnlForeground.Color := clBlack;
  Style := GetWindowLong(pnlForeground.Handle, GWL_EXSTYLE);
  SetWindowLong(pnlForeground.Handle, GWL_EXSTYLE, Style or WS_EX_LAYERED);
  Win32Extra.SetLayeredWindowAttributes(pnlForeground.Handle, clBlack, 130, LWA_ALPHA);
  {$ENDIF}

  pnlForeground.Top := Height;
  pnlForeground.Left := 0;
  pnlForeground.Width := Width;
  pnlForeground.Height := trunc(Height * 0.8);

  {$IFNDEF DRAW_WITH_WINDOWS}
  panelImage := TImage.Create(pnlForeground);
  panelImage.Parent := pnlForeground;
  panelImage.Align := alClient;
  panelImage.SendToBack;
  panelImage.Stretch := imgBackground.Stretch;
  panelImage.Picture.Bitmap.Assign(imgBackground.Picture.Bitmap);
  //panelImage.Height := pnlForeground.Height;
  //panelImage.Width := pnlForeground.Width;
  panelImage.Visible := True;
  {$ENDIF}

end;

procedure TfrmTestBlurMain.Draw;
var
  RS, RD: TRect;
begin
  panelImage.Canvas.Lock;
  try
    RS := Classes.Rect(pnlForeground.Left, pnlForeground.Top, pnlForeground.Left +
      pnlForeground.Width, pnlForeground.Top + pnlForeground.Height);
    RD := Classes.Rect(0, 0, pnlForeground.Width, pnlForeground.Height);
    panelImage.Canvas.CopyRect(RD, imgBackground.Canvas, RS);
  finally
    panelImage.Canvas.Unlock;
  end;
end;

procedure TfrmTestBlurMain.btnUpClick(Sender: TObject);
begin
  while pnlForeground.Top + pnlForeground.Height > Height do
  begin
    {$IFNDEF DRAW_WITH_WINDOWS}
    pnlForeground.Top := pnlForeground.Top - 2;
    Draw;
    {$ELSE}
    pnlForeground.Top := pnlForeground.Top - 1;
    Sleep(1);
    {$ENDIF}
    Application.ProcessMessages;
  end;
  SysUtils.beep;
end;

procedure TfrmTestBlurMain.btnDownClick(Sender: TObject);
begin
  while pnlForeground.Top < Height do
  begin
    {$IFNDEF DRAW_WITH_WINDOWS}
    pnlForeground.Top := pnlForeground.Top + 2;
    Draw;
    {$ELSE}
    pnlForeground.Top := pnlForeground.Top + 1;
    Sleep(1);
    {$ENDIF}
    Application.ProcessMessages;
  end;
  SysUtils.beep;
end;

procedure TfrmTestBlurMain.Button3Click(Sender: TObject);
begin
  MessageDlg('Info','You pressed button 3',mtInformation,[mbOK],'');
end;

end.
