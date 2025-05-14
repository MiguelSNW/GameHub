<?php

// app/Http/Middleware/CheckUserRole.php


namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CheckUserRole
{
    public function handle(Request $request, Closure $next, $role)
    {
        // Obtener el usuario autenticado
        $user = $request->user();

        // Verificar si el usuario tiene el rol adecuado
        if ($user && $user->role !== $role) {
            return response()->json(['message' => 'Acceso no autorizado'], 403);
        }

        return $next($request);
    }
}

