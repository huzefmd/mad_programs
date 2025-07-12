import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(home: LocalFileDemo()));
}

class LocalFileDemo extends StatefulWidget {
  @override
  _LocalFileDemoState createState() => _LocalFileDemoState();
}

class _LocalFileDemoState extends State<LocalFileDemo> {
  final TextEditingController _filenameController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<void> _writeData() async {
    String filename = _filenameController.text.trim();
    String data = _dataController.text;
    if (filename.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Filename cannot be empty")));
      return;
    }
    final file = await _localFile(filename);
    await file.writeAsString(data);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$filename saved")));
  }

  Future<void> _readData() async {
    String filename = _filenameController.text.trim();
    if (filename.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Filename cannot be empty")));
      return;
    }
    try {
      final file = await _localFile(filename);
      String contents = await file.readAsString();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(contents)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error reading file")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Local Data Read/Write')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _filenameController,
              decoration: InputDecoration(
                labelText: "File Name:",
                hintText: "Enter the Filename here",
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _dataController,
              decoration: InputDecoration(
                labelText: "Data",
                hintText: "Enter data here",
              ),
              style: TextStyle(fontSize: 20),
              maxLines: 3,
            ),
            SizedBox(height: 40),
            Row(
              children: [
                ElevatedButton(onPressed: _writeData, child: Text('SAVE')),
                SizedBox(width: 40),
                ElevatedButton(onPressed: _readData, child: Text('READ')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
