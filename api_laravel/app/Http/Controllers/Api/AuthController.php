<?php
namespace App\Http\Controllers\Api;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    // Registrar novo usuário
    public function register(Request $request)
    {
        $request->validate([
            'name'     => 'required|string|max:100',
            'email'    => 'required|email|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = User::create([
            'name'     => $request->name,
            'email'    => $request->email,
            'password' => Hash::make($request->password),
        ]);

        return response()->json([
            'message' => 'Usuário criado com sucesso',
            'user'    => $user
        ], 201);
    }

    // Login → gera o token (o "crachá")
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (!$token = JWTAuth::attempt($credentials)) {
            return response()->json(['message' => 'E-mail ou senha inválidos'], 401);
        }

        return $this->respondWithToken($token);
    }

    // Dados do usuário autenticado
    public function me()
    {
        return response()->json(auth('api')->user());
    }

    // Logout → invalida o token
    public function logout(){
        auth('api')->logout();
        return response()->json(['message' => 'Logout realizado com sucesso']);
    }

    // Refresh → gera um novo token (renova o crachá)
    public function refresh()
    {
        return $this->respondWithToken(auth('api')->refresh());
    }

    // Helper: padroniza a resposta do token
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type'   => 'bearer',
            'expires_in'   => auth('api')->factory()->getTTL() * 60
        ]);
    }
}
