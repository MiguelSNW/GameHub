<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class FacturaPedidoMail extends Mailable
{
    use Queueable, SerializesModels;

    public $usuario;
    public $pedido;
    public $pdf;

    public function __construct($usuario, $pedido, $pdf)
    {
        $this->usuario = $usuario;
        $this->pedido = $pedido;
        $this->pdf = $pdf;
    }

    public function build()
    {
        return $this->subject('Factura de su pedido en GameHub')
                    ->markdown('emails.factura')
                    ->attachData($this->pdf->output(), 'factura_pedido.pdf', [
                        'mime' => 'application/pdf',
                    ]);
    }
}
