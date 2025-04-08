<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\UsuarioModel;
use Illuminate\Support\Facades\Hash;

class EncriptarClavesUsuarios extends Command
{
    protected $signature = 'encriptar:claves-usuarios'; // <- nombre del comando que usarás
    protected $description = 'Encripta todas las contraseñas de los usuarios en la base de datos';
    
    public function handle()
    {
        $usuarios = UsuarioModel::all();
    
        foreach ($usuarios as $usuario) {
            // Si no tiene formato Bcrypt (no empieza por $2y$), encriptamos
            if (!str_starts_with($usuario->clave, '$2y$')) {
                $usuario->clave = Hash::make($usuario->clave);
                $usuario->save();
                $this->info("Contraseña encriptada para usuario: {$usuario->correo}");
            }
        }
    
        $this->info('Todas las contraseñas han sido procesadas.');
    }
}
