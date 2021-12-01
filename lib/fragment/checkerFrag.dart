import 'package:dpkmobileflutter/model/project.dart';
import 'package:dpkmobileflutter/model/response_acceptance.dart';
import 'package:dpkmobileflutter/pages/acceptance/acceptanceSmuPage.dart';
import 'package:dpkmobileflutter/pages/acceptance/projectPage.dart';
import 'package:dpkmobileflutter/pages/checker/smuChecker.dart';
import 'package:dpkmobileflutter/pages/emptyacceptancePage.dart';
import 'package:dpkmobileflutter/services/Api.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_table/DatatableHeader.dart';

class CheckerFrag extends StatefulWidget {
  const CheckerFrag({Key? key}) : super(key: key);

  @override
  _CheckerFragState createState() => _CheckerFragState();
}

class _CheckerFragState extends State<CheckerFrag> {
  late Api api;
  int status = 1;
  late Future<Response_acceptance?> service;
  @override void initState() {
    // TODO: implement initState
    super.initState();
    api = Api();
    service = api.acceptance_get();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Response_acceptance?>(
        future: service,
        builder: (contex, snapshot){
          if(snapshot.hasData){
            status = snapshot.data!.status;
            return status==0? EmptyAcceptanceProject():_cardProject(snapshot.data!.data);

          }else if(snapshot.hasError){
            return EmptyAcceptanceProject();
          }else {
            return LoadingIndicator(
                indicatorType: Indicator.ballScaleMultiple, /// Required, The loading type of the widget
                colors: const [Color(0xFF5A85A8)],       /// Optional, The color collections
                strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                backgroundColor:  Colors.white,      /// Optional, Background of the widget
                pathBackgroundColor:  Color(0xFF32395D)   /// Optional, the stroke backgroundColor
            );
          }

        },
      )
    );
  }
  _cardProject(Project data){
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
                    Text(data.no.toString(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),
                    Container(
                      height: 16,
                    ),
                    Text('Pengemudi:', style: TextStyle(color: Colors.white)),
                    Container(
                      height: 2,
                    ),
                    Text(data.nama_pengemudi.toString() + ' ('+data.no_polisi_kendaraan.toString()+')', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),),

                  ],
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => SmuCheckerPage(data: data,)));
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
