<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/dashboard', function () {
    return response()->json([
        'usuarios' => 123,
        'ventas' => 456,
        'ingresos' => 7890,
    ]);
});

