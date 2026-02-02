import 'dart:io';

void main() {
  // Input data calon penerima beasiswa
  print('=== PROGRAM BEASISWA TALENTA ===');

  stdout.write('Nilai rata-rata: ');
  int nilaiRata2 = int.parse(stdin.readLineSync()!);

  stdout.write('Pendapatan orang tua (rupiah): ');
  int pendapatanOrtu = int.parse(stdin.readLineSync()!);

  stdout.write('Punya prestasi? (true/false): ');
  bool punyaPrestasi = stdin.readLineSync()!.toLowerCase() == 'true';

  String tingkatPrestasi = '';
  if (punyaPrestasi) {
    stdout.write('Tingkat prestasi (kota/provinsi/nasional): ');
    tingkatPrestasi = stdin.readLineSync()!.toLowerCase();
  }

  // Proses seleksi dengan nested if-else
  String status;
  String alasan;

  if (nilaiRata2 >= 85) {
    if (punyaPrestasi &&
        (tingkatPrestasi == 'provinsi' || tingkatPrestasi == 'nasional')) {
      status = "Diterima Penuh";
      alasan =
          "Nilai memenuhi syarat dan memiliki prestasi tingkat $tingkatPrestasi";
    } else if (pendapatanOrtu < 5000000 ||
        (punyaPrestasi && tingkatPrestasi == 'kota')) {
      status = "Diterima Parsial";
      alasan = "Nilai memenuhi syarat dan ";
      if (pendapatanOrtu < 5000000) {
        alasan += "pendapatan orang tua di bawah ambang batas";
      } else {
        alasan += "memiliki prestasi tingkat kota";
      }
    } else {
      status = "Tidak Diterima";
      alasan =
          "Nilai cukup tapi pendapatan di atas ambang & tanpa prestasi yang memadai";
    }
  } else {
    status = "Tidak Diterima";
    alasan = "Nilai rata-rata tidak memenuhi syarat minimum";
  }

  // Tampilkan hasil
  print('\n=== HASIL SELEKSI BEASISWA ===');
  print('Status: $status');
  print('Alasan: $alasan');
  print('Detail Data:');
  print('- Nilai rata-rata: $nilaiRata2');
  print('- Pendapatan orang tua: Rp $pendapatanOrtu');
  print('- Punya prestasi: $punyaPrestasi');
  if (punyaPrestasi) {
    print('- Tingkat prestasi: $tingkatPrestasi');
  }
}
