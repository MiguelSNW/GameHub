<?php

namespace App\Http\Controllers;

use App\Models\ProductosModel;
use Illuminate\Http\Request;


class ProductoCtrl extends Controller
{
    public function mejoresValorados()
    {
        $productos = ProductosModel::orderBy('valoracion', 'desc')
            ->limit(5)
            ->get();

        return response()->json($productos);
    }

    public function proximosLanzamientos()
    {
        $productos = ProductosModel::where('fecha_lanz', '>', now())
            ->orderBy('fecha_lanz', 'asc')
            ->limit(5)
            ->get();

        return response()->json($productos);
    }

    public function show($id)
{
    $producto = ProductosModel::findOrFail($id);
    return response()->json($producto);
}

public function buscar(Request $request)
{
    $q = $request->query('q');

    $productos = ProductosModel::where('nombre', 'ILIKE', "%$q%")
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}
}