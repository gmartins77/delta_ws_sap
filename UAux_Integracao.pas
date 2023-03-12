unit UAux_Integracao;

interface

uses inifiles, windows;

function DevolveInformacaoFicheiroini(ficheiro_ini: String; nome_seccao: String;
  campo: String): String;

function GetComputerNameFromWindows: string;

const
  c_accao_log_inicio = 'INICIO';

const
  c_accao_log_fim = 'FIM';

const
  c_accao_log_erro = 'ERRO';

var
  host_name: string;

implementation

{ -----------------------------------------------------------------------------
  Procedimento: DevolveInformacaoFicheiroUpdate
  Autor:      Rui Silva
  Data:       25-Mai-2005
  Argumentos: ficheiro_ini: String;nome_seccao: String;campo: String
  Resultados: String
  Descrição: Devolve o valor co campo passado como parâmetro na variável "campo".
  ----------------------------------------------------------------------------- }
function DevolveInformacaoFicheiroini(ficheiro_ini: String; nome_seccao: String;
  campo: String): String;
var
  MyIniFile: TIniFile;
  pathsource: string;
begin
  try
    try
      MyIniFile := TIniFile.Create(ficheiro_ini);

      // Caminho para a aplicação de update
      result := MyIniFile.ReadString(nome_seccao, campo, '');

    except
      // Application.messagebox(pchar('Não foi possivel efectuar a leitura do ficheiro '+ficheiro_ini),'Atenção',MB_OK + MB_ICONWARNING);
      Raise;
    end;
  finally
    MyIniFile.free;
  end;
end;

function GetComputerNameFromWindows: string;
var
  iLen: Cardinal;
begin
  iLen := MAX_COMPUTERNAME_LENGTH + 1; // From Windows.pas
  result := StringOfChar(#0, iLen);
  GetComputerName(PChar(result), iLen);
  SetLength(result, iLen);
end;

initialization

host_name := GetComputerNameFromWindows;

end.
