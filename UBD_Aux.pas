unit UBD_Aux;

interface

uses Uni, z_ws_cent_pal1, SysUtils, z_ws_ac_mat1, Vcl.StdCtrls, UAux_Integracao,
  USysLogs_local;

function GravaOP_Sap(bd: tuniconnection; data_sap: tdate; rec: ZDOLMAORDEMPROD;
  memo: tmemo): string;
function GravaMat_Sap(bd: tuniconnection; rec: ZACCEPTMATERIAL;
  memo: tmemo): string;
function FazLogImportacao(bd: tuniconnection; metodo, host, accao: String;
  memo: tmemo = nil; detail: string = ''; erro: string = ''): string;

implementation

function GravaOP_Sap(bd: tuniconnection; data_sap: tdate; rec: ZDOLMAORDEMPROD;
  memo: tmemo): string;
var
  query: tuniquery;
begin
  query := tuniquery.create(nil);
  try
    try
      query.Connection := bd;
      query.SQL.clear;
      query.SQL.Add(' INSERT INTO [dbo].[SAP_IMPORTACAO_OPS] ');
      query.SQL.Add('            ([DATA_SAP] ');
      query.SQL.Add('            ,[AUFNR] ');
      query.SQL.Add('            ,[AEDAT] ');
      query.SQL.Add('            ,[AEZEIT] ');
      query.SQL.Add('            ,[PLNBEZ] ');
      query.SQL.Add('            ,[EAN11] ');
      query.SQL.Add('            ,[SPRAS] ');
      query.SQL.Add('            ,[CHARG] ');
      query.SQL.Add('            ,[ARBPL] ');
      query.SQL.Add('            ,[GAMNG]) ');
      query.SQL.Add('      VALUES ');
      query.SQL.Add('            (:DATA_SAP ');
      query.SQL.Add('            ,:AUFNR ');
      query.SQL.Add('            ,:AEDAT ');
      query.SQL.Add('            ,:AEZEIT ');
      query.SQL.Add('            ,:PLNBEZ ');
      query.SQL.Add('            ,:EAN11');
      query.SQL.Add('            ,:SPRAS ');
      query.SQL.Add('            ,:CHARG ');
      query.SQL.Add('            ,:ARBPL ');
      query.SQL.Add('            ,:GAMNG) ');
      query.ParamByName('DATA_SAP').AsDate := data_sap;
      query.ParamByName('AUFNR').value := rec.AUFNR;
      query.ParamByName('AEDAT').value := rec.AEDAT;
      query.ParamByName('AEZEIT').value := timetostr(rec.AEZEIT.AsTime);
      query.ParamByName('PLNBEZ').value := rec.PLNBEZ;
      query.ParamByName('EAN11').value := rec.EAN11;
      query.ParamByName('SPRAS').value := rec.SPRAS;
      query.ParamByName('CHARG').value := rec.CHARG;
      query.ParamByName('ARBPL').value := rec.ARBPL;
      query.ParamByName('GAMNG').AsString := rec.GAMNG.DecimalString;
      query.Execute;
      query.close;
    except
      on e: exception do
      begin
        result := e.message;
        FazLogImportacao(bd, 'GravaOP_Sap', host_name, c_accao_log_erro, memo,
          rec.AUFNR, e.message);
      end;

    end;
  finally
    query.free;
  end;

end;

function GravaMat_Sap(bd: tuniconnection; rec: ZACCEPTMATERIAL;
  memo: tmemo): string;
  function removeLeadingZeros(const value: string): string;
  var
    i: Integer;
  begin
    for i := 1 to Length(value) do
      if value[i] <> '0' then
      begin
        result := Copy(value, i, MaxInt);
        exit;
      end;
    result := '';
  end;

var
  query: tuniquery;
begin
  query := tuniquery.create(nil);
  try
    try
      query.Connection := bd;
      query.SQL.clear;
      query.SQL.Add(' UPDATE [dbo].[SAP_IMPORTACAO_MATERIAIS] ');
      query.SQL.Add
        ('            SET MAKTX=:MAKTX, DATA_UPDATE=:DATA_UPDATE WHERE MATNR=:MATNR');
      query.SQL.Add('            IF @@ROWCOUNT=0 ');
      query.SQL.Add('            BEGIN ');

      query.SQL.Add(' INSERT INTO [dbo].[SAP_IMPORTACAO_MATERIAIS] ');
      query.SQL.Add('            ([MATNR] ');
      query.SQL.Add('            ,[MAKTX],DATA_UPDATE) ');
      query.SQL.Add('      VALUES ');
      query.SQL.Add('            (');
      query.SQL.Add('            :MATNR ');
      query.SQL.Add('            ,:MAKTX,:DATA_UPDATE) ');
      query.SQL.Add('            END ');
      query.ParamByName('MATNR').value := removeLeadingZeros(rec.MATNR);
      query.ParamByName('MAKTX').value := rec.MAKTX;
      query.ParamByName('DATA_UPDATE').ASDATETIME := NOW;
      query.Execute;
      query.close;
    except
      on e: exception do
      begin
        result := e.message;
        FazLogImportacao(bd, 'GravaMat_Sap', host_name, c_accao_log_erro, memo,
          rec.MAKTX, e.message);
      end;

    end;
  finally
    query.free;
  end;

end;

function FazLogImportacao(bd: tuniconnection; metodo, host, accao: String;
  memo: tmemo = nil; detail: string = ''; erro: string = ''): string;
var
  query: tuniquery;
begin
  if memo <> nil then
    memo.lines.Add(DateTimeToStr(NOW) + ' ' + metodo + ' ' + accao + ' ' +
      detail + ' ' + erro);
  query := tuniquery.create(nil);
  try
    try
      query.Connection := bd;
      query.close;
      query.SQL.clear;
      query.SQL.Add(' insert into [sap_log_importacao] ');
      query.SQL.Add(' (METODO,HOST,ACCAO,DETAIL,ERRO) ');
      query.SQL.Add(' values(:METODO,:HOST,:ACCAO,:DETAIL,:ERRO) ');
      query.ParamByName('metodo').value := metodo;
      query.ParamByName('host').value := host;
      query.ParamByName('accao').value := accao;
      if trim(detail) <> '' then
        query.ParamByName('detail').value := detail;
      if trim(erro) <> '' then
        query.ParamByName('erro').value := erro;
      query.Execute;
    except
      on e: exception do
      begin
        result := e.message;
      end;

    end;
  finally
    query.free;
  end;
end;

end.
