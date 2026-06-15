@echo off
:: =====================================================
:: Script de Configuração: PHP + Git + Repositório
:: =====================================================

:: Configurar o caminho do PHP (ALTERE ESTE CAMINHO)
set CAMINHO_PHP=C:\wamp64\bin\php\php8.3.14

:: Adiciona ao PATH do Sistema (/M significa Machine/Sistema)
echo [1/4] Adicionando %CAMINHO_PHP% ao PATH...
setx /M PATH "%PATH%;%CAMINHO_PHP%"
if %errorlevel% neq 0 (
    echo.
    echo [ERRO] Falha ao atualizar o PATH. Execute como Administrador.
    pause
    exit /b 1
)

:: Configurações do Git (PERSONALIZE ESTES VALORES)
echo.
echo [2/4] Configurando Git...
git config --global user.name "VictorAlexEtec2403427"
git config --global user.email "victor.gouveia@aluno.cps.sp.gov.br"

if %errorlevel% neq 0 (
    echo.
    echo [ERRO] Falha ao configurar o Git. Verifique se o Git esta instalado.
    pause
    exit /b 1
)

:: Clonar repositório (ALTERE O USUÁRIO E CAMINHO SE NECESSÁRIO)
echo.
echo [3/4] Clonando repositorio...
git clone https://github.com/<usuariogit>/aula1-crud-laravel.git
if %errorlevel% neq 0 (
    echo.
    echo [ERRO] Falha ao clonar o repositorio. Verifique a URL e sua conexao com a internet.
    pause
    exit /b 1
)

:: Conclusão
echo.
echo [4/4] Concluido!
echo.
echo Para validar:
echo   - Abra um NOVO CMD e digite: php -v
echo   - Para verificar o Git: git --version
echo   - O projeto foi clonado na pasta: aula1-crud-laravel
echo.
pause