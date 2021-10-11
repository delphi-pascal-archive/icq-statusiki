unit mainFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Menus, XPMan, ImgList, ShellApi;

type
  TmainFrm = class(TForm)
    TopPanel: TPanel;
    Image15: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Bevel4: TBevel;
    InfoPanel: TPanel;
    Bevel1: TBevel;
    InfoLabel: TLabel;
    StatusList: TListView;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    StatImgList: TImageList;
    XPManifest1: TXPManifest;
    Image1: TImage;
    Image2: TImage;
    Edit1: TEdit;
    btAbout: TButton;
    btExit: TButton;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure StatusListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btExitClick(Sender: TObject);
    procedure btAboutClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ComboBox1Select(Sender: TObject);
    procedure StatusListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainFrm: TmainFrm;
  StatusArr : array [0..33] of string =
('Злой',
'Водные процедуры',
'Уставший',
'Вечеринка',
'Пиво',
'Думаю',
'Кушаю',
'ТВ',
'Друзья',
'Кофе',
'Музыка',
'Дела',
'Кино',
'Весело',
'Телефон',
'Игры',
'Учёба',
'Покупки',
'Болею',
'Сплю',
'Отрываюсь',
'В инете',
'Инжиниринг',
'Печатаю',
'Барбекю',
'Тетрис',
'Телефон',
'Засыпаю',
'Туалетная бумажка',
'Вопрос',
'Геометрия',
'С Сердцем',
'Гугл',
'Пишу в тетради');
implementation

{$R *.dfm}
Procedure LoadStatus;
var
  i,ps: integer;
  sList: TStringList;
  tmp, tmp1: string;
  itmind: integer;
begin
  MainFrm.StatusList.Clear;
  //
  sList := TStringList.Create;
  sList.LoadFromFile('statusiki.st');
  for i := 0 to sList.Count - 1 do
  begin
    tmp := sList[i];
    tmp1:= copy(tmp,pos('] >> ',tmp)+5,length(tmp));
    delete(tmp,1,1);
    delete(tmp,pos('] >> ',tmp),length(tmp));
    itmind := strtoint(tmp);
    with MainFrm.StatusList.Items.Add do
    begin
      Caption := tmp1;
      ImageIndex := itmind;
    end;
  end;
  sList.Free;
end;

Procedure LoadStatusByIndex(index: integer);
var
  i,ps: integer;
  sList: TStringList;
  tmp, tmp1: string;
  itmind: integer;
begin
  MainFrm.StatusList.Clear;
  //
  sList := TStringList.Create;
  sList.LoadFromFile('statusiki.st');
  for i := 0 to sList.Count - 1 do
  begin
    tmp := sList[i];
    tmp1:= copy(tmp,pos('] >> ',tmp)+5,length(tmp));
    delete(tmp,1,1);
    delete(tmp,pos('] >> ',tmp),length(tmp));
    itmind := strtoint(tmp);
    if index = itmind then
    with MainFrm.StatusList.Items.Add do
    begin
      Caption := tmp1;
      ImageIndex := itmind;
    end;
  end;
  sList.Free;
end;

procedure TmainFrm.FormCreate(Sender: TObject);
var
  i,ps: integer;
  sList: TStringList;
  tmp, tmp1: string;
  itmind: integer;
begin
  StatusList.Clear;
  //
  sList := TStringList.Create;
  sList.LoadFromFile('statusiki.st');
  for i := 0 to sList.Count - 1 do
  begin
    tmp := sList[i];
    tmp1:= copy(tmp,pos('] >> ',tmp)+5,length(tmp));
    delete(tmp,1,1);
    delete(tmp,pos('] >> ',tmp),length(tmp));
    itmind := strtoint(tmp);
    with StatusList.Items.Add do
    begin
      Caption := tmp1;
      ImageIndex := itmind;
    end;
  end;
  sList.Free;
  ComboBox1.ItemIndex := 0;
end;

procedure TmainFrm.StatusListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  T: TOverlay;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  InfoLabel.Caption := Item.Caption;
  Edit1.Text := Item.Caption;
  StatImgList.GetBitmap(Item.ImageIndex,bmp);
  bmp.Transparent := true;
  bmp.TransparentColor := clWhite;
  bmp.TransparentMode := tmAuto;
  bmp.MaskHandle := StatImgList.GetMaskBitmap;
  Image1.Picture.Bitmap := bmp;
  image1.Update;
  bmp.Free;
end;

procedure TmainFrm.btExitClick(Sender: TObject);
begin
Close;
end;

procedure TmainFrm.btAboutClick(Sender: TObject);
begin
MessageDlg('ICQ Statusiki' +#13+
           ' '+#13+
           'Author: BlackCash'+#13+
           'eMail: BlackCash2006@Yandex.ru'+#13+
           ' '+#13 , mtInformation,[mbOk],0);
end;

procedure TmainFrm.Label2Click(Sender: TObject);
Const
  URL : String = 'mailto:BlackCash2006@Yandex.ru';
begin
  ShellExecute(0,'',pChar(URL),NIL,NIL,SW_SHOWNORMAL);
end;

procedure TmainFrm.N1Click(Sender: TObject);
begin
Edit1.SelectAll;
Edit1.CopyToClipboard;
Edit1.ClearSelection;
end;

procedure TmainFrm.ComboBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
 if odSelected in State then
  begin
   ComboBox1.Canvas.Brush.Color:=clActiveCaption;
   ComboBox1.Canvas.Pen.Color:=clActiveCaption;
  end else
   begin
    ComboBox1.Canvas.Brush.Color:=clWhite;
    ComboBox1.Canvas.Pen.Color:=clWhite;
   end;

 if Index = 0 then begin
 ComboBox1.Canvas.Rectangle(Rect);
// StatImgList.Draw(ComboBox1.Canvas,Rect.Left+1,Rect.Top+1,Index-1,True);
 ComboBox1.Canvas.Pen.Color:=clBtnText;
 ComboBox1.Canvas.TextOut(Rect.Left+25,Rect.Top+2,'Отображать все статусы...');
 end else begin
 ComboBox1.Canvas.Rectangle(Rect);
 StatImgList.Draw(ComboBox1.Canvas,Rect.Left+1,Rect.Top+1,Index-1,True);
 ComboBox1.Canvas.Pen.Color:=clBtnText;
 ComboBox1.Canvas.TextOut(Rect.Left+25,Rect.Top+2,StatusArr[index-1]);
 end;
//  Control.Brush.Bitmap := Image1.Picture.Bitmap;     //bk
end;

procedure TmainFrm.ComboBox1Select(Sender: TObject);
begin
if ComboBox1.ItemIndex-1 > -1  then
LoadStatusByIndex(ComboBox1.ItemIndex-1)
else
LoadStatus;
end;

procedure TmainFrm.StatusListChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
//Label1.Caption := inttostr(StatusList.Items.Count);
end;

end.
