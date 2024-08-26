<?php

use Illuminate\Support\Facades\Route;

//semua data transaksi
Route::apiResource('/all_transaksi', App\Http\Controllers\Api\Transaction\TransaksiController::class);
//semua data transaksi
//semua payment method
Route::apiResource('/payment_method', App\Http\Controllers\Api\PaymentMethodController::class);
//semua payment jenis transaksi
Route::apiResource('/type_transaksi', App\Http\Controllers\Api\Type_TransaksiController::class);
//semua event
Route::apiResource('/event', App\Http\Controllers\Api\EventController::class);
