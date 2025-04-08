<?php
// app/Http/Middleware/VerifyCsrfToken.php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Session\TokenMismatchException;

class VerifyCsrfToken
{
    /**
     * Las rutas que deben estar excluidas de la verificación CSRF.
     *
     * @var array
     */
    protected $except = [
    ];

    /**
     * Maneja una solicitud entrante.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     *
     * @throws \Illuminate\Session\TokenMismatchException
     */
    public function handle(Request $request, Closure $next)
    {
        // Verificar el token CSRF en la solicitud
        if ($this->isReading($request) || $this->shouldPassThrough($request)) {
            return $next($request);
        }

        // Verificar si el token CSRF de la solicitud es válido
        if ($this->tokensMatch($request)) {
            return $next($request);
        }

        throw new TokenMismatchException;
    }

    // Otros métodos de verificación CSRF (isReading, shouldPassThrough, etc.)
}
