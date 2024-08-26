import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/custom_appbar.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomAppBar(
          title: 'Tentang Aplikasi',
          action: [
            ImageIcon(
              AssetImage('lib/assets/images/logo_trans.png'),
              size: 50,
              color: Colors.white,
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Passion Shoot',
                      style: primaryTextStyle.copyWith(fontSize: 18),
                    ),
                  ),
                  const Text(
                    '''
Passion Shoots adalah jasa fotografi yang bergerak dalam bidang yang sanat luas yang dimana bukan sekadar jasa fotografi biasa. Passion Shoots adalah profesional fotografer yang mengabadikan momen spesial dan penuh makna dalam hidup Anda. Bagi kami, setiap cerita unik layak diabadikan melalui foto yang indah dan berkesan.
Layanan Passion Shoots :
* Pemotretan keluarga: pernikahan, ulang tahun, liburan
* Pemotretan pribadi: potret unik dan kreatif
* Pemotretan acara: wisuda, konser, konferensi
* Pemotretan produk: promosi produk dengan foto menarik
* Pemotretan Olahraga : Basket, Futsal, Sepakbola dll
Keunggulan Passion Shoots:
* Berpengalaman: keahlian di berbagai pemotretan
* Peralatan terbaik: foto berkualitas tinggi
* Teknik terbaru: hasil maksimal dan kekinian
* Harga terjangkau: paket sesuai kebutuhan
* Layanan lengkap: pencetakan, album, desain grafis
* Pengalaman menyenangkan: proses pemotretan yang nyaman dan berkesan
Passion Shoots adalah pilihan tepat untuk mengabadikan momen spesial Anda. Hubungi kami untuk informasi lebih lanjut dan dapatkan penawaran menarik!
                    ''',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
