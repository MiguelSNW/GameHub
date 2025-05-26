<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Factura #{{ $pedido->id }}</title>
  <style>
    body {
      font-family: DejaVu Sans, sans-serif;
      font-size: 12px;
      margin: 0;
      padding: 20px;
    }

    .header {
      text-align: center;
      margin-bottom: 20px;
    }

    .logo {
      max-width: 180px;
      margin-bottom: 10px;
    }

    .info {
      margin-bottom: 30px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    th, td {
      border: 1px solid #aaa;
      padding: 8px;
      text-align: left;
    }

    th {
      background-color: #f0f0f0;
    }

    .right {
      text-align: right;
    }

    .total {
      font-weight: bold;
    }
  </style>
</head>
<body>

<div class="header">
  <img src="{{ public_path('images/logo-gamehub.png') }}" class="logo" alt="GameHub Logo">
  <h2>Factura del Pedido #{{ $pedido->id }}</h2>
</div>

<div class="info">
  <p><strong>Cliente:</strong> {{ $usuario->nombre }} {{ $usuario->apellidos }}</p>
  <p><strong>DNI:</strong> {{ $usuario->dni }}</p>
  <p><strong>Correo:</strong> {{ $usuario->correo }}</p>
  <p><strong>Fecha del pedido:</strong> {{ \Carbon\Carbon::parse($pedido->fecha)->format('d/m/Y') }}</p>
</div>

<table>
  <thead>
    <tr>
      <th>Producto</th>
      <th>Cantidad</th>
      <th>Precio Unitario</th>
      <th>Subtotal</th>
    </tr>
  </thead>
  <tbody>
    @php $subtotal = 0; @endphp
    @foreach($pedido->productos as $producto)
      @php
        $linea = $producto->pivot->cantidad * $producto->pivot->precio_unitario;
        $subtotal += $linea;
      @endphp
      <tr>
        <td>{{ $producto->nombre }}</td>
        <td>{{ $producto->pivot->cantidad }}</td>
        <td>{{ number_format($producto->pivot->precio_unitario, 2) }} €</td>
        <td>{{ number_format($linea, 2) }} €</td>
      </tr>
    @endforeach
  </tbody>
</table>

@php
  $iva = $subtotal * 0.21;
  $total = $subtotal + $iva;
@endphp

<table>
  <tr>
    <td class="right total" colspan="3">Subtotal</td>
    <td class="right">{{ number_format($subtotal, 2) }} €</td>
  </tr>
  <tr>
    <td class="right total" colspan="3">IVA (21%)</td>
    <td class="right">{{ number_format($iva, 2) }} €</td>
  </tr>
  <tr>
    <td class="right total" colspan="3">Total a pagar</td>
    <td class="right">{{ number_format($total, 2) }} €</td>
  </tr>
</table>

<p style="text-align: center; margin-top: 40px;">Gracias por su compra en <strong>GameHub</strong>.</p>

</body>
</html>
