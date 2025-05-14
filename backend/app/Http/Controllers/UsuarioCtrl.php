<?php

namespace App\Http\Controllers;

use App\Models\UsuarioModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class UsuarioCtrl extends Controller
{
    // Método para eliminar un usuario por DNI
    public function deleteUserByDni($dni)
    {
        // Buscar el usuario por su DNI
        $usuario = UsuarioModel::find($dni);

        // Verificar si el usuario existe
        if ($usuario) {
            // Eliminar el usuario
            $usuario->delete();

            // Devolver una respuesta exitosa
            return response()->json(['message' => 'Usuario eliminado correctamente.'], 200);
        }

        // Si el usuario no se encuentra, devolver un error
        return response()->json(['message' => 'Usuario no encontrado.'], 404);
    }

    public function updateUser(Request $request, $dni)
    {
        if (!Auth::check()) {
            return response()->json(['error' => 'No autorizado'], 401);
        }
    
        // Validación de los datos
        $request->validate([
            'usuario' => 'required|string|max:255',
            'nombre' => 'required|string|max:255',
            'apellidos' => 'required|string|max:255',
            'correo' => 'required|email',
            'telefono' => 'required|regex:/^[0-9]{9}$/',
            'nivel' => 'required|numeric|min:0|max:10',
            'tipouser' => 'required|in:admin,usuario',
        ]);
    
        // Buscar el usuario por su DNI
        $user = UsuarioModel::find($dni);
    
        if (!$user) {
            return response()->json(['message' => 'Usuario no encontrado.'], 404);
        }
    
        // Actualizar los datos del usuario
        $user->update([
            'usuario' => $request->usuario,
            'nombre' => $request->nombre,
            'apellidos' => $request->apellidos,
            'correo' => $request->correo,
            'telefono' => $request->telefono,
            'nivel' => $request->nivel,
            'tipouser' => $request->tipouser,
        ]);
    
        // Si la contraseña es proporcionada, actualizarla
        if ($request->has('clave') && !empty($request->clave)) {
            $user->update(['clave' => bcrypt($request->clave)]); // Encriptar la contraseña
        }
    
        return response()->json(['message' => 'Usuario actualizado correctamente', 'user' => $user], 200);
    }

    // Función para insertar el usuario
    public function store(Request $request)
    {
        // Validaciones
        $validator = Validator::make($request->all(), [
            'dni' => 'required|unique:usuarios,dni',
            'nombre' => 'required',
            'apellidos' => 'required',
            'usuario' => 'required',
            'correo' => 'required|email',
            'telefono' => 'required|regex:/^[0-9]{9}$/', // Asegurarse de que el teléfono tenga 9 dígitos
            'nivel' => 'required|numeric|min:0|max:10',
            'tipouser' => 'required',
            'clave' => 'required|string|min:8', // Validación de contraseña mínima
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422); // Error en la validación
        }

        // Crear el nuevo usuario
        $user = UsuarioModel::create([
            'dni' => $request->dni,
            'nombre' => $request->nombre,
            'apellidos' => $request->apellidos,
            'usuario' => $request->usuario,
            'correo' => $request->correo,
            'telefono' => $request->telefono,
            'nivel' => $request->nivel,
            'tipouser' => $request->tipouser,
            'clave' => bcrypt($request->clave), // Encriptar la contraseña antes de guardarla
        ]);

        // Retornar la respuesta de éxito
        return response()->json(['message' => 'Usuario creado correctamente', 'user' => $user], 201);
    }
    public function carrito()
{
    return $this->hasOne(Carrito::class);
}
}
