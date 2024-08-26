<?php

namespace App\Http\Controllers\Api;

use App\Models\Event;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\ApiResource;

class EventController extends Controller
{

    /**
     * index
     *
     * @return void
     */
    public function index()
    {
        // Mendapatkan semua transaksi dengan urutan terbaru dan paginasi
        $events = Event::latest()->get();

        // Mengembalikan koleksi transaksi sebagai sumber daya API
        return new ApiResource(true, 'List Data Transaksi', $events);
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
          
            'date'   => 'required',
            'title'   => 'required',
            'time'   => 'required',
    
     
        ]);

        // Memeriksa jika validasi gagal
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Membuat transaksi baru
        $events = Event::create([
            'date'   => $request->date,
            'title'   => $request->title,
            'time'     => $request->time,
            
   
        ]);

        // Mengembalikan respons
        return new ApiResource(true, 'Data Transaksi Berhasil Ditambahkan!', $events);
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
        $events = Event::find($id);

        // Mengembalikan transaksi tunggal sebagai sumber daya API
        return new ApiResource(true, 'Detail Data Transaksi!', $events);
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
        $events = Event::find($id);

        // Memeriksa apakah transaksi ada
        if (!$events) {
            return response()->json(['message' => 'Transaksi tidak ditemukan'], 404);
        }

        // Mendefinisikan aturan validasi
        $validator = Validator::make($request->all(), [
            'date'   => 'required',
            'title'   => 'required',
            'time'   => 'required',
    
     
        ]);

        // Memeriksa jika validasi gagal
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Memperbarui transaksi
        $events->update([
            'date'   => $request->date,
            'title'   => $request->title,
            'time'     => $request->time,
            
          
        ]);

        // Mengembalikan respons
        return new ApiResource(true, 'Data Transaksi Berhasil Diupdate!', $events);
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
        $events = Event::find($id);
        
        // Memeriksa apakah transaksi ada
        if (!$events) {
            return response()->json(['message' => 'Transaksi tidak ditemukan'], 404);
        }

        // Menghapus transaksi
        $events->delete();

        // Mengembalikan respons
        return response()->json(['message' => 'Data Transaksi Berhasil Dihapus!']);
    }
}
