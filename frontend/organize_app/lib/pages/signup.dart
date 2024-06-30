import 'package:flutter/material.dart';
import 'dart:io';
import 'package:organiza_app/pages/login.dart';
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _agreePolicy = false;

  String _userName = "";
  String _password = "";
  String _email = "";

  void postSignUp(BuildContext context) async {
    if (_password.isEmpty || _userName.isEmpty || _email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are not set')),
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
              builder: (context) => const LoginPage(),
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
        title: Padding(
          padding: const EdgeInsets.only(
            right: 390.0,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
                child: const Text(
              "Organize App",
              style: TextStyle(fontWeight: FontWeight.w700),
            )),
          ),
        ),
      ),
      body: ListView(children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Please register on our Streamline, where you can continue using our services.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        hintText: "UserName"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        hintText: "Email"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        hintText: "Password"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _agreePolicy,
                          onChanged: (value) {
                            setState(() {
                              _agreePolicy = value!;
                            });
                          }),
                      const Text("I agree to privacy & policy terms."),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      postSignUp(context);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      height: 70,
                      alignment: Alignment.center,
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 10, right: 10),
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
                  padding: const EdgeInsets.only(top: 20.0, left: 10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Container(
                        child: const Text(
                          "Already have an account? Sign in instead!",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
