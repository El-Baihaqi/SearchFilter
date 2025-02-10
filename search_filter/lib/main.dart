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
    {"id": 10, "name": "Bintang", "age": 50},
    {"id": 11, "name": "Ardaw", "age": 64},
    {"id": 12, "name": "Glenn", "age": 72},
    {"id": 13, "name": "Hanzo", "age": 81},
    {"id": 14, "name": "Nadila", "age": 92},
    {"id": 15, "name": "Ayew", "age": 45},
    {"id": 16, "name": "Abizar", "age": 32},
    {"id": 17, "name": "Billie", "age": 98},
    {"id": 18, "name": "Fader", "age": 34},
    {"id": 19, "name": "Chevie", "age": 52},
    {"id": 20, "name": "Leclerc", "age": 28},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  RangeValues _selectedAgeRange = const RangeValues(16, 100);

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
    _applyFilters(results);
  }

  void _applyFilters(List<Map<String, dynamic>> filteredUsers) {
    setState(() {
      _foundUsers = filteredUsers
          .where((user) =>
              user["age"] >= _selectedAgeRange.start &&
              user["age"] <= _selectedAgeRange.end)
          .toList();
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
            Text(
                'Filter by Age Range: ${_selectedAgeRange.start.round()} - ${_selectedAgeRange.end.round()}'),
            RangeSlider(
              values: _selectedAgeRange,
              min: 16,
              max: 100,
              divisions: 10,
              labels: RangeLabels(
                _selectedAgeRange.start.round().toString(),
                _selectedAgeRange.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _selectedAgeRange = values;
                  _applyFilters(_allUsers);
                });
              },
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
