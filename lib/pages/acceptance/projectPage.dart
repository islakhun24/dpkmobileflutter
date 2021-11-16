
import 'package:dpkmobileflutter/model/project.dart';
import 'package:flutter/material.dart';

import 'acceptanceSmuPage.dart';

class ProjectAcceptancePage extends StatefulWidget {
  ProjectAcceptancePage({Key? key, this.data}) : super(key: key);
  Project? data;
  @override
  _ProjectAcceptancePageState createState() => _ProjectAcceptancePageState();
}

class _ProjectAcceptancePageState extends State<ProjectAcceptancePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
          elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Color(0xFF506C95),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 350,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('No DO:' , style: TextStyle(color: Colors.white),),
                  Container(
                    height: 2,
                  ),
                  Text(widget.data!.no.toString(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
                  Container(
                    height: 16,
                  ),
                  Text('Pengemudi:', style: TextStyle(color: Colors.white)),
                  Container(
                    height: 2,
                  ),
                  Text(widget.data!.nama_pengemudi.toString() + ' ('+widget.data!.no_polisi_kendaraan.toString()+')', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),

                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => AcceptanceSmuPage(data: widget.data,)));
                  },
                  child: Icon(Icons.arrow_forward_ios, color: Color(0xFF506C95)),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Colors.white, // <-- Button color
                    onPrimary: Colors.grey.shade100, // <-- Splash color
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
