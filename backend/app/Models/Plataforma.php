<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Plataforma extends Model
{
    protected $table = 'plataforma'; // tu tabla no es plural
    protected $primaryKey = 'plataforma_id';
    public $timestamps = false;

    protected $fillable = ['plataforma'];

    public function productos()
    {
        return $this->hasMany(ProductosModel::class, 'plataforma_id');
    }
}
