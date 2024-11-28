unit funciones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.DateUtils, System.StrUtils, System.Math;


type
  TJusticado = (tjLeft, tjCenter, tjRight);

type
  TCountryCapital = record
    Country : string;
    Capital : string;
  end;

var
  ListadoNombres : array[0..34] of string = ('Adam', 'Alex', 'Mario', 'Jonathan', 'Carlos', 'Juan', 'David',
                                             'Eduardo', 'Fredi', 'Frank', 'Agustin', 'Mariela', 'Marcos', 'Jose',
                                             'Madeline', 'Elizabet', 'Ruth', 'Elena', 'Enmanuel', 'Wendy', 'Maria',
                                             'Natanael', 'Samuel', 'Pablo', 'Pedro', 'Roger', 'Ivelise', 'Elva',
                                             'Tomas', 'Erika', 'Jorge', 'Victor', 'Walter', 'Paola', 'Betty');

  ListadoApellidos : array[0..125] of string = ('García', 'Rodríguez', 'Martínez', 'Hernández', 'López', 'González', 'Pérez',
                'Sánchez', 'Ramírez', 'Torres', 'Flores', 'Rivera', 'Gómez', 'Díaz',
                'Reyes', 'Morales', 'Cruz', 'Ortiz', 'Gutiérrez', 'Jiménez', 'Mendoza',
                'Romero', 'Castillo', 'Vázquez', 'Ramos', 'Vega', 'Ruiz', 'Castro',
                'Delgado', 'Espinoza', 'Méndez', 'Silva', 'Guzmán', 'Molina', 'Castro',
                'Lozano', 'Alvarez', 'Herrera', 'Marquez', 'Peña', 'Guerrero', 'Rivas',
                'Sosa', 'Navarro', 'Solís', 'Campos', 'Vargas', 'Cervantes', 'Pineda',
                'Aguilar', 'Salazar', 'Quintero', 'Rojas', 'Zamora', 'Cardenas', 'Cortés',
                'Ayala', 'Gallegos', 'Ochoa', 'Rangel', 'Montoya', 'Ortega', 'Rubio',
                'Maldonado', 'Valdez', 'Padilla', 'Serrano', 'Acosta', 'Aguirre', 'Escobar',
                'Salinas', 'Valencia', 'Barrios', 'Carrillo', 'Peñaloza', 'Fuentes',
                'Arroyo', 'Villanueva', 'Montero', 'Barrera', 'Navarrete', 'Salgado',
                'Medina', 'Santos', 'Escalante', 'Nieto', 'Peralta', 'Zarate', 'Bautista',
                'Roldán', 'Santillán', 'Paz', 'Pacheco', 'Cano', 'Bravo', 'Nava', 'Arias',
                'Solano', 'Sierra', 'Godoy', 'Moreno', 'Páez', 'Calderón', 'Castañeda',
                'Villalobos', 'Portillo', 'Lara', 'Márquez', 'Amador', 'Solano', 'Ferrera',
                'Ponce', 'Felipe', 'Luna', 'Collado', 'Duarte', 'Pozo', 'Mejía', 'Varela',
                'Benítez', 'Manzano', 'Suárez', 'Varela', 'Cabrera', 'Santacruz', 'Vallejo');


  function GetRandomFirstName : string;
  function GetRandomLastName : string;
  function GenerateRandomDate(StartDate, EndDate : TDate) : TDate;
  function GenerateRandomEmail : string;
  function GenerateRandomTime(StartTime, EndTime : TTime) : TTime;
  function GenerateRandomPhoneNumber : string;
  function GetCountryAndCapital(Index : Integer) : TCountryCapital;
  function RandomRangeDecimal(Min, Max : Double) : Double;
  function Justifica(Texto : string; Longitud : SmallInt; Rellena : Char; Justificado : TJusticado) : string;



implementation


function GetRandomFirstName : string;
begin
  Result := ListadoNombres[Random(Length(ListadoNombres))];
end;

function GetRandomLastName : string;
begin
  Result := ListadoApellidos[Random(Length(ListadoApellidos))];
end;

function GenerateRandomDate(StartDate, EndDate : TDate) : TDate;
var
  Range : Integer;
begin
  // Calcula la diferencia en d as entre las dos fechas
  Range := DaysBetween(EndDate, StartDate);

  // Genera un n mero aleatorio entre 0 y la diferencia de d as
  Result := IncDay(StartDate, Random(Range + 1));
end;

function GenerateRandomEmail : string;
const
  Providers : array[1..10] of string = (
    'hubspot.com', 'gmail.com', 'protonmail.com', 'icloud.com', 'zohomail.com',
    'outlook.com', 'mailbox.org', 'yahoo.com', 'bluehost.com', 'rackspace.com'
  );
var
  LocalPart, Domain : string;
