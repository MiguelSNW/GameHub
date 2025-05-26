<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Pedido Cancelado</title>
</head>
<body>
  <p>Hola {{ $pedido->usuario->nombre }},</p>

  <p>Lamentamos informarte que tu pedido <strong>#{{ $pedido->id }}</strong> ha sido cancelado.</p>

  <p><strong>Motivo:</strong></p>
  <p>{{ $mensaje }}</p>

  <p>Gracias por tu comprensión.</p>
</body>
</html>