<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\UsuarioModel;
use App\Http\Controllers\ProductoCtrl;
use App\Http\Controllers\AuthController;

// Dashboard resumen
Route::get('/dashboard', function () {
    return response()->json([
        'usuarios' => 123,
        'ventas' => 456,
        'ingresos' => 7890,
    ]);
});

// Usuarios
Route::get('/viewuser', function () {
    return response()->json(UsuarioModel::all());
});

Route::delete('/viewuser/{dni}', function ($dni) {
    UsuarioModel::destroy($dni);
    return response()->json(['mensaje' => 'Usuario eliminado']);
});

Route::middleware('jwt.auth')->get('/getUser', function (Request $request) {
    return response()->json($request->user());
});

// Productos destacados
Route::get('/productos/mejoresval', [ProductoCtrl::class, 'mejoresValorados']);
Route::get('/productos/proxlanzamientos', [ProductoCtrl::class, 'proximosLanzamientos']);
Route::get('/productos/buscar', [ProductoCtrl::class, 'buscar']);
Route::get('/productos/{id}', [ProductoCtrl::class, 'show']);

// Categorías de productos
Route::get('/productos/categorias/nintendo-switch', [ProductoCtrl::class, 'catSwitch']);
Route::get('/productos/categorias/nintendo-switch2', [ProductoCtrl::class, 'catSwitch2']);
Route::get('/productos/categorias/ps4', [ProductoCtrl::class, 'catPs4']);
Route::get('/productos/categorias/ps5', [ProductoCtrl::class, 'catPs5']);
Route::get('/productos/categorias/xbox', [ProductoCtrl::class, 'catXbox']);
Route::get('/productos/categorias/pc', [ProductoCtrl::class, 'catPc']);
Route::get('/productos/categorias/comic', [ProductoCtrl::class, 'catComic']);
Route::get('/productos/categorias/merchan', [ProductoCtrl::class, 'catMerchan']);
Route::get('/productos/categorias/consolas', [ProductoCtrl::class, 'catConsolas']);

// Login
Route::post('/login', [AuthController::class, 'login'])->name('login');

