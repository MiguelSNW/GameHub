<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pedido extends Model
{
    use HasFactory;

    protected $fillable = ['usuario_dni', 'fecha', 'estado','detalles'];
    public $timestamps = false;  // Desactivar la gestión automática de created_at y updated_at

    // Relación con los productos del pedido
   public function productos()
{
    return $this->belongsToMany(ProductosModel::class, 'pedido_productos', 'pedido_id', 'producto_id')
                ->withPivot('cantidad', 'precio_unitario');  // Asegúrate de que se esté cargando 'precio_unitario' desde la tabla pivote
}

public function usuario()
{
    return $this->belongsTo(UsuarioModel::class, 'usuario_dni', 'dni');
}

}
