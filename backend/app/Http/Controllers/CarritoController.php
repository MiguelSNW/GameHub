<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Carrito;
use App\Models\ProductosModel; // o Producto si has renombrado el modelo
use Illuminate\Support\Facades\Auth;
use App\Models\UsuarioModel;
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

public function vaciar(Request $request)
{
    $usuario = $request->user(); // Asegúrate de usar middleware auth:api o sanctum
    $carrito = $usuario->carrito;

    if (!$carrito) {
        return response()->json(['message' => 'El carrito no existe'], 404);
    }

    // Elimina todos los productos del carrito usando Eloquent
    $carrito->productos()->detach();

    return response()->json(['message' => 'Carrito vaciado correctamente']);
}

public function validarStock(Request $request)
    {
        $productos = $request->input('productos'); // Espera array con [{id, cantidad}, ...]

        $sinStock = [];

        foreach ($productos as $productoPedido) {
            $producto = ProductosModel::find($productoPedido['id']);

            if (!$producto) {
                // Producto no existe, opcionalmente agregar al sinStock o ignorar
                continue;
            }

            if ($producto->stock < $productoPedido['cantidad']) {
                $sinStock[] = [
                    'id' => $producto->id,
                    'nombre' => $producto->nombre,
                    'cantidad' => $productoPedido['cantidad'],
                    'stock_actual' => $producto->stock,
                ];
            }
        }

        if (count($sinStock) > 0) {
            return response()->json([
                'valid' => false,
                'sinStock' => $sinStock,
            ]);
        }

        return response()->json([
            'valid' => true,
        ]);
    }

      public function borrarStock(Request $request)
    {
        $user = Auth::user();

        $productoIds = $request->input('producto_ids'); // Array de productos a eliminar

        if (!is_array($productoIds) || empty($productoIds)) {
            return response()->json([
                'message' => 'No se enviaron productos para eliminar.'
            ], 400);
        }

        // Obtener el carrito del usuario
        $carrito = $user->carrito;

        if (!$carrito) {
            return response()->json([
                'message' => 'El usuario no tiene carrito.'
            ], 404);
        }

        try {
            // Eliminar productos del carrito_producto
            $carrito->productos()->detach($productoIds);

            return response()->json([
                'message' => 'Productos sin stock eliminados del carrito correctamente.'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error al eliminar productos del carrito.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
