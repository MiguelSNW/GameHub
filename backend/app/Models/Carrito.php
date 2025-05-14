<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Carrito extends Model
{
    protected $table = 'carritos';

    protected $primaryKey = 'id';

    protected $fillable = ['usuario_id'];

    public function productos()
    {
        return $this->belongsToMany(ProductosModel::class, 'carrito_producto', 'carrito_id', 'producto_id')
                    ->withPivot('cantidad')
                    ->withTimestamps();
    }

    public function usuario()
    {
        return $this->belongsTo(UsuarioModel::class, 'usuario_id', 'dni'); // clave personalizada
    }
}

