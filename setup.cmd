@echo off

>nul 2>&1 net session && goto menu
title.
set n=%0 %*
set n=%n:"=" ^& Chr(34) ^& "%
echo Set objShell = CreateObject("Shell.Application")>"%tmp%\cmdUAC.vbs"
echo objShell.ShellExecute "cmd.exe", "/c start " ^& Chr(34) ^& "." ^& Chr(34) ^& " /d " ^& Chr(34) ^& "%CD%" ^& Chr(34) ^& " cmd /c %n%", "", "runas", ^1>>"%tmp%\cmdUAC.vbs"
cscript "%tmp%\cmdUAC.vbs" //Nologo
del "%tmp%\cmdUAC.vbs"
exit /b


:menu
cls
echo.
echo Escolha uma opcao:
echo.
echo 1. Listar chaves de registro para botoes de atalho do teclado
echo 2. Adicionar chave de registro
echo 3. Remover chave de registro
echo 4. Copiar o Unlocker
echo 5. Remover o Unlocker
echo 6. Sair
echo.
set /p escolha=Digite o numero da opcao desejada:

for %%i in (1 2 3 4 5 6) do (
    if "%escolha%"=="%%i" goto escolha%%i
)

echo Opcao invalida. Tente novamente.
pause
goto menu


:escolha1
cls
echo.
echo Chaves de registro para botoes de atalho do teclado:
echo.
echo 1	Voltar (navegador da Web)
echo 2	Avancar (navegador da Web)
echo 3	Atualizar (navegador da Web)
echo 4	Parar (navegador da Web)
echo 5	Procurar
echo 6	Favoritos (navegador da Web)
echo 7	Pagina inicial da Web (navegador da Web)
echo 8	Silenciar volume
echo 9	Volume baixo
echo 10	Aumentar o volume
echo 11	Proxima faixa (midia)
echo 12	Faixa anterior (midia)
echo 13	Parar (midia)
echo 14	Pausar/Reproduzir (midia)
echo 15	Correspondencia
echo 16	Selecao de midia
echo 17	Este PC ou Meu Computador
echo 18	Calculadora
echo 19	Diminuir graves
echo 20	Aumentar graves
echo.
echo [1 de 3]
pause

cls
echo 21	Graves
echo 22	Diminuir agudos
echo 23	Aumentar agudos
echo 24	Microfone mudo
echo 25	Diminuir volume do microfone
echo 26	Aumentar volume do microfone
echo 27	Ajuda
echo 28	Encontrar
echo 29	Novo
echo 30	Abrir
echo 31	Fechar
echo 32	Salvar
echo 33	Imprimir
echo 34	Desfazer
echo 35	Refazer
echo 36	Copiar
echo 37	Cortar
echo 38	Colar
echo 39	Resposta (e-mail)
echo 40	Encaminhar (correio)
echo.
echo [2 de 3]
pause

cls
echo 41	Enviar (e-mail)
echo 42	Verificacao ortografica
echo 43	Ativar/desativar ditado
echo 44	Ativar/desativar microfone
echo 45	Lista de Correcoes
echo 46	Reproduzir (midia)
echo 47	Pausa (midia)
echo 48	Gravar (midia)
echo 49	Avanco rapido (midia)
echo 50	Retroceder (midia)
echo 51	Subir canal (midia)
echo 52	Descer canal (midia)
echo 53	Excluir
echo 54	Virar 3D
echo.
echo [3 de 3]
pause

goto menu


:escolha2
set /p chave=Digite a chave de registro a ser adicionada: 
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\AppKey\%chave%" /v "ShellExecute" /t REG_SZ /d "\"%USERPROFILE%\Desktop\Unlocker.lnk\"" /f
echo Chave de registro adicionada com sucesso!
pause
goto menu

:escolha3
set /p chave=Digite a chave de registro a ser removida: 
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\AppKey\%chave%" /v "ShellExecute" /t REG_SZ /d "\"%USERPROFILE%\Desktop\Unlocker.lnk\"" /f
echo Chave de registro removida com sucesso!
pause
goto menu

:escolha4
set unlocker=%HOMEDRIVE%\unlocker
if not exist %unlocker% (
	mkdir %unlocker%
	xcopy /Y "%cd%\master-pw-unlocker.py" "%unlocker%"
)
set destino=%unlocker%\hidec.exe
set iniciar_em=%unlocker%
set arquivo_dll=%WINDIR%\System32\imageres.dll
set indice_icone=299

