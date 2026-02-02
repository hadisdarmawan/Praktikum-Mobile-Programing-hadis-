import 'package:flutter/material.dart';
import '../widgets/note_item.dart';
import '../models/note_model.dart';
import '../screens/form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _notes = [
    Note(
      id: '1',
      title: 'Belajar Flutter Navigation',
      content:
          'Implementasi Navigator, push/pop, dan named routes untuk multi-screen app',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Note(
      id: '2',
      title: 'Meeting Proyek Mobile',
      content: 'Review progress aplikasi CatatanKu Pro dengan tim developer',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  void _addNote() async {
    print("Tombol Tambah ditekan"); // Debug

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormScreen()),
    );

    print("Result dari FormScreen: $result"); // Debug

    if (result != null && result is Note) {
      setState(() {
        _notes.insert(0, result);
      });
      _showSnackBar('Catatan ditambahkan: ${result.title}');
    }
  }

  void _editNote(int index) async {
    print("Edit note index: $index"); // Debug

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(initialNote: _notes[index]),
      ),
    );

    print("Edit result: $result"); // Debug

    if (result != null && result is Note) {
      setState(() {
        _notes[index] = result;
      });
      _showSnackBar('Catatan diperbarui: ${result.title}');
    }
  }

  void _deleteNote(int index) {
    final deletedNote = _notes[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Catatan'),
        content: Text('Yakin ingin menghapus "${deletedNote.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _notes.removeAt(index);
              });
              _showSnackBar('Catatan dihapus: ${deletedNote.title}');
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CatatanKu Pro'), centerTitle: true),
      body: _notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada catatan',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const Text(
                    'Tekan tombol + untuk menambahkan',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return NoteItem(
                  note: _notes[index],
                  onEdit: () => _editNote(index),
                  onDelete: () => _deleteNote(index),
                  onTap: () => _editNote(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
