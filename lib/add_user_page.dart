import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  final Function(String, String) onUserAdded;

  AddUserPage({required this.onUserAdded});

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(labelText: 'Job'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Panggil fungsi onUserAdded dengan data yang diisi pengguna
                widget.onUserAdded(_nameController.text, _jobController.text);
                // Kosongkan input setelah menambahkan pengguna
                _nameController.clear();
                _jobController.clear();
                // Kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
