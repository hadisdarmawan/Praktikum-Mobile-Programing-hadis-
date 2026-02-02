// a. Kelas Induk (Contact) [cite: 71]
class Contact {
  String name; // [cite: 72]
  String phone; // [cite: 72]

  // Constructor untuk mengisi properti [cite: 73]
  Contact(this.name, this.phone);

  // Method display() [cite: 74]
String display() {
    return "$name \• $phone";
  }
}

// b. Dua Kelas Turunan (Inheritance) [cite: 75]
// 1. PersonalContact [cite: 76]
class PersonalContact extends Contact {
  DateTime? birthDate; // Properti opsional [cite: 76]

  // Constructor
  PersonalContact(String name, String phone, this.birthDate)
    : super(name, phone); // Memanggil constructor induk

  // Override display() [cite: 77]
  @override
  String display() {
    String dob = "";
    if (birthDate != null) {
      // [cite: 77] (tampilkan DOB hanya jika tidak null)
      // Format YYYY-MM-DD
      String formattedDate = birthDate!.toIso8601String().split('T')[0];
      dob = " \• DOB: $formattedDate";
    }
    // [cite: 77]
    return "[Personal] $name \• $phone$dob";
  }
}

// 2. BusinessContact [cite: 78]
class BusinessContact extends Contact {
  String company; // Properti tambahan [cite: 78]
  // Constructor
  BusinessContact(String name, String phone, this.company)
    : super(name, phone); // Memanggil constructor induk

  // Override display() [cite: 79]
  @override
  String display() {
    return "[Business] $name \• $phone \• $company";
  }
}

// c. Objek & Polymorphism [cite: 80]
void main() {
  List<Contact> contacts = [
    // a) Objek Contact biasa [cite: 83]
    Contact("Andi", "081234567890"),

    // b) Objek PersonalContact (punya birthDate) [cite: 84]
    PersonalContact("Budi", "0856789012", DateTime(1995, 10, 20)),

    // c) Objek BusinessContact (punya company) [cite: 85]
    BusinessContact("PT. Maju Jaya", "024-555666", "Software House"),

    // Contoh PersonalContact tanpa birthDate
    PersonalContact("Citra", "0987654321", null),
  ];

  print("--- Daftar Kontak ---");

  // 3. Setiap kali variabel diisi objek baru, cetak hasil display() [cite: 86]
  for (var contact in contacts) {
    // 4. Tujuan: menunjukkan polymorphism [cite: 87]
    print(contact.display());
  }
}
