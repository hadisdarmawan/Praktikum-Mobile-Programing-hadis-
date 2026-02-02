import 'dart:io';

void main() {
  print('=== SISTEM TIKET SERULAND ===');

  // Input data pengunjung
  stdout.write('Masukkan usia: ');
  int usia = int.parse(stdin.readLineSync()!);

  stdout.write('Apakah akhir pekan? (true/false): ');
  bool isAkhirPekan = stdin.readLineSync()!.toLowerCase() == 'true';

  stdout.write('Punya MemberCard? (true/false): ');
  bool punyaMemberCard = stdin.readLineSync()!.toLowerCase() == 'true';

  // Harga dasar per kategori
  double hargaDasar;
  String kategori;

  // Nested if untuk menentukan kategori harga
  if (usia < 6) {
    kategori = "Gratis";
    hargaDasar = 0.0;
  } else {
    if (usia >= 6 && usia <= 17) {
      kategori = "Pelajar";
      hargaDasar = 50000.0;
    } else {
      if (usia >= 18 && usia <= 60) {
        kategori = "Dewasa";
        hargaDasar = 75000.0;
      } else {
        kategori = "Lansia";
        hargaDasar = 40000.0; // Diskon khusus lansia
      }
    }
  }

  double hargaSetelahAkhirPekan = hargaDasar;
  double diskonMember = 0.0;
  double totalAkhir = hargaDasar;

  // Terapkan kenaikan akhir pekan (kecuali gratis)
  if (isAkhirPekan && kategori != "Gratis") {
    hargaSetelahAkhirPekan = hargaDasar * 1.20;
  }

  // Terapkan diskon member (kecuali gratis)
  if (punyaMemberCard && kategori != "Gratis") {
    diskonMember = hargaSetelahAkhirPekan * 0.10;
    totalAkhir = hargaSetelahAkhirPekan - diskonMember;
  } else {
    totalAkhir = hargaSetelahAkhirPekan;
  }

  // Terapkan minimum charge (kecuali gratis)
  if (totalAkhir < 30000 && totalAkhir > 0) {
    totalAkhir = 30000.0;
  }

  // Tampilkan rincian
  print('\n=== RINCIAN TIKET ===');
  print('Kategori: $kategori');
  print('Harga dasar: Rp ${hargaDasar.toStringAsFixed(0)}');

  if (isAkhirPekan && kategori != "Gratis") {
    print(
      'Harga setelah akhir pekan (+20%): Rp ${hargaSetelahAkhirPekan.toStringAsFixed(0)}',
    );
  }

  if (punyaMemberCard && kategori != "Gratis") {
    print('Diskon member (10%): Rp ${diskonMember.toStringAsFixed(0)}');
  }

  if (totalAkhir == 30000 && kategori != "Gratis") {
    print('Minimum charge diterapkan: Rp 30.000');
  }

  print('TOTAL AKHIR: Rp ${totalAkhir.toStringAsFixed(0)}');
}
