<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Produto extends Model
{
    // Permite que estes campos sejam preenchidos via $request->all()
    protected $fillable = [
        'nome',
        'descricao',
        'preco',
        'quantidade',
    ];
}