begin
  // Genera la parte local del correo electr nico
  LocalPart := 'user' + IntToStr(Random(10000));

  // Selecciona un dominio aleatorio de la lista
  Domain := Providers[Random(Length(Providers)) + 1];

  // Devuelve el correo electr nico completo
  Result := LocalPart + '@' + Domain;
end;

function GenerateRandomTime(StartTime, EndTime : TTime) : TTime;
var
  MinutesRange : Integer;
  RandomMinutes : Integer;
begin
  // Calcula la cantidad de minutos entre las dos horas
  MinutesRange := MinutesBetween(EndTime, StartTime);

  // Genera un n mero aleatorio de minutos para a adir a la hora de inicio
  RandomMinutes := Random(MinutesRange + 1);

  // Incrementa la hora de inicio por el n mero aleatorio de minutos
  Result := IncMinute(StartTime, RandomMinutes);
end;

function GenerateRandomPhoneNumber : string;
const
  AreaCodes : array[1..20] of string = (
    '212', '305', '323', '415', '520',  // Algunos codigos de area de EE.UU.
    '809', '829', '849',               // Codigos de area de Republica Dominicana
    '506',                            // Codigo de area de Costa Rica
    '55', '81',                       // Codigos de area de Mexico
    '0212', '0412', '0414',           // Codigos de area de Venezuela
    '011', '351',                     // Codigos de area de Argentina
    '02', '04',                       // Codigos de area de Ecuador
    '57', '44'                        // Codigos de area de Peru y UK (ejemplo diverso)
  );
var
  LocalNumber, AreaCode : string;
begin
  // Selecciona un codigo de  rea aleatorio de la lista
  AreaCode := AreaCodes[Random(Length(AreaCodes)) + 1];

  // Genera una secuencia de 7 d gitos como numero local
  LocalNumber := Format('%.7d', [Random(10000000)]);

  // Devuelve el n mero de tel fono completo
  Result := '(' + AreaCode + ') ' + Copy(LocalNumber, 1, 3) + '-' + Copy(LocalNumber, 4, 4);
end;

function GetCountryAndCapital(Index : Integer) : TCountryCapital;

//DECLARAMOS UN ARRAY DE ACUERDO AL TIPO DEFINIDO Y LO INICIALIZAMOS
const
  CountryData : array[0..19] of TCountryCapital = (
   (Country : 'Venezuela'; Capital : 'Caracas'),
   (Country : 'Argentina'; Capital : 'Buenos Aires'),
   (Country : 'Estados Unidos'; Capital : 'Washington'),
   (Country : 'México'; Capital : 'Ciudad de México'),
   (Country : 'Brasil'; Capital : 'Brasilia'),
   (Country : 'Colombia'; Capital : 'Bogotá'),
   (Country : 'Perú'; Capital : 'Lima'),
   (Country : 'Chile'; Capital : 'Santiago de Chile'),
   (Country : 'Ecuador'; Capital : 'Quito'),
   (Country : 'Uruguay'; Capital : 'Montevideo'),
   (Country : 'Canadá'; Capital : 'Ottawa'),
   (Country : 'Paraguay'; Capital : 'Asunción'),
   (Country : 'Bolivia'; Capital : 'Sucre'),
   (Country : 'Guatemala'; Capital : 'Ciudad de Guatemala'),
   (Country : 'Cuba'; Capital : 'La Habana'),
   (Country : 'España'; Capital : 'Madrid'),
   (Country : 'Portugal'; Capital : 'Lisboa'),
   (Country : 'Francia'; Capital : 'París'),
   (Country : 'Alemania'; Capital : 'Berlín'),
   (Country : 'Italia'; Capital : 'Roma'));

begin
  Result.Country := CountryData[Index].Country;
  Result.Capital := CountryData[Index].Capital;
end;

function RandomRangeDecimal(Min, Max : Double) : Double;
begin
  Result := Min + Random * (Max - Min);
end;

function Justifica(Texto : string; Longitud : SmallInt; Rellena : Char; Justificado : TJusticado) : string;

  function RellenaLinea(Longitud : SmallInt; Rellena : Char) : String;
  begin
    Result := '';
    while Length(Result) < Longitud do
      Result := Result + Rellena;
  end;

var
  LongTexto : SmallInt;
begin
  LongTexto := Length(Texto);
  if  LongTexto  < Longitud then
    begin
      LongTexto := Longitud - LongTexto;
      case Justificado of
        tjLeft   : Texto := Texto + RellenaLinea(LongTexto, Rellena);
        tjRight  : Texto := RellenaLinea(LongTexto, Rellena) + Texto;
        tjCenter : Texto := RellenaLinea((LongTexto - Round(LongTexto/ 2)), Rellena) +
                            Texto + RellenaLinea((Round(LongTexto/ 2)), Rellena);
      end;
    end;
   Result := Texto;
end;


end.
