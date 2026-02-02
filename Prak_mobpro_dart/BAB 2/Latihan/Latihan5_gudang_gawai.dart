import 'dart:io';	

void main() {
  // Inisialisasi data gudang
  Map<String, Map<String, Object>> gudang = {
    "A01": {"nama": "Earphone", "stok": 12, "harga": 99000},
    "B02": {"nama": "Mouse Wireless", "stok": 8, "harga": 150000},
    "C03": {"nama": "Keyboard Mechanical", "stok": 5, "harga": 450000},
    "D04": {"nama": "Power Bank", "stok": 15, "harga": 120000},
    "E05": {"nama": "Smartwatch", "stok": 3, "harga": 750000},
  };

  bool berjalan = true;

  while (berjalan) {
    print('\n=== APLIKASI GUDANG GADGET ===');
    print('1. Cari barang berdasarkan kode');
    print('2. Update stok barang');
    print('3. Tampilkan barang mahal (>200.000)');
    print('4. Tampilkan semua barang');
    print('5. Keluar');

    stdout.write('Pilih menu (1-5): ');
    String pilihan = stdin.readLineSync()!;

    switch (pilihan) {
      case '1': // Cari barang
        stdout.write('Masukkan kode barang: ');
        String kode = stdin.readLineSync()!;

        if (gudang.containsKey(kode)) {
          var barang = gudang[kode]!;
          print('\n=== DETAIL BARANG ===');
          print('Kode: $kode');
          print('Nama: ${barang["nama"]}');
          print('Stok: ${barang["stok"]}');
          print('Harga: Rp ${barang["harga"]}');
        } else {
          print('Barang dengan kode $kode tidak ditemukan.');
        }
        break;

      case '2': // Update stok
        stdout.write('Masukkan kode barang: ');
        String kode = stdin.readLineSync()!;

        if (gudang.containsKey(kode)) {
          var barang = gudang[kode]!;
          print('Stok saat ini: ${barang["stok"]}');

          stdout.write('Masukkan perubahan stok (bisa negatif): ');
          int perubahan = int.parse(stdin.readLineSync()!);

          int stokBaru = (barang["stok"] as int) + perubahan;

          if (stokBaru >= 0) {
            barang["stok"] = stokBaru;
            print('Stok berhasil diupdate menjadi: $stokBaru');
          } else {
            print('Error: Stok tidak boleh negatif. Update ditolak.');
          }
        } else {
          print('Barang dengan kode $kode tidak ditemukan.');
        }
        break;

      case '3': // Barang mahal
        print('\n=== BARANG MAHAL (Harga > 200.000) ===');
        bool adaBarangMahal = false;

        gudang.forEach((kode, barang) {
          if ((barang["harga"] as int) > 200000) {
            print('$kode: ${barang["nama"]} - Rp ${barang["harga"]}');
            adaBarangMahal = true;
          }
        });

        if (!adaBarangMahal) {
          print('Tidak ada barang dengan harga di atas 200.000');
        }
        break;

      case '4': // Tampilkan semua barang
        print('\n=== SEMUA BARANG DI GUDANG ===');
        print('Kode barang: ${gudang.keys.join(', ')}');
        print('\nDetail Barang:');
        gudang.forEach((kode, barang) {
          print(
            '$kode: ${barang["nama"]} - Stok: ${barang["stok"]} - Rp ${barang["harga"]}',
          );
        });
        break;

      case '5': // Keluar
        berjalan = false;
        print('Terima kasih telah menggunakan aplikasi!');
        break;

      default:
        print('Pilihan tidak valid. Silakan pilih 1-5.');
    }
  }
}
