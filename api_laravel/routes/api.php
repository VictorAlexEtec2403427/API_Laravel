<?php
    use Illuminate\Support\Facades\Route;
    use App\Http\Controllers\Api\AuthController;
    use App\Http\Controllers\Api\ProdutoController;

    // 🔓 ROTAS PÚBLICAS (qualquer um pode acessar)
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login',    [AuthController::class, 'login']);

    // 🔒 ROTAS PROTEGIDAS (precisa do "crachá" JWT)
    Route::middleware('auth:api')->group(function () {
        Route::post('/logout',  [AuthController::class, 'logout']);
        Route::post('/refresh', [AuthController::class, 'refresh']);
        Route::get('/me',       [AuthController::class, 'me']);

        Route::apiResource('produtos', ProdutoController::class);
    });
