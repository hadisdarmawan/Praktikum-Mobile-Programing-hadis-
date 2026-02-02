import 'dart:io';

void main() {
  // Inisialisasi list penjualan
  List<int> penjualan = [5, 12, 8, 20, 3, 15, 7, 10];
  print('Data penjualan awal: $penjualan');

  // 1. Hitung total dan rata-rata dengan FOR
  int totalBuku = 0;
  for (int i = 0; i < penjualan.length; i++) {
    totalBuku += penjualan[i];
  }
  double rataRata = totalBuku / penjualan.length;

  // 2. Cari nilai maksimum dan minimum dengan WHILE
  int maksimum = penjualan[0];
  int minimum = penjualan[0];
  int index = 1;

  while (index < penjualan.length) {
    if (penjualan[index] > maksimum) {
      maksimum = penjualan[index];
    }
    if (penjualan[index] < minimum) {
      minimum = penjualan[index];
    }
    index++;
  }

  // 3. Tambah transaksi dengan DO-WHILE
  String tambahLagi;
  do {
    stdout.write('\nMasukkan jumlah buku terjual (≥0): ');
    int jumlahBaru = int.parse(stdin.readLineSync()!);

    if (jumlahBaru >= 0) {
      penjualan.add(jumlahBaru);
      totalBuku += jumlahBaru; // Update total
      rataRata = totalBuku / penjualan.length; // Update rata-rata

      // Update maksimum dan minimum
      if (jumlahBaru > maksimum) maksimum = jumlahBaru;
      if (jumlahBaru < minimum) minimum = jumlahBaru;
    } else {
      print('Jumlah tidak valid. Harus ≥0.');
    }

    stdout.write('Tambah transaksi lagi? (y/n): ');
    tambahLagi = stdin.readLineSync()!.toLowerCase();
  } while (tambahLagi == 'y');

  // 4. Tampilkan ringkasan
  print('\n=== RINGKASAN PENJUALAN ===');
  print('Jumlah transaksi: ${penjualan.length}');
  print('Total buku terjual: $totalBuku');
  print('Rata-rata per transaksi: ${rataRata.toStringAsFixed(2)}');
  print('Penjualan tertinggi: $maksimum');
  print('Penjualan terendah: $minimum');

  // Tampilkan 3 transaksi terakhir
  int startIndex = penjualan.length - 3;
  if (startIndex < 0) startIndex = 0;
  List<int> tigaTerakhir = penjualan.sublist(startIndex);
  print('3 Transaksi terakhir: $tigaTerakhir');
  print('Data penjualan lengkap: $penjualan');
}
