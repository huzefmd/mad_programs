import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'model/note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: NoteListScreen(),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future<void> refreshNotes() async {
    final data = await DatabaseHelper().getNotes();
    setState(() => notes = data);
  }

  Future<void> addOrEditNote({Note? note}) async {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final newNote = Note(
                id: note?.id,
                title: titleController.text,
                content: contentController.text,
              );
              if (note == null) {
                await DatabaseHelper().insertNote(newNote);
              } else {
                await DatabaseHelper().updateNote(newNote);
              }
              Navigator.pop(context);
              refreshNotes();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> deleteNote(int id) async {
    await DatabaseHelper().deleteNote(id);
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQLite Notes')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => addOrEditNote(note: note),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteNote(note.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addOrEditNote(),
        child: Icon(Icons.add),
      ),
    );
  }
}
