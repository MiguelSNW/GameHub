<?php

namespace App\Http\Controllers;

use App\Models\ProductosModel;
use Illuminate\Http\Request;
use App\Models\Plataforma;
use App\Models\Categoria;
use Illuminate\Support\Facades\Storage;

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

public function index()
{
    return ProductosModel::all();
}

public function categorias()
{
    return response()->json(Categoria::all());
}

public function plataformas()
{
    return response()->json(Plataforma::all());
}

public function actualizarConImagen(Request $request, $id)
{
   $producto = ProductosModel::findOrFail($id);

    if ($request->hasFile('imagen')) {
        $imagen = $request->file('imagen');

        // Obtener nombre limpio
        $nombreLimpio = \Illuminate\Support\Str::slug($producto->nombre);
        $extension = $imagen->getClientOriginalExtension();
        $plataformaNombre = strtolower($producto->plataforma->plataforma); // asegúrate de que relación está cargada

        $nombreArchivo = "{$nombreLimpio}.{$extension}";

        // Ruta absoluta hacia el frontend (ajusta según tu estructura real)
        $rutaFrontend = base_path('../frontend/public/images/caratulas/' . $plataformaNombre);

        // Crear carpeta si no existe
        if (!file_exists($rutaFrontend)) {
            mkdir($rutaFrontend, 0755, true);
        }

        // Mover imagen allí
        $imagen->move($rutaFrontend, $nombreArchivo);

        // Guardar la ruta en BD
        $producto->imagen = "images/caratulas/{$plataformaNombre}/{$nombreArchivo}";
    }

    // Actualizar los demás campos
    $producto->fill($request->except('imagen'))->save();

    return response()->json(['mensaje' => 'Producto actualizado correctamente']);
}
public function store(Request $request)
{
  $request->validate([
    'nombre' => 'required|string|max:100',
    'descripcion' => 'nullable|string',
    'precio' => 'required|numeric',
    'stock' => 'required|integer',
    'fecha_lanz' => 'required|date',
    'valoracion' => 'nullable|numeric',
    'valoruser' => 'nullable|numeric',
    'categoria_id' => 'required|integer',
    'plataforma_id' => 'required|integer',
    'imagen' => 'nullable|image|max:2048'
], [
    'nombre.required' => 'El nombre es obligatorio.',
    'precio.required' => 'El precio es obligatorio.',
    'precio.numeric' => 'El precio debe ser un número.',
    'stock.required' => 'El stock es obligatorio.',
    'stock.integer' => 'El stock debe ser un número entero.',
    'fecha_lanz.required' => 'La fecha de lanzamiento es obligatoria.',
    'fecha_lanz.date' => 'La fecha de lanzamiento debe ser una fecha válida.',
    'categoria_id.required' => 'Debe seleccionar una categoría.',
    'plataforma_id.required' => 'Debe seleccionar una plataforma.',
    'imagen.image' => 'El archivo debe ser una imagen.',
    'imagen.max' => 'La imagen no debe superar los 2 MB.',
]);


    $rutaImagen = null;

    if ($request->hasFile('imagen')) {
        $file = $request->file('imagen');

        // Obtener nombre de la plataforma
        $plataforma = \App\Models\Plataforma::find($request->plataforma_id);
        if (!$plataforma) {
            return response()->json(['error' => 'Plataforma no válida'], 422);
        }

        $nombrePlataforma = strtolower(str_replace(' ', '', $plataforma->plataforma)); // ej. PS4 → ps4
        $nombreArchivo = $file->getClientOriginalName();

        // Ruta relativa donde se guardará en el frontend
        $rutaRelativa = "images/caratulas/{$nombrePlataforma}/{$nombreArchivo}";

        // Ruta absoluta a la carpeta public del FRONTEND
        $rutaDestino = base_path('../frontend/public/' . $rutaRelativa);

        // Asegúrate de que el directorio existe
        $directorio = dirname($rutaDestino);
        if (!file_exists($directorio)) {
            mkdir($directorio, 0777, true);
        }

        // Mover archivo a la carpeta del frontend
        $file->move($directorio, $nombreArchivo);

        $rutaImagen = $rutaRelativa;
    }

    // Crear producto
    $producto = new \App\Models\ProductosModel();
    $producto->fill($request->except('imagen'));
    if ($rutaImagen) {
        $producto->imagen = $rutaImagen;
    }
    $producto->save();

    return response()->json(['mensaje' => 'Producto creado con éxito']);
}

public function destroy($id)
{
    $producto = Producto::findOrFail($id);
    $producto->delete();

    return response()->json(['message' => 'Producto eliminado correctamente']);
}
}