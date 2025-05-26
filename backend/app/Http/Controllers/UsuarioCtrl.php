<?php

namespace App\Http\Controllers;

use App\Models\UsuarioModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class UsuarioCtrl extends Controller
{
    // Eliminar usuario por DNI
    public function deleteUserByDni($dni)
    {
        $usuario = UsuarioModel::find($dni);

        if ($usuario) {
            $usuario->delete();
            return response()->json(['message' => 'Usuario eliminado correctamente.'], 200);
        }

        return response()->json(['message' => 'Usuario no encontrado.'], 404);
    }

    // Actualizar usuario
   // Actualizar usuario
    public function updateUser(Request $request, $dni)
    {
        if (!Auth::check()) {
            return response()->json(['error' => 'No autorizado'], 401);
        }

        $user = UsuarioModel::find($dni);
        if (!$user) {
            return response()->json(['message' => 'Usuario no encontrado.'], 404);
        }

        $dniOriginal = $user->dni;

        $validator = Validator::make($request->all(), [
            'dni' => [
                'required',
                'string',
                Rule::unique('usuarios')->ignore($dniOriginal, 'dni'),
            ],
            'correo' => [
                'required',
                'email',
                Rule::unique('usuarios')->ignore($dniOriginal, 'dni'),
            ],
            'usuario' => [
                'required',
                'string',
                'max:255',
                Rule::unique('usuarios')->ignore($dniOriginal, 'dni'),
            ],
            'nombre' => 'required|string|max:255',
            'apellidos' => 'required|string|max:255',
            'telefono' => 'required|regex:/^[0-9]{9}$/',
            'tipouser' => 'required|in:admin,usuario',
            'clave' => 'nullable|string|min:8',
        ], [
            'dni.unique' => 'Ya existe un usuario con este DNI.',
            'correo.unique' => 'Ya existe un usuario con este correo.',
            'usuario.unique' => 'Este nombre de usuario ya está en uso.',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Si cambia el DNI, actualizamos pedidos
        if ($request->dni !== $dniOriginal) {
            DB::table('pedidos')
                ->where('usuario_dni', $dniOriginal)
                ->update(['usuario_dni' => $request->dni]);
        }

        if (
    UsuarioModel::whereRaw('LOWER(usuario) = ?', [strtolower($request->usuario)])
        ->where('dni', '!=', $dni)
        ->exists()
) {
    return response()->json([
        'errors' => ['usuario' => ['Este nombre de usuario ya está en uso.']]
    ], 422);
}

        $user->dni = $request->dni;
        $user->usuario = $request->usuario;
        $user->nombre = $request->nombre;
        $user->apellidos = $request->apellidos;
        $user->correo = $request->correo;
        $user->telefono = $request->telefono;
        $user->tipouser = $request->tipouser;

        if ($request->filled('clave')) {
            $user->clave = bcrypt($request->clave);
        }

        $user->save();

        return response()->json([
            'message' => 'Usuario actualizado correctamente',
            'user' => $user
        ]);
    }

   public function store(Request $request)
{
    $validator = Validator::make($request->all(), [
        'dni' => 'required|string|unique:usuarios,dni',
        'correo' => 'required|email|unique:usuarios,correo',
        'usuario' => 'required|string|max:255|unique:usuarios,usuario',
        'nombre' => 'required|string|max:255',
        'apellidos' => 'required|string|max:255',
        'telefono' => 'required|regex:/^[0-9]{9}$/',
        'clave' => 'required|string|min:8',
        'tipouser' => 'required|in:admin,usuario',
    ], [
        // Mensajes personalizados
        'dni.required' => 'El DNI es obligatorio.',
        'dni.unique' => 'Este DNI ya está registrado.',

        'correo.required' => 'El correo es obligatorio.',
        'correo.email' => 'El correo debe ser una dirección válida.',
        'correo.unique' => 'Este correo ya está registrado.',

        'usuario.required' => 'El nombre de usuario es obligatorio.',
        'usuario.unique' => 'Este nombre de usuario ya está en uso.',
        'usuario.max' => 'El nombre de usuario no puede tener más de 255 caracteres.',

        'nombre.required' => 'El nombre es obligatorio.',
        'nombre.max' => 'El nombre no puede tener más de 255 caracteres.',

        'apellidos.required' => 'Los apellidos son obligatorios.',
        'apellidos.max' => 'Los apellidos no pueden tener más de 255 caracteres.',

        'telefono.required' => 'El teléfono es obligatorio.',
        'telefono.regex' => 'El teléfono debe contener 9 dígitos.',

        'clave.required' => 'La contraseña es obligatoria.',
        'clave.min' => 'La contraseña debe tener al menos 8 caracteres.',

        'tipouser.required' => 'El tipo de usuario es obligatorio.',
        'tipouser.in' => 'El tipo de usuario debe ser "admin" o "usuario".',
    ]);

    if ($validator->fails()) {
        return response()->json(['errors' => $validator->errors()], 422);
    }

    $data = $request->all();
    $data['clave'] = bcrypt($data['clave']);

    UsuarioModel::create($data);

    return response()->json(['message' => 'Usuario creado correctamente'], 201);
}


    public function carrito()
    {
        return $this->hasOne(Carrito::class);
    }

  public function updatePerfil(Request $request)
{
    $user = $request->user();

    $validatedData = Validator::make($request->all(), [
        'nombre' => 'nullable|string|max:50',
        'apellidos' => 'nullable|string|max:50',
        'correo' => [
            'nullable',
            'email',
            'max:50',
            Rule::unique('usuarios', 'correo')->ignore($user->dni, 'dni'),
        ],
        'telefono' => 'nullable|numeric',
        'usuario' => [
            'nullable',
            'string',
            'max:100',
            Rule::unique('usuarios', 'usuario')->ignore($user->dni, 'dni'),
        ],
        'clave' => 'nullable|string|min:8',
    ], [
        'correo.unique' => 'El correo ya está registrado.',
        'usuario.unique' => 'El nombre de usuario ya está en uso.',
    ]);

    if ($validatedData->fails()) {
        return response()->json(['errors' => $validatedData->errors()], 422);
    }

    $datos = array_filter($validatedData->validated(), fn($v) => $v !== null && $v !== '');

    // Si viene 'clave', hashearla antes de guardar
    if (isset($datos['clave'])) {
        $datos['clave'] = bcrypt($datos['clave']);
    }

    $user->update($datos);

    return response()->json(['message' => 'Perfil actualizado con éxito.']);
}



}
