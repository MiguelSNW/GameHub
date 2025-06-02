<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductosModel extends Model
{
    protected $table = 'productos';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'nombre',
        'descripcion',
        'precio',
        'categoria_id',
        'stock',
        'fecha_lanz',
        'valoracion',
        'imagen',
        'plataforma_id',
        'valoruser',
    ];

    // Relaciones

    public function categoria()
    {
        return $this->belongsTo(Categoria::class, 'categoria_id');
    }

    public function plataforma()
    {
        return $this->belongsTo(Plataforma::class, 'plataforma_id');
    }
    public function carritos()
    {
        return $this->belongsToMany(Carrito::class, 'carrito_producto')
            ->withPivot('cantidad')
            ->withTimestamps();
    }
  public function plataformas()
{
    return Plataforma::select('plataforma_id', 'nombre')->get();
}
}
