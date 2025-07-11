import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ui with all viewa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AllViewsScreen(),
    );
  }
}

// class ALlViewsScreen extends StatefulWidget {
//   const ALlViewsScreen({super.key});

//   @override
//   State<ALlViewsScreen> createState() => _ALlViewsScreenState();
// }

// class _ALlViewsScreenState extends State<ALlViewsScreen> {
//   bool _switchValue = false;
//   bool _checkboxValue = false;
//   bool _sliderValue = 0.5;
//   String _text_field_value = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("All Views Example")),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(" This is a Text Widget", style: TextStyle(fontSize: 18)),
//             SizedBox(height: 16),
//             Image.network('https://surl.li/vcvnrw', width: 100, height: 100),
//             SizedBox(height: 16),
//             ElevatedButton(onPressed: () {}, child: Text("Elevated Button")),
//             SizedBox(height: 16,),
//             TextField(
//               decoration: InputDecoration(labelText: "Enter Text"),

//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


class AllViewsScreen extends StatefulWidget {
  @override
  _AllViewsScreenState createState() => _AllViewsScreenState();
}

class _AllViewsScreenState extends State<AllViewsScreen> {
  bool _switchValue = false;
  bool _checkboxValue = false;
  double _sliderValue = 0.5;
  String _textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Views Example')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This is a Text widget', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Image.network(
              'https://flutter.dev/images/flutter-logo-sharing.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text('Elevated Button')),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Enter text'),
              onChanged: (value) {
                setState(() {
                  _textFieldValue = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text('ListView:', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(5, (index) {
                  return Container(
                    width: 80,
                    margin: EdgeInsets.all(8),
                    color: Colors.blue[100 * (index + 1)],
                    child: Center(child: Text('Item ${index + 1}')),
                  );
                }),
              ),
            ),
            SizedBox(height: 16),
            Text('GridView:', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: 100,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(6, (index) {
                  return Container(
                    color: Colors.green[100 * ((index % 5) + 1)],
                    child: Center(child: Text('Grid ${index + 1}')),
                  );
                }),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Switch:'),
                Switch(
                  value: _switchValue,
                  onChanged: (val) {
                    setState(() {
                      _switchValue = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Checkbox:'),
                Checkbox(
                  value: _checkboxValue,
                  onChanged: (val) {
                    setState(() {
                      _checkboxValue = val ?? false;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Slider:'),
                Expanded(
                  child: Slider(
                    value: _sliderValue,
                    onChanged: (val) {
                      setState(() {
                        _sliderValue = val;
                      });
                    },
                  ),
                ),
                Text('${(_sliderValue * 100).round()}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
