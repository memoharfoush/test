import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          'first App',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notification_important,
            ),
            onPressed: onNotification,
          ),
          IconButton(
            icon: Text(
              'Hello',
            ),
            onPressed: () {
              print('hello');
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Row(
          children: [
            Container(
              color: Colors.red,
              child: Text(
                'first ',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onNotification() {
    print('notification clicked');
  }
}
