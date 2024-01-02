import 'package:test/Hello.dart';
import 'package:test/databaseHelper.dart';
import 'package:test/quizPage.dart';
import 'package:test/jasonModel/userStu.dart';
import 'package:test/quiz_build.dart';
import 'package:test/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class Log_in extends StatefulWidget {
  const Log_in({super.key});
  @override
  State<Log_in> createState() => _Log_in();
}

class _Log_in extends State<Log_in> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isVisible = false;
  bool isLoginTrue = false;
  bool isLoading = false;

  List user = [];

  DatabaseHelper databaseHelper = DatabaseHelper();
  getuser(context) async {
    var result = await databaseHelper
        .getUser(User(userEmail: email.text, userPassword: password.text));
    if (result == true) {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const QuizPage()));
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  // var result = await databaseHelper.getUser(email, password);
  // if (result == true) {
  //  if (!mounted) return;
  //   print("correct ");
  // } else {
  //   setState(() {
  //     (isLoginTrue = true);
  //    });

  // }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: 2000,
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80),
                          )),
                    ),
                  ),
                  Image.asset(
                    'assets/images/m.png',
                    height: 300,
                    width: 350,
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
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
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text('Forget Password? ')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Do\'t have an account? '),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Sign_up()));
                      },
                      child: Text('SIGN UP'))
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    //  setState(() {
                    //    isLoading = true;
                    //   });
                    //  try {

                    getuser(context);
                    //  setState(() {
                    //    isLoading = false;
                    //   });

                    //  } catch (e) {
                    //setState(() {
                    //  isLoading = false;
                    //});
                    // log(e.toString());

                  }
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Color.fromARGB(255, 247, 245, 245),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              isLoginTrue
                  ? const Text(
                      "user and pass in notcorrect",
                      style: TextStyle(color: Colors.red),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
