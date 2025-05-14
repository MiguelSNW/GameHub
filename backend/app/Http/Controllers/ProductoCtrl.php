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

public function catSwitch ()
{
    $productos = ProductosModel::where('plataforma_id', '1')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function catSwitch2 ()
{
    $productos = ProductosModel::where('plataforma_id', '8')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function catPs4 ()
{
    $productos = ProductosModel::where('plataforma_id', '3')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function catPs5 ()
{
    $productos = ProductosModel::where('plataforma_id', '2')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function catXbox ()
{
    $productos = ProductosModel::where('plataforma_id', '4')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function catPc ()
{
    $productos = ProductosModel::where('plataforma_id', '5')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function catComic ()
{
    $productos = ProductosModel::where('categoria_id', '4')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function catMerchan ()
{
    $productos = ProductosModel::where('categoria_id', '3')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function catConsolas ()
{
    $productos = ProductosModel::where('categoria_id', '2')
        ->orderBy('nombre')
        ->get();

    return response()->json($productos);
}

public function allShow()
{
    $productos = ProductosModel::all();
    return response()->json($productos);
}
}