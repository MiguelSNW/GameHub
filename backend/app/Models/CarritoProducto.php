<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CarritoProducto extends Model
{
    use HasFactory;

    protected $fillable = ['carrito_id', 'producto_id', 'cantidad'];

    // Relación con el carrito
    public function carrito()
    {
        return $this->belongsTo(Carrito::class);
    }

    // Relación con el producto
    public function producto()
    {
        return $this->belongsTo(ProductosModel::class);
    }
}
