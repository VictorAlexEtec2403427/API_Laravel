@echo off
setlocal EnableDelayedExpansion

:: ================= CONFIGURAÇÕES =================
set CAMINHO_PHP=C:\wamp64\bin\php\php8.2.0
set CAMINHO_MYSQL=C:\wamp64\bin\mysql\mysql8.0.35\bin
set USUARIO_MYSQL=root
set SENHA_MYSQL=
set NOME_PROJETO=aula_1
set NOME_BANCO=Aula1
set URL_COMPOSER=https://getcomposer.org/download/2.9.5/composer.phar
:: ===============================================

:: 1. Adiciona PHP ao PATH do Sistema
echo [1/6] Configurando PHP no PATH...
setx /M PATH "%PATH%;%CAMINHO_PHP%" >nul 2>&1
if %ERRORLEVEL% NEQ 0 echo Aviso: Pode ser necessario executar como Administrador.

:: 2. Adiciona MySQL ao PATH temporariamente (para esta sessão)
echo [2/6] Configurando MySQL...
set PATH=%PATH%;%CAMINHO_MYSQL%

:: 3. Baixa o Composer
echo [3/6] Baixando composer.phar...
powershell -Command "Invoke-WebRequest -Uri '%URL_COMPOSER%' -OutFile 'composer.phar'"
if not exist composer.phar (
    echo Erro: Nao foi possivel baixar o composer.phar
    pause
    exit /b 1
)

:: 4. Cria o projeto Laravel
echo [4/6] Criando projeto Laravel '%NOME_PROJETO%'...
php composer.phar create-project laravel/laravel %NOME_PROJETO%
if %ERRORLEVEL% NEQ 0 (
    echo Erro na criacao do projeto Laravel
    pause
    exit /b 1
)

:: 5. Abre a pasta do projeto
echo [5/6] Abrindo pasta do projeto...
start "" "%~dp0%NOME_PROJETO%"

:: 6. Cria o banco de dados no MySQL
echo [6/6] Criando banco de dados '%NOME_BANCO%'...
if "%SENHA_MYSQL%"=="" (
    mysql -u %USUARIO_MYSQL% -e "CREATE DATABASE IF NOT EXISTS %NOME_BANCO% CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
) else (
    mysql -u %USUARIO_MYSQL% -p%SENHA_MYSQL% -e "CREATE DATABASE IF NOT EXISTS %NOME_BANCO% CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
)
if %ERRORLEVEL% NEQ 0 (
    echo Aviso: Nao foi possivel criar o banco de dados automaticamente.
    echo Crie manualmente com: mysql -u %USUARIO_MYSQL% -p
    echo E execute: CREATE DATABASE %NOME_BANCO%;
)

echo.
echo ================= CONCLUÍDO! =================
echo.
echo Proximos passos:
echo 1. Acesse a pasta: cd %NOME_PROJETO%
echo 2. Configure o arquivo .env com os dados do banco:
echo    DB_DATABASE=%NOME_BANCO%
echo    DB_USERNAME=%USUARIO_MYSQL%
echo    DB_PASSWORD=%SENHA_MYSQL%
echo 3. Execute as migrations: php artisan migrate
echo 4. Inicie o servidor: php artisan serve
echo.
pause