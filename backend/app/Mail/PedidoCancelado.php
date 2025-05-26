<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class PedidoCancelado extends Mailable
{
    use Queueable, SerializesModels;

   public $pedido;
public $mensaje;

public function __construct($pedido, $mensaje)
{
    $this->pedido = $pedido;
    $this->mensaje = $mensaje;
}

public function build()
{
    return $this->subject('Tu pedido ha sido cancelado')
                ->view('emails.pedido_cancelado');
}

}