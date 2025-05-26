<?php

namespace App\Http\Controllers;

use App\Models\Pedido;
use App\Models\PedidoProducto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Mail\FacturaPedidoMail;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Mail;
use App\Mail\PedidoCancelado;
use App\Models\UsuarioModel;

class PedidoController extends Controller
{
    // Este método se llama cuando PayPal confirma el pago
 public function crearPedido(Request $request)
    {
        $request->validate([
            'productos' => 'required|array',
            'usuario_dni' => 'required|string',
            'payment_details' => 'required|array',
        ]);

        $pedido = Pedido::create([
            'usuario_dni' => $request->usuario_dni,
            'fecha' => now(),
            'estado' => 'Pendiente de Confirmación',
        ]);

        $productosAgrupados = [];

        foreach ($request->productos as $producto) {
            if (isset($productosAgrupados[$producto['id']])) {
                $productosAgrupados[$producto['id']]['cantidad'] += $producto['cantidad'];
            } else {
                $productosAgrupados[$producto['id']] = [
                    'id' => $producto['id'],
                    'cantidad' => $producto['cantidad'],
                    'precio' => $producto['precio'],
                ];
            }
        }

        foreach ($productosAgrupados as $producto) {
            PedidoProducto::create([
                'pedido_id' => $pedido->id,
                'producto_id' => $producto['id'],
                'cantidad' => $producto['cantidad'],
                'precio_unitario' => $producto['precio'],
            ]);
        }

        // 🔥 Vaciar el carrito del usuario con Eloquent
        $usuario = UsuarioModel::with('carrito.productos')->where('dni', $request->usuario_dni)->first();
        if ($usuario && $usuario->carrito) {
            $usuario->carrito->productos()->detach();  // Limpia tabla carrito_producto
        }

        return response()->json([
            'status' => 'pedido_creado',
            'pedido_id' => $pedido->id
        ]);
    }

public function obtenerPedidosUsuario()
{
    if (!Auth::check()) {
        return response()->json(['message' => 'Unauthenticated.'], 401);
    }

    // Obtener los pedidos del usuario logueado
    $pedidos = Pedido::with('productos')
                     ->where('usuario_dni', Auth::user()->dni)
                     ->get();

    return response()->json($pedidos);
}

public function obtenerPedidosTodosUsuarios()
{
    try {
        // Obtener todos los pedidos con la relación de usuario (nombre, apellidos, etc.)
        $pedidos = Pedido::with('usuario')->get();

        return response()->json($pedidos);
    } catch (\Exception $e) {
        \Log::error('Error al obtener pedidos: ' . $e->getMessage());
        return response()->json(['error' => 'Error al obtener los pedidos.'], 500);
    }
}


public function obtenerDetalles($id)
{
    try {
        \Log::info('Buscando pedido con ID:', [$id]);

        $pedido = Pedido::with('productos')->find($id);

        if (!$pedido) {
            \Log::warning("Pedido con ID $id no encontrado.");
            return response()->json(['error' => 'Pedido no encontrado'], 404);
        }

        \Log::info('Pedido cargado correctamente:', ['pedido' => $pedido]);

        return response()->json($pedido);
    } catch (\Exception $e) {
        \Log::error('Error en obtenerDetalles: ' . $e->getMessage());
        return response()->json(['error' => 'Error interno del servidor'], 500);
    }
}

public function procesar($id)
{
    $pedido = Pedido::with('productos', 'usuario')->findOrFail($id);

    if ($pedido->estado !== 'Pendiente de Confirmación') {
        return response()->json(['error' => 'El pedido ya está procesado o no es válido.'], 400);
    }

    // ✅ Verificar stock antes de procesar
    foreach ($pedido->productos as $producto) {
        if ($producto->stock < $producto->pivot->cantidad) {
            return response()->json([
                'error' => 'Uno o más productos no tienen stock suficiente.',
                'producto' => $producto->nombre
            ], 400);
        }
    }

    // ✅ Restar stock de cada producto
    foreach ($pedido->productos as $producto) {
        $producto->stock -= $producto->pivot->cantidad;
        $producto->save();
    }

    // ✅ Generar el PDF de la factura
    $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadView('pdf.factura', [
        'pedido' => $pedido,
        'usuario' => $pedido->usuario,
    ]);

    // ✅ Enviar el correo con la factura
    \Illuminate\Support\Facades\Mail::to($pedido->usuario->correo)
        ->send(new \App\Mail\FacturaPedidoMail($pedido->usuario, $pedido, $pdf));

    // ✅ Cambiar el estado del pedido
    $pedido->estado = 'Confirmado';
    $pedido->save();

    return response()->json(['message' => 'Pedido procesado correctamente.']);
}

// Método para cancelar un pedido
public function cancelarPedido(Request $request, $id)
{
    $request->validate([
        'mensaje' => 'required|string|max:1000'
    ]);

    $pedido = Pedido::findOrFail($id);
    $usuario = $pedido->usuario;

    // Actualizar estado y guardar mensaje en detalles
    $pedido->estado = 'Cancelado';
    $pedido->detalles = $request->mensaje;
    $pedido->save();

    // Enviar correo al usuario
    Mail::to($usuario->correo)->send(new PedidoCancelado($pedido, $request->mensaje));

    return response()->json(['mensaje' => 'Pedido cancelado, mensaje guardado y notificación enviada.']);
}

public function borrarHistorial()
{
    try {
        Pedido::whereIn('estado', ['Cancelado', 'Confirmado'])->delete();

        return response()->json(['message' => 'Historial eliminado correctamente.']);
    } catch (\Exception $e) {
        return response()->json(['error' => 'Error al eliminar el historial.'], 500);
    }
}

}
