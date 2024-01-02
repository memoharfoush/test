import 'dart:developer';

import 'package:test/databaseHelper.dart';
import 'package:test/jasonModel/userStu.dart';
import 'package:test/log_in.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});
  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  TextEditingController phone_num = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoading = false;
  final dbHelper = DatabaseHelper.internal();
  DatabaseHelper databaseHelper = DatabaseHelper();
  Future<void> sign_up(
      String username, String email, String password, String s_phone) async {
    final user = {
      'name': username,
      'email': email,
      'password': password,
      's_phone': phone_num,
    };
    log(user.toString());
    // await dbHelper.saveUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("The field is empty");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter your full name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("The field is empty");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("The field is empty");
                      }
                      return null;
                    },
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      labelText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  child: TextFormField(
                    controller: confirm_password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      } else if (password.text != confirm_password.text) {
                        return "password not correct";
                      }
                      return null;
                    },
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      labelText: 'Confirm your password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  child: TextFormField(
                    controller: phone_num,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("The field is empty");
                      }
                      return null;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter your phone number',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 9,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        {
                          int result = await databaseHelper.insert("user", {
                            "name": "${username.text}",
                            "email": "${email.text}",
                            "password": "${password.text}",
                            "s_phone": "${phone_num}",
                          });

                          print(result);
                          if (result > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Log_in()),
                                (route) => false);
                          }
                        }
                      }
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) ;
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Log_in()));
                        }
                      },
                      child: Text("Login"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
