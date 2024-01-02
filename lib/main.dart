import 'package:test/Englishquiz.dart';
import 'package:test/Hello.dart';

import 'package:test/optionbuild.dart';
import 'package:test/optionpage.dart';
import 'package:test/questionPage.dart';
import 'package:test/questionbuild.dart';
import 'package:test/quiz_build.dart';
import 'package:test/quizmaths.dart';
import 'package:test/sign_up.dart';
import 'package:test/log_in.dart';
import 'package:test/quizPage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test/databaseHelper.dart';

void main() async {
  DatabaseHelper databaseHelper = DatabaseHelper();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Sign_up(),
      routes: {"questionPage": (context) => Log_in()},
    );
  }
}
