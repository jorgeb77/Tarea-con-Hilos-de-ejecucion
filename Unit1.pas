unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, System.DateUtils, System.UITypes,
  Vcl.Menus, System.ImageList, Vcl.ImgList, System.StrUtils, System.Math,
  Vcl.Samples.Gauges, ShellApi, System.Threading;


type
  TForm1 = class(TForm)
    EdCant: TLabeledEdit;
    Memo1: TMemo;
    Button1: TButton;
    Gauge1: TGauge;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public
    CancelRequested : Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses funciones;

{
  Es crucial llamar a la funcion Randomize en algun punto inicial de tu
  aplicacion para garantizar que la generacion de numeros aleatorios varie
  cada vez que se ejecute tu programa.
}

procedure TForm1.Button1Click(Sender: TObject);
var
  I, Aleatorio, NumRecords : Integer;
  Archivo : TextFile;
  Ruta, Linea : string;
begin
  Memo1.Lines.Clear;
  NumRecords := StrToInt(EdCant.Text);

  Ruta := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  AssignFile(Archivo, Ruta + 'Lista.txt');
  Rewrite(Archivo);

  Gauge1.Progress := 0;
  Gauge1.MaxValue := NumRecords;

  // Escribir la cabecera
  Writeln(Archivo, Justifica('Código', 8, ' ', tjRight) +StringOfChar(' ',3)+
                   Justifica('Nombre', 10, ' ', tjLeft) +' '+
                   Justifica('Apellido', 10, ' ', tjLeft) +' '+
                   Justifica('Email', 30, ' ', tjLeft) +' '+
                   Justifica('Hora', 12, ' ', tjLeft) +StringOfChar(' ',3)+
                   Justifica('Telefono', 15, ' ', tjLeft) +StringOfChar(' ',3)+
                   Justifica('Pais', 15, ' ', tjLeft) +' '+
                   Justifica('Salario', 10, ' ', tjRight) +StringOfChar(' ',5)+
                   Justifica('Fecha Contrato', 15, ' ', tjLeft));

  Randomize;
  for I := 1 to NumRecords do
    begin
      Aleatorio := RandomRange(0, 20); //Aleatorio de 0 a 19

      Linea := Justifica(IntToStr(Random(99999) + 1), 8, ' ', tjRight) +StringOfChar(' ',3)+
               Justifica(GetRandomFirstName, 10, ' ', tjLeft) +' '+
               Justifica(GetRandomLastName, 10, ' ', tjLeft) +' '+
               Justifica(GenerateRandomEmail, 30, ' ', tjLeft) +' '+
               //se genera una hora aleatoria dentro de un horario t pico de trabajo (de 8:00 AM a 5:00 PM).
               // HORA CORTA AM/PM
               Justifica(FormatDateTime('hh:nn:ss am/pm', GenerateRandomTime(EncodeTime(8, 0, 0, 0), EncodeTime(17, 0, 0, 0))), 12, ' ', tjLeft) +StringOfChar(' ',3)+
               // HORA LARGA 24 HORAS
  //               Justifica(FormatDateTime('hh:nn:ss', GenerateRandomTime(EncodeTime(8, 0, 0, 0), EncodeTime(17, 0, 0, 0))), 12, ' ', tjLeft) +StringOfChar(' ',3)+

               Justifica(GenerateRandomPhoneNumber, 15, ' ', tjLeft) +StringOfChar(' ',3)+
               Justifica(GetCountryAndCapital(Aleatorio).Country, 15, ' ', tjLeft) + ' ' +

  //               Justifica(FormatFloat('#,##0.00', Random(100000) + 50000), 10, ' ', tjRight) +' '+
               Justifica(FormatFloat('#,##0.00', RandomRangeDecimal(50000,100000)), 10, ' ', tjRight) +StringOfChar(' ',5)+
               Justifica(FormatDateTime('yyyy/mm/dd', GenerateRandomDate(StartOfTheYear(Now), EndOfTheYear(Now))), 15, ' ', tjLeft);

      Writeln(Archivo, Linea);

      Gauge1.Progress := Gauge1.Progress + 1;
      Gauge1.Refresh;
    end;

  CloseFile(Archivo);

  Memo1.Lines.LoadFromFile(Ruta + 'Lista.txt');

  //ABRIMOS EL ARCHIVO GENERADO
  ShellExecute(Handle,'open','c:\windows\notepad.exe',
  PWideChar(Ruta + 'Lista.txt'), nil, SW_SHOWNORMAL);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  NumRecords : Integer;
  Ruta       : string;
