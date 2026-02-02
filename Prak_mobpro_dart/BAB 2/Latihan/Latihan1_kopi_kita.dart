import 'dart:io';

void main() {
  // Const untuk harga menu dan pajak
  const double hargaEspresso = 25000;
  const double hargaLatte = 30000;
  const double hargaTeh = 15000;
  const double pajak = 0.10;
  // Final untuk timestamp
  final DateTime waktuCetak = DateTime.now();
  // Input jumlah gelas untuk setiap menu
  print('=== Kafe Kopi Kita ===');
  stdout.write('Jumlah gelas Espresso: ');
  int jumlahEspresso = int.parse(stdin.readLineSync()!);

  stdout.write('Jumlah gelas Latte: ');
  int jumlahLatte = int.parse(stdin.readLineSync()!);
  stdout.write('Jumlah gelas Teh: ');
  int jumlahTeh = int.parse(stdin.readLineSync()!);

  // Hitung subtotal
  double subtotal =
      (jumlahEspresso * hargaEspresso) +
      (jumlahLatte * hargaLatte) +
      (jumlahTeh * hargaTeh);

  // Hitung pajak dan total
  double jumlahPajak = subtotal * pajak;
  double totalAkhir = subtotal + jumlahPajak;

  // Tampilkan ringkasan
  print('\n=== STRUK PEMBAYARAN ===');
  print('Espresso: $jumlahEspresso x Rp $hargaEspresso');
  print('Latte: $jumlahLatte x Rp $hargaLatte');
  print('Teh: $jumlahTeh x Rp $hargaTeh');
  print('Subtotal: Rp ${subtotal.toStringAsFixed(2)}');
  print('Pajak (10%): Rp ${jumlahPajak.toStringAsFixed(2)}');
  print('Total: Rp ${totalAkhir.toStringAsFixed(2)}');
  print('Waktu Cetak: $waktuCetak');
  print('========================');
}
