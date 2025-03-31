<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UsuarioModel extends Model
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
        'nivel',
        'tipouser',
    ];
}
