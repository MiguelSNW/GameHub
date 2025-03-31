<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\UsuarioModel;

Route::get('/', function () {
    return response()->json([
        'usuarios' => 123,
        'ventas' => 456,
        'ingresos' => 7890,
    ]);
});


Route::get('/viewuser', function () {
    return response()->json(UsuarioModel::all());
});
Route::delete('/eliminarusuario/{dni}', function ($dni) {
    UsuarioModel::destroy($dni);
    return response()->json(['mensaje' => 'Usuario eliminado']);
});

