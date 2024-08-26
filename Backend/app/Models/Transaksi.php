<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaksi extends Model
{
    use HasFactory;

    /**
     * fillable
     *
     * @var array
     */
    
     protected $fillable = ['typeid', 'paymentid', 'amount', 'title', 'description','date'];

     // Relasi dengan model lain untuk typeid
     public function type()
     {
         return $this->belongsTo(Type_transaksi::class, 'typeid');
     }
 
     // Relasi dengan model lain untuk paymentid
     public function payment()
     {
         return $this->belongsTo(Payment_method::class, 'id');
     }
}
