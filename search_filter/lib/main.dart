import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Nabil", "age": 17},
    {"id": 2, "name": "Lexi", "age": 35},
    {"id": 3, "name": "Hamdan", "age": 20},
    {"id": 4, "name": "Chesaril", "age": 16},
    {"id": 5, "name": "Githan", "age": 25},
    {"id": 6, "name": "Arfa", "age": 21},
    {"id": 7, "name": "Aby", "age": 100},
    {"id": 8, "name": "Ayman", "age": 24},
    {"id": 9, "name": "Fattah", "age": 42},
    {"id": 10, "name": "Bintang", "age": 19},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  void initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    String trimmedKeyword = enteredKeyword.trim();
    if (trimmedKeyword.isEmpty) {
      results = _allUsers;
    } else {
      int? ageFilter = int.tryParse(trimmedKeyword);
      if (ageFilter != null) {
        results = _allUsers.where((user) => user["age"] == ageFilter).toList();
      } else {
        results = _allUsers
            .where((user) => user["name"]
                .toLowerCase()
                .contains(trimmedKeyword.toLowerCase()))
            .toList();
      }
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search by name or age',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Colors.grey.shade300,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Text(
                      _foundUsers[index]["id"].toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                    title: Text(
                      _foundUsers[index]["name"],
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      '${_foundUsers[index]["age"].toString()} Tahun',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
