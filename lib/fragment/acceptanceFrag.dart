import 'package:dpkmobileflutter/model/response_acceptance.dart';
import 'package:dpkmobileflutter/pages/acceptance/projectPage.dart';
import 'package:dpkmobileflutter/pages/emptyacceptancePage.dart';
import 'package:dpkmobileflutter/services/Api.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AcceptanceFrag extends StatefulWidget {
  const AcceptanceFrag({Key? key}) : super(key: key);

  @override
  _AcceptanceFragState createState() => _AcceptanceFragState();
}

class _AcceptanceFragState extends State<AcceptanceFrag> {
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
            return status==0? EmptyAcceptanceProject():ProjectAcceptancePage(data: snapshot.data!.data,);

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
}
