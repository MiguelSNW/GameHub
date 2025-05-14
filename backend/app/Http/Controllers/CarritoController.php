<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Carrito;
use App\Models\ProductosModel; // o Producto si has renombrado el modelo
use Illuminate\Support\Facades\Auth;
class CarritoController extends Controller
{
   
public function store(Request $request)
{
    $request->validate([
        'producto_id' => 'required|exists:productos,id',
        'cantidad' => 'nullable|integer|min:1'
    ]);

    $usuario = Auth::user();
    $productoId = $request->input('producto_id');
    $cantidad = $request->input('cantidad', 1);

    // Obtener o crear el carrito del usuario
    $carrito = Carrito::firstOrCreate(['usuario_id' => $request->user()->dni]);

    $productoId = $request->input('producto_id');
    $cantidad = $request->input('cantidad', 1);
    
    $productoExistente = $carrito->productos()->where('producto_id', $productoId)->first();
    
    if ($productoExistente) {
        $carrito->productos()->updateExistingPivot($productoId, [
            'cantidad' => $productoExistente->pivot->cantidad + $cantidad,
        ]);
    } else {
        $carrito->productos()->attach($productoId, ['cantidad' => $cantidad]);
    }

    return response()->json(['mensaje' => 'Producto añadido al carrito']);
}

public function index(Request $request)
{
    $usuario = $request->user();

    $carrito = \App\Models\Carrito::where('usuario_id', $usuario->dni)
        ->with('productos')  // Carga los productos relacionados
        ->first();

    if (!$carrito) {
        return response()->json(['productos' => []]); // Carrito vacío
    }

    return response()->json([
        'productos' => $carrito->productos  // Incluye cantidad desde el pivot
    ]);
}
// CarritoController.php
public function destroy($productoId)
{
    $user = auth()->user();

    $carrito = $user->carrito;

    $pivot = $carrito->productos()->where('producto_id', $productoId)->first()->pivot;

    if ($pivot->cantidad > 1) {
        $pivot->cantidad -= 1;
        $pivot->save();
    } else {
        $carrito->productos()->detach($productoId);
    }

    return response()->json(['message' => 'Producto actualizado']);
}

}
