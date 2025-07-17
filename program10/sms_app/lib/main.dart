import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(SmsApp());
}

class SmsApp extends StatefulWidget {
  @override
  _SmsAppState createState() => _SmsAppState();
}

class _SmsAppState extends State<SmsApp> {
  final Telephony telephony = Telephony.instance;

  String smsReceived = "";

  final TextEditingController numberController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    askPermissions();
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        setState(() {
          smsReceived = "From: ${message.address}\nMessage: ${message.body}";
        });
      },
      onBackgroundMessage: backgroundMessageHandler,
    );
  }

  static backgroundMessageHandler(SmsMessage message) async {
    // Optionally handle SMS in background
  }

  Future<void> askPermissions() async {
    await Permission.sms.request();
  }

  void sendSMS() async {
    final number = numberController.text;
    final msg = messageController.text;
    if (number.isNotEmpty && msg.isNotEmpty) {
      await telephony.sendSms(
        to: number,
        message: msg,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("SMS Sent to $number")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Send & Receive SMS')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: "Message"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: sendSMS,
                child: Text("Send SMS"),
              ),
              Divider(height: 30),
              Text(
                "Received SMS:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(smsReceived),
            ],
          ),
        ),
      ),
    );
  }
}
