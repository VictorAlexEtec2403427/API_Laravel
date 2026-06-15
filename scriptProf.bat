@echo off
:: Configurar o caminho do PHP (ALTERE ESTE CAMINHO)
set CAMINHO_PHP=C:\wamp64\bin\php\php8.3.14

:: Adiciona ao PATH do Sistema (/M significa Machine/Sistema)
echo Adicionando %CAMINHO_PHP% ao PATH...
setx /M PATH "%PATH%;%CAMINHO_PHP%"

echo.
echo Concluido!
echo.
:: Passo de validação mencionado no PDF
echo Para validar, abra um novo CMD e digite: php -v
pause