import 'package:flutter/material.dart';
import 'package:organiza_app/pages/signup.dart';
import 'dart:convert';
import 'package:organiza_app/pages/home.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  String? _userName;
  String? _password;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    userNameController.addListener(_changeUserName);
    passwordController.addListener(_changePassword);
  }

  void _changeUserName() {
    setState(() {
      _userName = userNameController.text;
    });
  }

  void _changePassword() {
    setState(() {
      _password = passwordController.text;
    });
  }

  void postLoginData(BuildContext context) async {
    if (_userName == null ||
        _password == null ||
        _password == "" ||
        _userName == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username or Password not set')),
      );
    } else {
      var url = Uri.parse('http://10.0.2.2:8080/login');
      var client = HttpClient();

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      try {
        var request = await client.postUrl(url);
        request.headers.set('content-type', 'application/json');

        var payload =
            json.encode({"username": _userName, "password": _password});
        request.write(payload);

        var response = await request.close();

        if (response.statusCode == 200) {
          var responseBody = await response.transform(utf8.decoder).join();
          var jsonResponse = json.decode(responseBody);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                username: _userName!,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Request failed with status ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error during HTTP request: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during HTTP request: $e')),
        );
      } finally {
        client.close();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 390.0),
          child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "Organize App",
                style: TextStyle(fontWeight: FontWeight.w700),
              )),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Get ready to organize yourself!",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      hintText: "UserName/Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  obscureText: _obscurePassword,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      hintText: "Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    postLoginData(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    height: 70,
                    alignment: Alignment.center,
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10),
                      child: Text("Or"),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ),
              /*Row(
                children: [
                  Container(
                    child: Image.asset(name),
                  ),
                  Container(child: Image.asset(name)),
                  Container(child: Image.asset())
                ],
              )*/
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Doesn't have an account? Sign up instead!",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
