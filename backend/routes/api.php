<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\UsuarioModel;
use App\Http\Controllers\ProductoCtrl;

Route::get('/', function () {
    return response()->json([
        'usuarios' => 123,
        'ventas' => 456,
        'ingresos' => 7890,
    ]);
});


//VISTA USUARIOS
Route::get('/viewuser', function () {
    return response()->json(UsuarioModel::all());
});
Route::delete('/eliminarusuario/{dni}', function ($dni) {
    UsuarioModel::destroy($dni);
    return response()->json(['mensaje' => 'Usuario eliminado']);
});


//PRODUCTOS
Route::get('/productos/mejoresval', [ProductoCtrl::class, 'mejoresValorados']);
Route::get('/productos/proxlanzamientos', [ProductoCtrl::class, 'proximosLanzamientos']);
Route::get('/productos/buscar', [ProductoCtrl::class, 'buscar']);
Route::get('/productos/{id}', [ProductoCtrl::class, 'show']);

