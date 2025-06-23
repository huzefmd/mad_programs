import 'package:contentprovider/secound_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> openDialer() async {
    const url = 'tel:7619497909';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not  Launch $url';
    }
  }

  Future<void> openBrowser() async {
    const url = "http://flutter.dev";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could Not Launch $url';
    }
  }

  Future<void> requestContactPermision() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status.isGranted) {
      print("Contact permision granted");
    } else {
      print("Permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Program 4 Intent demo")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SecoundPage()),
              );
            },
            child: Text("1. Explicit Intent -> Navigate "),
          ),

          SizedBox(height: 16),

          ElevatedButton(
            onPressed: openDialer,
            child: Text('2.Implicit Intent -> Call'),
          ),
          SizedBox(height: 16),

          ElevatedButton(
            onPressed: openBrowser,
            child: Text('3. Implicit Intent -> Open Browser'),
          ),

          SizedBox(height: 16),

          ElevatedButton(
            onPressed: requestContactPermision,
            child: Text('4. Contetent Provider -> Access Contacts '),
          ),
        ],
      ),
    );
  }
}
