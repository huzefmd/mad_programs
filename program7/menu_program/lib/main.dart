import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Program',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems = [
    MenuItem('Pizza', 'Cheesy and delicious!'),
    MenuItem('Burger', 'Juicy and filling!'),
    MenuItem('Pasta', 'Italian classic!'),
    MenuItem('Salad', 'Fresh and healthy!'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('Menu')),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(menuItems[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: menuItems[index]),
                ),
              );
            },
          );
        },
      ),
      
    );
  }
}

class MenuItem {
  final String name;
  final String description;

  MenuItem(this.name, this.description);
}

class DetailScreen extends StatelessWidget {
  final MenuItem item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(item.description, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}



