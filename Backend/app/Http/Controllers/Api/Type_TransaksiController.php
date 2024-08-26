<?php

namespace App\Http\Controllers\Api;

use App\Models\Type_transaksi;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\ApiResource;

class Type_TransaksiController extends Controller

    {
        /**
         * index
         *
         * @return void
         */
        public function index()
        {
            // Mendapatkan semua transaksi dengan urutan terbaru dan paginasi
            $type_transaksis = Type_transaksi::latest()->paginate(5);
    
            // Mengembalikan koleksi transaksi sebagai sumber daya API
            return new ApiResource(true, 'List Data Transaksi', $type_transaksis);
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
                'type_transaksi'     => 'required',
                
            ]);
    
            // Memeriksa jika validasi gagal
            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }
    
            // Membuat transaksi baru
            $type_transaksis = Type_transaksi::create([
                'type_transaksi'     => $request->type_transaksi,
    
            ]);
    
            // Mengembalikan respons
            return new ApiResource(true, 'Data Transaksi Berhasil Ditambahkan!', $type_transaksis);
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
            $type_transaksis = Type_transaksi::find($id);
    
            // Mengembalikan transaksi tunggal sebagai sumber daya API
            return new ApiResource(true, 'Detail Data Transaksi!', $type_transaksis);
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
            $type_transaksis = Type_transaksi::find($id);
    
            // Memeriksa apakah transaksi ada
            if (!$type_transaksis) {
                return response()->json(['message' => 'Transaksi tidak ditemukan'], 404);
            }
    
            // Mendefinisikan aturan validasi
            $validator = Validator::make($request->all(), [
                'type_transaksi'     => 'required',
     
            ]);
    
            // Memeriksa jika validasi gagal
            if ($validator->fails()) {
                return response()->json($validator->errors(), 422);
            }
    
            // Memperbarui transaksi
            $type_transaksis->update([
                'type_transaksi'     => $request->type_transaksi,
    
            ]);
    
            // Mengembalikan respons
            return new ApiResource(true, 'Data Transaksi Berhasil Diupdate!', $type_transaksis);
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
            $type_transaksis = Type_transaksi::find($id);
    
            // Memeriksa apakah transaksi ada
            if (!$type_transaksis) {
                return response()->json(['message' => 'Transaksi tidak ditemukan'], 404);
            }
    
            // Menghapus transaksi
            $type_transaksis->delete();
    
            // Mengembalikan respons
            return response()->json(['message' => 'Data Transaksi Berhasil Dihapus!']);
        }
}
