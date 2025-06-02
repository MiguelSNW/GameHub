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
  public function login(Request $request)
{
    // Mensajes personalizados
    $mensajes = [
        'correo.required' => 'El campo correo es obligatorio.',
        'correo.email'    => 'El correo debe tener un formato válido.',
        'clave.required'  => 'La contraseña es obligatoria.',
    ];

    // Validación con mensajes personalizados
    $validator = Validator::make($request->all(), [
        'correo' => 'required|email',
        'clave'  => 'required',
    ], $mensajes);

    if ($validator->fails()) {
        return response()->json(['errors' => $validator->errors()], 400);
    }

    $user = UsuarioModel::where('correo', $request->correo)->first();

    if (!$user) {
        return response()->json(['message' => 'Credenciales inválidas. No existe el correo.'], 401);
    }

    if (!Hash::check($request->clave, $user->clave)) {
        return response()->json(['message' => 'Credenciales inválidas. Clave errónea.'], 401);
    }

    $token = JWTAuth::fromUser($user);

    return response()->json([
        'token'    => $token,
        'user'     => $user,
        'userRole' => $user->tipousuario,
    ]);
}

   public function registro(Request $request)
    {
        $validator = Validator::make($request->all(), [
    'dni'       => 'required|string|max:20|unique:usuarios,dni',
    'usuario'   => 'required|string|max:255|unique:usuarios,usuario',
    'nombre'    => 'required|string|max:255',
    'apellidos' => 'required|string|max:255',
    'correo'    => 'required|email|max:255|unique:usuarios,correo',
    'telefono'  => 'required|string|max:20',
    'clave'     => 'required|string|min:6|confirmed',
], [
    'dni.required'       => 'El DNI es obligatorio.',
    'dni.unique'         => 'El DNI ya está registrado.',
    'usuario.required'   => 'El nombre de usuario es obligatorio.',
    'usuario.unique'     => 'El nombre de usuario ya está en uso.',
    'nombre.required'    => 'El nombre es obligatorio.',
    'apellidos.required' => 'Los apellidos son obligatorios.',
    'correo.required'    => 'El correo electrónico es obligatorio.',
    'correo.email'       => 'El correo electrónico debe ser válido.',
    'correo.unique'      => 'El correo electrónico ya está registrado.',
    'telefono.required'  => 'El teléfono es obligatorio.',
    'clave.required'     => 'La contraseña es obligatoria.',
    'clave.min'          => 'La contraseña debe tener al menos :min caracteres.',
    'clave.confirmed'    => 'Las contraseñas no coinciden.',
]);


        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $usuario = UsuarioModel::create([
            'dni'       => $request->dni,
            'usuario'   => $request->usuario,
            'nombre'    => $request->nombre,
            'apellidos' => $request->apellidos,
            'correo'    => $request->correo,
            'telefono'  => $request->telefono,
            'clave'     => bcrypt($request->clave),
            'tipouser'  => 'usuario', // Rol fijo automático
        ]);

        return response()->json([
            'message' => 'Usuario registrado con éxito',
            'user'    => $usuario,
        ], 201);
    }
}
