@echo off
setlocal
cd /d "%~dp0"
echo Iniciando TA Ops em http://localhost:8080
echo Aguarde a mensagem Started TaopsApplication antes de abrir o navegador.
echo Para encerrar, pressione Ctrl+C.
call mvnw.cmd spring-boot:run -Dspring-boot.run.arguments=--server.address=127.0.0.1
if errorlevel 1 (
  echo.
  echo Nao foi possivel iniciar. Copie a mensagem de erro acima.
  pause
)
endlocal