echo $WshShell = New-Object -ComObject WScript.Shell > CopyUnlocker.ps1
echo $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Unlocker.lnk") >> CopyUnlocker.ps1
echo $Shortcut.TargetPath = "%destino%" >> CopyUnlocker.ps1
echo $Shortcut.Arguments = "python master-pw-unlocker.py" >> CopyUnlocker.ps1
echo $Shortcut.WorkingDirectory = "%iniciar_em%" >> CopyUnlocker.ps1
echo $Shortcut.IconLocation = "%arquivo_dll%,%indice_icone%" >> CopyUnlocker.ps1
echo $Shortcut.Save() >> CopyUnlocker.ps1
echo $data = [System.Convert]::FromBase64String('H4sIAAAAAAAEAO1U23KjOBD9oDwYfFvzKIHAyAZbGMTljUsiMGA7sQPGXz8NySSe2tSmZqrmbbsKQdMX9WmdlsufGUIWAiH9MhotEFoL9FMY+j3phnX69Cqm6IIOtpkI7FpSzo38lHa4TWvlkNb6xTTsPKlnTabiItrhLvOnIobHIYprGnITGd6rxqQV/Uxt03PytPMej3tSLZ/NK3XmhXUe7657cn3Xa8stwb6295fwar7ZN3xP8t6+i337OMR/WTlmDoB1EcEIk7L1zE/TBiGtJWvE0n93BJOPNr1F4M+2iXftTchdlLhbPyIHZ/zp/BFwl+Rd38G6+BLGX5S+HvqtF4g6k6Igl/rPkRiwDf14g2F+4Q+2zXdJcUugXwJDvDkF/GrZ65ccdIvtfnrN8K/5mU+bLGBzVZyOse9UYYeHN3Bxn4xnt2R8rcxldkpqp8k63EQFvmWG3mUGL80l7pJx1oW+JGiBJ6FfSWmHjskES+uiFFGtdKbR/8OAl15if5ZnRtUk4rjigZ1HYw/2PdLYqMrIt4TfKZNghxZRXZ0j8E187wHqCmKDd5F7XKmFMlGDLI8D9pb7bn+op0v86jUMnFMynq7uclDodRVOuBT69AyzVMc+YDIGG3IC2iUTc24SiB0rXVrzPcycnI71QwSnIh6unidz33qQbsqLJUagEjjoQlHRpqAy/scq5u3G3jF1xYSubs62hI8uyp7cFyNEc7RkXlGamPX/ULswl660RZW0MEF3Kh5vBGMIH1cYTl8PRrrT9jqHfVi/z1ZVZH16UhFrxXaZydoRz1GBZXU9HegiFqZWiBVpl4xtVSxhraUZK4ZacgvLCz29tevS6X33QVua283L3mtLohu2o7LS0zmPc8xBdjzNCCX5MFZXiZXZwGhcF35bPm4XXOtrNAMUTNhhM+KSFl4siq7PI3k50lmPQ11zlVnFDVoEoV4z8gvIQ3RtJL+eTcCEht495B/4bhSKGB5sEXHPTM0f9B6lIXa/kHZr9npK0H/J784DjpGXVRm55unE0dMDbVLwXyOsJYZyi7wc7mPnHDFcIbnnoGMkE+oCpw+JwbdhfQKOMRSAP3AIeM4Z3OX7KLBv0Bj03GL9EWbBW9ImHPNb2moKIv1+dpP4cp/bglwVY3jtcLpxvPZmFbMyMVq42Vvs+hDTc9KjzSM0jnNb9/ZWt4aaku+uhv/lj+UHcbVREAAIAAA=') >> CopyUnlocker.ps1
echo $ms = New-Object System.IO.MemoryStream >> CopyUnlocker.ps1
echo $ms.Write($data, 0, $data.Length) >> CopyUnlocker.ps1
echo $ms.Seek(0,0) ^| Out-Null >> CopyUnlocker.ps1
echo $sr = New-Object System.IO.StreamReader(New-Object System.IO.Compression.GZipStream($ms, [System.IO.Compression.CompressionMode]::Decompress)) >> CopyUnlocker.ps1
echo $sr.ReadToEnd() ^| Tee-Object -Variable hidec >> CopyUnlocker.ps1
echo [IO.File]::WriteAllBytes("$env:HOMEDRIVE\unlocker\hidec.exe", [Convert]::FromBase64String($hidec)) >> CopyUnlocker.ps1

powershell -ExecutionPolicy Bypass -File CopyUnlocker.ps1
del CopyUnlocker.ps1

cls
echo.
echo Atalho criado com sucesso na Area de Trabalho!
echo Arquivos salvos em: %unlocker%
pause
goto menu

:escolha5
set unlocker="%HOMEDRIVE%\unlocker"
set shortcut="%USERPROFILE%\Desktop\Unlocker.lnk"
if exist %unlocker% (rmdir /s /q %unlocker%)
if exist %shortcut% (del /q %shortcut%)
echo Arquivos do Unlocker removidos com sucesso!
pause
goto menu

:escolha6
exit /b