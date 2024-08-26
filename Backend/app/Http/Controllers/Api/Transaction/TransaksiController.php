<?php


namespace App\Http\Controllers\Api\Transaction;

use App\Models\Transaksi;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use App\Http\Resources\ApiResource;

class TransaksiController extends Controller
{
    /**
     * index
     *
     * @return void
     */
    public function index()
    {
        // Mendapatkan semua transaksi dengan urutan terbaru dan paginasi, serta memuat nilai-nilai dari relasi type dan payment
    $transaksis = Transaksi::with('type', 'payment')->get();

    // Mengembalikan koleksi transaksi beserta nilai-nilai dari relasi type dan payment sebagai sumber daya API
    return new ApiResource(true, 'List Data Transaksi', $transaksis);
    }

    /**
     * show
     *
     * @param  mixed $id
     * @return void
     */
    public function show($id)
    {

        // Mendapatkan semua transaksi dengan urutan terbaru dan paginasi, serta memuat nilai-nilai dari relasi type dan payment
        $transaksis = Transaksi::with('type', 'payment')->get();

        // Mengembalikan koleksi transaksi beserta nilai-nilai dari relasi type dan payment sebagai sumber daya API
        return new ApiResource(true, 'List Data Transaksi', $transaksis);
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
            'typeid'   => 'required',
            'paymentid'   => 'required',
            'amount'     => 'required',
            'title'   => 'required',
            'description'   => 'required',
            'date'   => 'required',
     
        ]);

        // Memeriksa jika validasi gagal
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Membuat transaksi baru
        $transaksi = Transaksi::create([
            'typeid'   => $request->typeid,
            'paymentid'   => $request->paymentid,
            'amount'     => $request->amount,
            'title'   => $request->title,
            'description'   => $request->description,
            'date'   => $request->date,
   
        ]);

        // Mengembalikan respons
        return new ApiResource(true, 'Data Transaksi Berhasil Ditambahkan!', $transaksi);
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
        $transaksi = Transaksi::find($id);

        // Memeriksa apakah transaksi ada
        if (!$transaksi) {
            return response()->json(['message' => 'Transaksi tidak ditemukan'], 404);
        }

        // Mendefinisikan aturan validasi
        $validator = Validator::make($request->all(), [
            'typeid'   => 'required',
            'paymentid'   => 'required',
            'amount'     => 'required',
            'title'   => 'required',
            'description'   => 'required',
            'date'   => 'required',
         
        ]);

        // Memeriksa jika validasi gagal
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Memperbarui transaksi
        $transaksi->update([
            'typeid'   => $request->typeid,
            'paymentid'   => $request->paymentid,
            'amount'     => $request->amount,
            'title'   => $request->title,
            'description'   => $request->description,
            'date'   => $request->date,
          
        ]);

        // Mengembalikan respons
        return new ApiResource(true, 'Data Transaksi Berhasil Diupdate!', $transaksi);
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
        $transaksi = Transaksi::find($id);

        // Memeriksa apakah transaksi ada
        if (!$transaksi) {
            return response()->json(['message' => 'Transaksi tidak ditemukan'], 404);
        }

        // Menghapus transaksi
        $transaksi->delete();

        // Mengembalikan respons
        return response()->json(['message' => 'Data Transaksi Berhasil Dihapus!']);
    }
}
