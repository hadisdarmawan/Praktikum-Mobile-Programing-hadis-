import 'dart:io';

void main() {
  print('=== APLIKASI KURIRKITA ===');
  print('Pilihan layanan:');
  print('S - Same Day');
  print('E - Express (1-2 hari)');
  print('R - Reguler (2-4 hari)');
  print('H - Hemat (3-7 hari)');

  stdout.write('Masukkan kode layanan (S/E/R/H): ');
  String kodeLayanan = stdin.readLineSync()!.toUpperCase();

  // Switch case untuk menentukan layanan
  String estimasiHari;
  int biayaTambahan;

  switch (kodeLayanan) {
    case 'S':
      estimasiHari = '1 hari';
      biayaTambahan = 25000;
      break;
    case 'E':
      estimasiHari = '1-2 hari';
      biayaTambahan = 15000;
      break;
    case 'R':
      estimasiHari = '2-4 hari';
      biayaTambahan = 8000;
      break;
    case 'H':
      estimasiHari = '3-7 hari';
      biayaTambahan = 0;
      break;
    default:
      estimasiHari = 'Tidak diketahui';
      biayaTambahan = 0;
  }

  // Tampilkan hasil
  print('\n=== DETAIL LAYANAN ===');
  if (kodeLayanan == 'S' ||
      kodeLayanan == 'E' ||
      kodeLayanan == 'R' ||
      kodeLayanan == 'H') {
    print('Layanan: $kodeLayanan');
    print('Estimasi: $estimasiHari');
    print('Biaya Tambahan: Rp $biayaTambahan');
  } else {
    print('Kode layanan "$kodeLayanan" tidak dikenali.');
    print('Silakan pilih kode yang valid (S, E, R, H)');
  }
}
