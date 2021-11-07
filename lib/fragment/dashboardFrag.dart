import 'package:flutter/material.dart';
class DashboardFrag extends StatefulWidget {
  const DashboardFrag({Key? key}) : super(key: key);

  @override
  _DashboardFragState createState() => _DashboardFragState();
}

class _DashboardFragState extends State<DashboardFrag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Dashboard'),
    );
  }
}
