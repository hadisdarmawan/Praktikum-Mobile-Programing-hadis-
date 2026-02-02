import 'package:flutter/material.dart';
import 'db_helper.dart'; // Import helper yang sudah dibuat

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: NoteApp()));
}

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  // Variabel untuk menampung data notes dari database
  List<Map<String, dynamic>> _notes = [];
  bool _isLoading = true;

  // Fungsi untuk mengambil data dari database (Refresh Data)
  void _refreshNotes() async {
    final data = await DatabaseHelper.instance.readAllNotes();
    setState(() {
      _notes = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes(); // Load data saat aplikasi dibuka
  }

  // Form Controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // Fungsi untuk menampilkan Form Tambah/Edit
  void _showForm(int? id) async {
    // Jika id tidak null, berarti mode Edit, isi form dengan data lama
    if (id != null) {
      final existingNote = _notes.firstWhere((element) => element['id'] == id);
      _titleController.text = existingNote['title'];
      _contentController.text = existingNote['content'];
    } else {
      // Kosongkan form jika mode Tambah
      _titleController.text = '';
      _contentController.text = '';
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Judul Catatan'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(hintText: 'Isi Catatan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  // Logika Tambah Data (Create)
                  await DatabaseHelper.instance.create({
                    'title': _titleController.text,
                    'content': _contentController.text,
                    'created_at': DateTime.now().toString(),
                  });
                } else {
                  // Logika Update Data (Update)
                  await DatabaseHelper.instance.update({
                    'id': id,
                    'title': _titleController.text,
                    'content': _contentController.text,
                    'created_at': DateTime.now().toString(),
                  });
                }
                // Kosongkan controller dan refresh list
                _titleController.clear();
                _contentController.clear();
                Navigator.of(context).pop();
                _refreshNotes();
              },
              child: Text(id == null ? 'Simpan Baru' : 'Update Catatan'),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menghapus data
  void _deleteItem(int id) async {
    await DatabaseHelper.instance.delete(id);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Catatan berhasil dihapus!')));
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Note App'), // Sesuai instruksi
      ),
      // Menampilkan daftar catatan menggunakan ListView
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) => Card(
                color: const Color.fromARGB(255, 240, 240, 240),
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(
                    _notes[index]['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_notes[index]['content']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        // Tombol Edit
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showForm(_notes[index]['id']),
                        ),
                        // Tombol Hapus
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_notes[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      // Tombol Tambah Catatan
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
