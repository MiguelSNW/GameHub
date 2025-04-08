<?php
// app/Http/Controllers/AuthController.php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UsuarioModel;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    // Método para iniciar sesión
    public function login(Request $request)
    {
        // Validar la entrada (correo y contraseña)
        $validator = Validator::make($request->all(), [
            'correo' => 'required|email',  // Validar que el correo esté presente y sea válido
            'clave' => 'required',         // Validar que la contraseña esté presente
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        // Buscar el usuario por correo electrónico
        $user = UsuarioModel::where('correo', $request->correo)->first();

        // Si el usuario no existe, devolver un error
        if (!$user) {
            return response()->json(['message' => 'Credenciales inválidas'], 401);
        }

        // Verificar si la contraseña coincide (usando el Hash de Laravel)
        if (!Hash::check($request->clave, $user->clave)) {
            return response()->json(['message' => 'Credenciales inválidas'], 401);
        }

        // Generar el token JWT para el usuario autenticado
        $token = JWTAuth::fromUser($user);

        // Devolver el token y la información del usuario
        return response()->json([
            'token' => $token,
            'user' => $user,
            'userRole' => $user->tipousuario,
        ]);
    }
}
