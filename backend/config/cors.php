<?php
// config/cors.php
return [
    'paths' => ['*'],  // Permite todas las rutas (especificar 'api/*' si solo quieres las rutas de la API)

    'allowed_methods' => ['*'],  // Permite todos los métodos (GET, POST, PUT, DELETE, etc.)

    'allowed_origins' => ['http://localhost:5173'],  // Permite solicitudes desde tu frontend (Vue.js)

    'allowed_headers' => ['*'],  // Permite todos los encabezados

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => true,  // Permite enviar cookies si es necesario (por ejemplo, para la autenticación de sesión)
];