begin
  // Reiniciar el estado de cancelación
  CancelRequested := False;

  NumRecords      := StrToInt(EdCant.Text);
  Ruta            := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  Gauge1.Progress := 0;
  Gauge1.MaxValue := NumRecords;
  Memo1.Lines.Clear;

  // Crear el archivo en un hilo separado usando TTask
  TTask.Run(
    procedure
    var
      I, Aleatorio : Integer;
      Archivo : TextFile;
      Linea   : string;
    begin
      AssignFile(Archivo, Ruta + 'Lista.txt');
      Rewrite(Archivo);

      // Escribir la cabecera del contenido del archivo
      Writeln(Archivo, Justifica('Código', 8, ' ', tjRight) + StringOfChar(' ', 3) +
                      Justifica('Nombre', 10, ' ', tjLeft) + ' ' +
                      Justifica('Apellido', 10, ' ', tjLeft) + ' ' +
                      Justifica('Email', 30, ' ', tjLeft) + ' ' +
                      Justifica('Hora', 12, ' ', tjLeft) + StringOfChar(' ', 3) +
                      Justifica('Telefono', 15, ' ', tjLeft) + StringOfChar(' ', 3) +
                      Justifica('Pais', 15, ' ', tjLeft) + ' ' +
                      Justifica('Salario', 10, ' ', tjRight) + StringOfChar(' ', 5) +
                      Justifica('Fecha Contrato', 15, ' ', tjLeft));

      Randomize;
      for I := 1 to NumRecords do
        begin
          if CancelRequested then
            begin
              CloseFile(Archivo);
              TThread.Queue(nil,
                procedure
                begin
                  Memo1.Lines.Add('Proceso cancelado.');
                end);
              Exit;
            end;

          Aleatorio := RandomRange(0, 20); //Aleatorio de 0 a 19

          Linea := Justifica(IntToStr(Random(99999) + 1), 8, ' ', tjRight) + StringOfChar(' ', 3) +
                   Justifica(GetRandomFirstName, 10, ' ', tjLeft) + ' ' +
                   Justifica(GetRandomLastName, 10, ' ', tjLeft) + ' ' +
                   Justifica(GenerateRandomEmail, 30, ' ', tjLeft) + ' ' +
                   Justifica(FormatDateTime('hh:nn:ss am/pm', GenerateRandomTime(EncodeTime(8, 0, 0, 0), EncodeTime(17, 0, 0, 0))), 12, ' ', tjLeft) + StringOfChar(' ', 3) +
                   Justifica(GenerateRandomPhoneNumber, 15, ' ', tjLeft) + StringOfChar(' ', 3) +
                   Justifica(GetCountryAndCapital(Aleatorio).Country, 15, ' ', tjLeft) + ' ' +
                   Justifica(FormatFloat('#,##0.00', RandomRangeDecimal(50000, 100000)), 10, ' ', tjRight) + StringOfChar(' ', 5) +
                   Justifica(FormatDateTime('yyyy/mm/dd', GenerateRandomDate(StartOfTheYear(Now), EndOfTheYear(Now))), 15, ' ', tjLeft);

          Writeln(Archivo, Linea);

          // Actualizar la barra de progreso en el hilo principal después de cada registro
          TThread.Queue(nil,
            procedure
            begin
              Gauge1.Progress := I;
            end);
        end;

      CloseFile(Archivo);

      // Actualización final al completar el proceso si no se canceló
      if not CancelRequested then
        begin
          TThread.Queue(nil,
            procedure
            begin
//              Gauge1.Progress := Gauge1.MaxValue;
              Memo1.Lines.LoadFromFile(Ruta + 'Lista.txt');

              //ABRIMOS EL ARCHIVO GENERADO
              ShellExecute(Handle,'open','c:\windows\notepad.exe',
              PWideChar(Ruta + 'Lista.txt'), nil, SW_SHOWNORMAL);
            end);
        end;
    end
  );
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  // Solicitar la cancelación del proceso
  CancelRequested := True;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Solicitar la cancelación del proceso si se está ejecutando
  CancelRequested := True;
end;

end.
