import 'dart:html';

import 'package:dpkmobileflutter/model/project.dart';
import 'package:dpkmobileflutter/model/smu.dart';
import 'package:dpkmobileflutter/pages/homePage.dart';
import 'package:dpkmobileflutter/services/Api.dart';
import 'package:flutter/material.dart';

class DocumentDetailPage extends StatefulWidget {
  const DocumentDetailPage({Key? key, this.data}) : super(key: key);
  final Project? data;
  @override
  _DocumentDetailPageState createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  late  Api api;
  late Future futurePost ;
  late List<Smu?> smu = [];
  late bool checkLoading;
  int position = 0;

  final children = <Widget>[];


  @override
  void initState() {
    super.initState();
    api = Api();
    checkLoading = false;

    for (var i = 0; i < 10; i++) {
      children.add(new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.blue.shade100,
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
        margin: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
        child: Text('123-GHSDD', style: TextStyle(color: Colors.blue),),
      ));
    }
  }
  Future loadList() {
    Future <List<Smu>> futureCases = api.checkerSmu(widget.data!.id);
    futureCases.then((smuList) {
      setState(() {
        this.smu = smuList;
      });
    });
    return futureCases;
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child:  Stack(
          children: [
            Container(
                height: 250,
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
                )),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(
                            widget.data!.no.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16,),
                    Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: RaisedButton(
                                        color: Colors.blue,

                                        padding: const EdgeInsets.only(left: 16, top: 2, bottom: 2, right: 16),
                                        splashColor: Colors.blue.shade600,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8))),
                                        onPressed: () async {
                                          _showMyDialog(context);
                                          //
                                          // api.adminSelesai(newData, widget.data!.id);
                                        },
                                        child: Text(
                                          'Document',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(16))),
                                  color: Colors.white,
                                  child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(16),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: (){

                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    color: Colors.blue.shade200,
                                                  ),
                                                  child: Icon(Icons.fullscreen, color: Colors.blue.shade500, size: 16,),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    flex:1,
                                                    child: _gridQty(context, '3')
                                                ),
                                                Expanded(
                                                    flex:1,
                                                    child: _gridBerat(context, '460')
                                                ),
                                                Expanded(
                                                    flex:1,
                                                    child: _gridDiterimaDari(context, 'PKD')
                                                ),
                                                SizedBox(width: 50,),
                                                Expanded(
                                                    flex:3,
                                                    child: _gridSmu(context, 'PKD')
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 24,),
                                            Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Text('Nama Agen')
                                                ),
                                                SizedBox(width: 16,),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text('No SMU')
                                                ),
                                                SizedBox(width: 16,),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text('Warehouse')
                                                ),
                                                SizedBox(width: 16,),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text('Tanggal Penerbangan')
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: _widgetNamaCustomer(context)
                                                ),
                                                SizedBox(width: 16,),
                                                Expanded(
                                                    flex: 1,
                                                    child: _widgetNoSMU(context)
                                                ),
                                                SizedBox(width: 16,),
                                                Expanded(
                                                    flex: 1,
                                                    child: _widgetWarehouse(context)
                                                ),
                                                SizedBox(width: 16,),
                                                Expanded(
                                                    flex: 1,
                                                    child: _widgetTglPenerbangan(context)
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 16,),
                                            Divider(
                                                color: Colors.grey
                                            ),
                                            SizedBox(height: 16,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 16),
                                                        _widgetFieldKotaAsal(context),
                                                        SizedBox(height: 16),
                                                        _widgetFieldKotaTujuan(context),
                                                        SizedBox(height: 16),
                                                        _widgetFieldNoPolisiKendaraan(context),
                                                        SizedBox(height: 16),
                                                        _widgetFieldNamaPengemudi(context),
                                                      ],
                                                    )
                                                ),
                                                SizedBox(width: 50),
                                                Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 16),
                                                        Text('Status Keamanan'),
                                                        SizedBox(height: 4),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              flex:1,
                                                              child: _checkboxSpx(context),
                                                            ),
                                                            Expanded(
                                                              flex:1,
                                                              child: _checkboxSco(context),
                                                            ),
                                                            Expanded(
                                                              flex:1,
                                                              child: _checkboxShr(context),
                                                            )

                                                          ],
                                                        ),
                                                        SizedBox(height: 16),
                                                        Text('Metode Pemeriksaan'),
                                                        SizedBox(height: 4),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              flex:1,
                                                              child: _checkboxXray(context),
                                                            ),
                                                            Expanded(
                                                              flex:1,
                                                              child: _checkboxEtd(context),
                                                            ),
                                                            Expanded(
                                                              flex:1,
                                                              child: _checkboxEdd(context),
                                                            ),
                                                            Expanded(
                                                              flex:1,
                                                              child: _checkboxOther(context),
                                                            )

                                                          ],
                                                        ),
                                                        SizedBox(height: 16),
                                                        Text('Transit (jika ada)'),
                                                        SizedBox(height: 4),
                                                        _radioTransit(context),
                                                        SizedBox(height: 16),
                                                        _widgetFieldPengecualianPemeriksaan(context),
                                                        SizedBox(height: 16),
                                                        _widgetFieldStatuskeaamananditerbitkanoleh(context),
                                                      ],
                                                    )
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),

                              ],
                            ),
                          ),
                        ))

                  ],
                )

            ),

          ],
        ),);
  }

  Widget _widgetFieldKotaAsal(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kota Asal',
          ),
        )
      ],
    );
  }
  Widget _widgetFieldKotaTujuan(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kota Tujuan',
          ),
        )
      ],
    );
  }
  Widget _widgetFieldNoPolisiKendaraan(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nomor Polisi Kendaraan',
          ),
        )
      ],
    );
  }
  Widget _widgetFieldNamaPengemudi(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama Pengemudi',
          ),
        )
      ],
    );
  }
  Widget _widgetFieldStatuskeaamananditerbitkanoleh(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Status keamanan diterbitkan oleh',
          ),
        )
      ],
    );
  }
  Widget _widgetFieldPengecualianPemeriksaan(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Pengecualian Pemeriksaan',
          ),
        )
      ],
    );
  }

  //CHECKBOX
  Widget _checkboxSpx(BuildContext context){
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value){}),
        SizedBox(width: 8,),
        Text('SPX')
      ],
    );
  }
  Widget _checkboxSco(BuildContext context){
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value){}),
        SizedBox(width: 8,),
        Text('SCO')
      ],
    );
  }
  Widget _checkboxShr(BuildContext context){
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value){}),
        SizedBox(width: 8,),
        Text('SHR')
      ],
    );
  }
  Widget _checkboxXray(BuildContext context){
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value){}),
        SizedBox(width: 8,),
        Text('X-Ray')
      ],
    );
  }
  Widget _checkboxEtd(BuildContext context){
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value){}),
        SizedBox(width: 8,),
        Text('ETD')
      ],
    );
  }
  Widget _checkboxEdd(BuildContext context){
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value){}),
        SizedBox(width: 8,),
        Text('EDD')
      ],
    );
  }
  Widget _checkboxOther(BuildContext context){
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value){}),
        SizedBox(width: 8,),
        Text('Other')
      ],
    );
  }

  Widget _gridQty(BuildContext context, value){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Qty', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey.shade500),),
        SizedBox(height: 4,),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue.shade500),),
      ],
    );
  }
  Widget _gridBerat(BuildContext context, value){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Total Berat', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey.shade500),),
        SizedBox(height: 4,),
        Text(value + " KG", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue.shade500),),
      ],
    );
  }
  Widget _gridDiterimaDari(BuildContext context, value){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Diterima dari', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey.shade500),),
        SizedBox(height: 4,),
        Text(value , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue.shade500),),
      ],
    );
  }
  Widget _gridSmu(BuildContext context, value){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('No SMU', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey.shade500),),
        SizedBox(height: 4,),
        Wrap(
          children: children,
        )
      ],
    );
  }


  //CUSTOMER
  Widget _widgetNamaCustomer(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama Agen',
          ),
        )
      ],
    );
  }
  Widget _widgetNoSMU(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'No SMU',
          ),
        )
      ],
    );
  }
  Widget _widgetWarehouse(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Warehouse',
          ),
        )
      ],
    );
  }
  Widget _widgetTglPenerbangan(BuildContext context){
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Tanggal Penerbangan',
          ),
        )
      ],
    );
  }

  Widget _radioTransit(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Row(
              children: [
                Radio(
          value: 1,
          groupValue: 1,
          onChanged: (val) {
            setState(() {
              // radioButtonItem = 'ONE';
              // id = 1;
            });
          },
        ),
                Text('Ada'),
              ],
            )
        ),

        Expanded(
            child: Row(
              children: [
              Radio(
                value: 2,
                groupValue: 2,
                onChanged: (val) {
                  setState(() {
                    // radioButtonItem = 'TWO';
                    // id = 2;
                  });
                },
              ),
              Text(
                'Tidak ada'
              ),
            ],
            )
        )

        
      ],
    );
  }
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Document'),
                Text('Apakah anda yakin ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak', style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Document'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => DocumentDetailPage(data: widget.data)));

              },
            ),

          ],
        );
      },
    );
  }
}
