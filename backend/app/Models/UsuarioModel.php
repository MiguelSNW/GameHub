<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use App\Models\ProductosModel;
use App\Models\Carrito;
use App\Models\Pedido;
use App\Models\PedidoProducto;

class UsuarioModel extends Authenticatable implements JWTSubject
{
    protected $table = 'usuarios'; // nombre de la tabla en la BD
    protected $primaryKey = 'dni'; // clave primaria personalizada
    public $incrementing = false;  // porque dni no es un número autoincremental
    protected $keyType = 'string'; // tipo de clave primaria

    public $timestamps = false; // si tu tabla no tiene created_at / updated_at

    protected $fillable = [
        'dni',
        'usuario',
        'clave',
        'nombre',
        'apellidos',
        'correo',
        'telefono',
        'tipouser',
    ];
    public function getJWTIdentifier()
    {
        return $this->getKey(); // normalmente el ID
    }

    public function getJWTCustomClaims()
    {
        return []; // puedes añadir claims personalizados si quieres
    }

    // Opcional: renombrar el campo de contraseña
    public function getAuthPassword()
    {
        return $this->clave;
    }
 public function carrito()
{
    return $this->hasOne(Carrito::class, 'usuario_id', 'dni');
}
public function pedidos()
{
    return $this->hasMany(Pedido::class, 'usuario_dni', 'dni');
}

public function productos()
{
    return $this->belongsToMany(ProductosModel::class, 'carrito_producto', 'carrito_id', 'producto_id')
                ->withPivot('cantidad')
                ->withTimestamps();
}
}
