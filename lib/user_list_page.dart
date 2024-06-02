import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_details_page.dart';
import 'add_user_page.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> addUser(String name, String job) async {
    final String apiUrl = 'https://reqres.in/api/users';
    Map<String, dynamic> data = {
      'name': name,
      'job': job,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      fetchUsers(); // Memuat ulang daftar pengguna setelah menambahkan pengguna baru
    } else {
      throw Exception('Failed to add user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]['email']),
            onTap: () {
              // Tampilkan detail pengguna jika di-tap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(userId: users[index]['id']),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tampilkan halaman untuk menambahkan pengguna baru saat tombol FAB ditekan
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserPage(
                onUserAdded: (name, job) {
                  addUser(name, job); // Panggil fungsi untuk menambahkan pengguna baru
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
