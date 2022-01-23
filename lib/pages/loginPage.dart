// ignore_for_file: deprecated_member_use, constant_identifier_names, unnecessary_string_interpolations, unnecessary_null_comparison, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dpkmobileflutter/model/auth.dart';
import 'package:dpkmobileflutter/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_logs/flutter_logs.dart';
import '../services/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberpwd = false;
  bool sec = true;
  late Api api;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    api = Api();
    // prefs = await SharedPreferences.getInstance();
  }

  // ignore: prefer_const_constructors
  var visable = Icon(
    Icons.visibility,
    color: const Color(0xff4c5166),
  );
  // ignore: prefer_const_constructors
  var visableoff = Icon(
    Icons.visibility_off,
    color: const Color(0xff4c5166),
  );

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // ignore: unnecessary_const
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF6594BB),
                      Color(0xFF5A85A8),
                      Color(0xFF506C95),
                      Color(0xFF465682),
                      Color(0xFF3C5170),
                      Color(0xFF32395D),
                      Color(0xFF28314A),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Text(
                          "Hello User! ☺️",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        buildEmail(),
                        const SizedBox(
                          height: 50,
                        ),
                        buildPassword(),
                        const SizedBox(
                          height: 50,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     buildRememberassword(),
                        //     buildForgetPassword()
                        //   ],
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        buildLoginButton(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Username",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: const Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.person,
                  // ignore: unnecessary_const
                  color: const Color(0xff4c5166),
                ),
                hintText: 'Username',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          height: 60,
          child: TextField(
            controller: _passwordController,
            obscureText: sec,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      sec = !sec;
                    });
                  },
                  icon: sec ? visableoff : visable,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: const Icon(
                  Icons.vpn_key,
                  color: Color(0xff4c5166),
                ),
                hintText: "pwd",
                hintStyle: const TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildRememberassword() {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: rememberpwd,
                checkColor: Colors.blueGrey,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    rememberpwd = value!;
                  });
                },
              )),
          const Text(
            "Remember me",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildForgetPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: const Text("Forget Password !",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        onPressed: () {},
      ),
    );
  }

  Widget buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          onPressed: () async {
            var username = _usernameController.text;
            var password = _passwordController.text;
            var jwt = await api.login(username, password);

            Auth auth = Auth.fromJson(jsonDecode(jwt!));
            prefs = await SharedPreferences.getInstance();
            print('ini jwt : ' + auth.access_token);
            await prefs.setString('jwt', auth.access_token);
            if (auth.access_token != null) {
              // storage.write(key: "jwt", value: auth.access_token);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            } else {
              displayDialog(
                  context, "Gagal login", "Username atau password salah");
            }
          },
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: const Color(0xFF3C4670),
          padding: const EdgeInsets.all(30),
          child: const Text(
            "LOGIN",
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
