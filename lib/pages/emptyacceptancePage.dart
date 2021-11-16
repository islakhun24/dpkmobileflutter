// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:dpkmobileflutter/pages/newTaskAcceptancePage.dart';
import 'package:flutter/material.dart';

class EmptyAcceptanceProject extends StatefulWidget {
  const EmptyAcceptanceProject({Key? key}) : super(key: key);

  @override
  _EmptyAcceptanceProjectState createState() => _EmptyAcceptanceProjectState();
}

class _EmptyAcceptanceProjectState extends State<EmptyAcceptanceProject> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/box.png',
                width: 300,
                height: 300,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              const Text(
                'Data tidak ada',
                style: const TextStyle(
                  color: Color(0xFF3C4670),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              const Text(
                'data sekarang tidak tersedia, coba tunggu beberapa saat.',
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: const EdgeInsets.only(top: 30),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTaskAcceptancePage(),
                    ),
                  );
                },
                minWidth: double.infinity,
                height: 50,
                child: Text(
                  'Tambah Tugas'.toUpperCase(),
                ),
                color: Color(0xFF3C4670),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
