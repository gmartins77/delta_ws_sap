06.03.2017

Passos para criar novo plugin

1. Renomear package
2. Renomear UNIT UinterfaceGestaoPlugin para ser unico
2.1 Renomear Forms utilizados para serem unicos nos plugins ACCEPT
3. Definir lista de janelas (caso haja mais que uma) em UInterfaceGestaoPlugin.DevolveListaJanelas
3.1 - codigos separados por ;
4. Definir permiss�es base na funcao UInterfaceGestaoPlugin.DevolveTemplatePermissoes, tendo em conta se � preciso
definir permiss�es por codigo_janela (ver exemplo em \XML_PERMISSOES\PERMISSOES_EXEMPLO.txt)
5. Preenche UInterfaceGestaoPlugin.DevolveInfoPlugin com a informa��o base do plugin, separando por codigo_janela
se necess�rio. COLOCAR CODIGO DO PLUGIN UNICO NO UNIVERSO ACCEPT
6. Preenche UInterfaceGestaoPlugin.CriaPlugin. Ver exemplo para mais do que uma janela
7. M�todo UInterfaceGestaoPlugin.ActualizaUtilizador fecha janela se n�o tiver acesso de entrada base. Importante
para quando se troca de utilizador com o plugin j� aberto
8. Janelas utilizadas devem ter propriedade publicada Permissoes_activas para poderem
receber as permiss�es do interface
  private
    Fpermissoes_activas: string;
  published
    property Permissoes_activas: string read Fpermissoes_activas
      write Fpermissoes_activas;
