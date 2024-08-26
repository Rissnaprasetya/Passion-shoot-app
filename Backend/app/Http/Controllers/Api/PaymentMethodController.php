<?php

namespace App\Http\Controllers\Api;

use App\Models\Payment_method;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Resources\ApiResource;

class PaymentMethodController extends Controller

{
    /**
     * index
     *
     * @return void
     */
    public function index()
    {
        // Mendapatkan semua transaksi dengan urutan terbaru dan paginasi
        $payment_methods = Payment_method::latest()->get();

        // Mengembalikan koleksi transaksi sebagai sumber daya API
        return new ApiResource(true, 'List Data Transaksi', $payment_methods);
    }

    /**
     * store
     *
     * @param  mixed $request
     * @return void
     */
    public function store(Request $request)
    {
        // Mendefinisikan aturan validasi
        $validator = Validator::make($request->all(), [
            'method'     => 'required',
            
        ]);

        // Memeriksa jika validasi gagal
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Membuat transaksi baru
        $payment_methods = Payment_method::create([
            'method'     => $request->method,

        ]);

        // Mengembalikan respons
        return new ApiResource(true, 'Data Transaksi Berhasil Ditambahkan!', $payment_methods);
    }

    /**
     * show
     *
     * @param  mixed $id
     * @return void
     */
    public function show($id)
    {
        // Mencari transaksi berdasarkan ID
        $payment_methods = Payment_method::find($id);

        // Mengembalikan transaksi tunggal sebagai sumber daya API
        return new ApiResource(true, 'Detail Data Transaksi!', $payment_methods);
    }

    /**
     * update
     *
     * @param  mixed $request
     * @param  mixed $id
     * @return void
     */
    public function update(Request $request, $id)
    {
        // Mencari transaksi
        $payment_methods = Payment_method::find($id);

        // Memeriksa apakah transaksi ada
        if (!$payment_methods) {
            return response()->json(['message' => 'Transaksi tidak ditemukan'], 404);
        }

        // Mendefinisikan aturan validasi
        $validator = Validator::make($request->all(), [
            'method'     => 'required',
 
        ]);

        // Memeriksa jika validasi gagal
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Memperbarui transaksi
        $payment_methods->update([
            'method'     => $request->method,

        ]);

        // Mengembalikan respons
        return new ApiResource(true, 'Data Transaksi Berhasil Diupdate!', $payment_methods);
    }

    /**
     * destroy
     *
     * @param  mixed $id
     * @return void
     */
    public function destroy($id)
    {
        // Mencari transaksi
        $payment_methods = Payment_method::find($id);

        // Memeriksa apakah transaksi ada
        if (!$payment_methods) {
            return response()->json(['message' => 'Transaksi tidak ditemukan'], 404);
        }

        // Menghapus transaksi
        $payment_methods->delete();

        // Mengembalikan respons
        return response()->json(['message' => 'Data Transaksi Berhasil Dihapus!']);
    }
}
