<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\UsuarioModel;
use App\Http\Controllers\ProductoCtrl;
use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\UsuarioCtrl;
use App\Http\Controllers\CarritoController;
use App\Http\Controllers\PedidoController;
use App\Http\Middleware\CorsMiddleware;


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


Route::middleware('auth:api')->delete('/deleteuser/{dni}', [UsuarioCtrl::class, 'deleteUserByDni']);
Route::middleware('auth:api')->post('/carrito/validar-stock', [CarritoController::class, 'validarStock']);
Route::delete('/viewuser/{dni}', function ($dni) {
    UsuarioModel::destroy($dni);
    return response()->json(['mensaje' => 'Usuario eliminado']);
});

Route::put('/updateuser/{dni}', [UsuarioCtrl::class, 'updateUser'])->middleware('auth:api');
Route::post('/insertuser', [UsuarioCtrl::class, 'store'])->middleware('auth:api'); // Asegura que solo usuarios autenticados puedan acceder


Route::middleware('auth:api')->put('/actualizar-usuario', [UsuarioCtrl::class, 'updatePerfil']);

Route::middleware('jwt.auth')->get('/getUser', function (Request $request) {
    return response()->json($request->user());
});

// Productos destacados
Route::get('/productos/mejoresval', [ProductoCtrl::class, 'mejoresValorados']);
Route::get('/productos/proxlanzamientos', [ProductoCtrl::class, 'proximosLanzamientos']);
Route::get('/productos/buscar', [ProductoCtrl::class, 'buscar']);
Route::get('/productos/{id}', [ProductoCtrl::class, 'show']);
Route::get('/productos', [ProductoCtrl::class, 'allShow']);

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


//INTENTO DE CHATBOT
Route::post('/chat', function (Request $request) {
    $mensaje = $request->input('mensaje');
    if (!$mensaje) {
        Log::info('Error en /chat: mensaje vacío', ['ip' => $request->ip()]);
        return response()->json(['error' => 'El mensaje es requerido'], 400);
    }

    // Construimos el prompt para que el modelo genere una respuesta nueva
    $prompt = "Eres un asistente virtual especializado en ayudar a clientes en una tienda online. Responde de forma concisa y no repitas el mensaje del usuario.\n\nUsuario: " . $mensaje . "\nAsistente:";

    // Realiza la solicitud a la API de Hugging Face
    $response = Http::withHeaders([
        'Authorization' => 'Bearer ' . env('HUGGINGFACE_API_KEY'),
        'Content-Type'  => 'application/json',
    ])->post('https://api-inference.huggingface.co/models/microsoft/DialoGPT-medium', [
        'inputs' => $prompt,
    ]);

    if ($response->successful()) {
        $data = $response->json();
        // La estructura de la respuesta suele ser un array con la clave 'generated_text'
        $respuestaIA = isset($data[0]['generated_text']) ? $data[0]['generated_text'] : 'Lo siento, no pude procesar tu mensaje';
        Log::info('Solicitud exitosa en /chat', ['respuesta' => $respuestaIA]);
        return response()->json(['respuesta' => $respuestaIA]);
    } else {
        Log::error('Error en /chat al comunicarse con la API de Hugging Face', [
            'status' => $response->status(),
            'body' => $response->body()
        ]);
        return response()->json(['error' => 'Error al comunicarse con la API de Hugging Face'], $response->status());
    }

 
});


// CARRITO
Route::middleware(['auth:api'])->post('/carrito', [CarritoController::class, 'store']);
Route::middleware('auth:api')->get('/carrito', [CarritoController::class, 'index']);
Route::middleware('auth:api')->post('/carrito/vaciar', [CarritoController::class, 'vaciar']);
Route::middleware('auth:api')->delete('/carrito/{producto_id}', [CarritoController::class, 'destroy']);
Route::middleware('auth:api')->post('/carrito/borrar-stock', [CarritoController::class, 'borrarStock']);


// PEDIDOS 
Route::middleware([CorsMiddleware::class])->post('/crear-pedido', [PedidoController::class, 'crearPedido']);
Route::middleware('auth')->get('/obtener-usuario', [PedidoController::class, 'obtenerUsuario']);
Route::middleware('auth:api')->get('/obtener-pedidos-usuario', [PedidoController::class, 'obtenerPedidosUsuario']);
Route::middleware('auth:api')->get('/obtener-pedidos-todos-usuarios', [PedidoController::class, 'obtenerPedidosTodosUsuarios']);
Route::middleware('auth:api')->get('/pedido-detalles/{id}', [PedidoController::class, 'obtenerDetalles']);
Route::middleware('auth:api')->post('/procesar-pedido/{id}', [PedidoController::class, 'procesar']);
Route::middleware('auth:api')->post('/pedidos/{id}/cancelar', [PedidoController::class, 'cancelarPedido']);

//PRODUCTOS

Route::middleware('auth:api')->get('/productos', [ProductoCtrl::class, 'index']);
Route::get('/categorias', [ProductoCtrl::class, 'categorias']);
Route::get('/plataformas', [ProductoCtrl::class, 'plataformas']);
Route::post('/productos/{id}/actualizar', [ProductoCtrl::class, 'actualizarConImagen']);
Route::post('/productos', [ProductoCtrl::class, 'store']);
Route::delete('/productos/{id}/eliminar', [ProductoCtrl::class, 'destroy']);
Route::delete('/pedidos/historial', [PedidoController::class, 'borrarHistorial']);
