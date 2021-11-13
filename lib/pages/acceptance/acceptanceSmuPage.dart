import 'package:dpkmobileflutter/constants/padding.dart';
import 'package:dpkmobileflutter/model/project.dart';
import 'package:dpkmobileflutter/model/sugest_agen.dart';
import 'package:dpkmobileflutter/model/sugest_barang.dart';
import 'package:dpkmobileflutter/model/sugest_smu.dart';
import 'package:dpkmobileflutter/services/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr_bar_scanner/flutter_qr_bar_scanner.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AcceptanceSmuPage extends StatefulWidget {
  AcceptanceSmuPage({Key? key, this.data}) : super(key: key);
  Project? data;
  @override
  _AcceptanceSmuPageState createState() => _AcceptanceSmuPageState();
}

class _AcceptanceSmuPageState extends State<AcceptanceSmuPage> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = true;
  late Future<String?> futureSmuList;
  late Future<SuggestSmu> futureSuggestSmuList;
  late Api api;
  late TextEditingController _smuController;
  late TextEditingController _agenController;
  late TextEditingController _companyController;
  late TextEditingController _nohpController;
  late TextEditingController _alamatController;
  late TextEditingController _barangController;
  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }


  @override
  void initState(){
    super.initState();
    _smuController = TextEditingController();
    _companyController = TextEditingController();
    _agenController = TextEditingController();
    _nohpController = TextEditingController();
    _alamatController = TextEditingController();
    _barangController = TextEditingController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _scanCode();
    api = Api();
    futureSmuList = api.getSmuAcceptance(widget.data!.id.toString());
  }
  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text('SMU ACCEPTANCE'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
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
              )
            ),
          ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: _buildColumn(context),
          )
             // child: Row(
             //   crossAxisAlignment: CrossAxisAlignment.start,
             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //   children: [
             //     Column(
             //       crossAxisAlignment: CrossAxisAlignment.start,
             //       children: [
             //         Wrap(
             //           alignment: WrapAlignment.start,
             //         children: [
             //           Align(
             //             alignment: Alignment.center,
             //             child: Text(
             //               widget.data!.no,
             //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF32395D),),
             //             ),
             //           ),
             //           Container(width: 8,),
             //           Column(
             //             crossAxisAlignment: CrossAxisAlignment.start,
             //             mainAxisAlignment: MainAxisAlignment.start,
             //             children: [
             //               Text(
             //                 'Pengemudi:',
             //                 textAlign: TextAlign.start,
             //                 // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF32395D),),
             //               ),
             //               Container(
             //                 height: 4,
             //               ),
             //               Text(
             //                 widget.data!.nama_pengemudi + ' ('+ widget.data!.no_polisi_kendaraan+')',
             //                 textAlign: TextAlign.start,
             //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF32395D),),
             //               )
             //             ],
             //           )
             //         ],
             //       ),
             //         Container(height: 20,),
             //         Card(
             //           elevation: 4,
             //           color: Colors.white,
             //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
             //           child: Container(
             //             padding: const EdgeInsets.all(16),
             //             height: 300,
             //             width: 280,
             //
             //             margin: const EdgeInsets.only(bottom: 10),
             //             child: Column(
             //               children: [
             //                 _camState
             //                     ? QRBarScannerCamera(
             //                   fit: BoxFit.cover,
             //                   onError: (context, error) => Text(
             //                     error.toString(),
             //                     style: TextStyle(color: Colors.red),
             //                   ),
             //                   qrCodeCallback: (code) {
             //                     _qrCallback(code);
             //                   },
             //                 ):Center(
             //                      child: Text(_qrInfo!),
             //                ),
             //               ],
             //             ),
             //           ),
             //         )
             //       ],
             //     ),
             //     Container(
             //       width: 16,
             //     ),
             //     Expanded(
             //       child: Column(
             //         mainAxisSize: MainAxisSize.max,
             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //         children: [
             //           Container(
             //
             //               height: 56,
             //               child: Row(
             //                 mainAxisSize: MainAxisSize.max,
             //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //                 children: [
             //                   Align(
             //                     alignment: Alignment.bottomLeft,
             //                     child: Wrap(
             //                       children: [
             //                         Text('Daftar barang | Total'),
             //                         Container(width: 4,),
             //                         Text('0 Koli', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3C5170),),),
             //                       ],
             //                     ),
             //                   ),
             //                  Align(
             //                    alignment: Alignment.centerRight,
             //                    child:  ElevatedButton(
             //                      onPressed: () {
             //                        Navigator.push(
             //                            context, MaterialPageRoute(builder: (context) => AcceptanceSmuPage(data: widget.data,)));
             //                      },
             //                      child: Text('Selesai', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
             //                      style: ElevatedButton.styleFrom(
             //                        shape: RoundedRectangleBorder(
             //                            borderRadius: BorderRadius.circular(8)
             //                        ),
             //                        padding: EdgeInsets.all(20),
             //                        primary: Colors.green, // <-- Button color
             //                        onPrimary: Colors.green.shade600, // <-- Splash color
             //                      ),
             //                    ),
             //                  )
             //                 ],
             //               )
             //           )
             //         ],
             //       ),
             //     )
             //   ],
             // )),


        )
    ),

    );


  }
  Widget _buildColumn(BuildContext contex){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _buildHeaderNoDo(contex),
              Container(height: 16,),
              _buildQrCode(contex)
            ],
          ),
        ),
        Container(width:16),
        _buildHeaderSmu(contex)
      ],
    );
  }
  Widget _buildHeaderNoDo(BuildContext contex){
    return Row(
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                this.widget.data!.no,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF32395D),),
              ),
            ),
            Container(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Pengemudi:',
                  textAlign: TextAlign.start,
                  // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF32395D),),
                ),
                Container(
                  height: 4,
                ),
                Text(
                  this.widget.data!.nama_pengemudi + ' ('+ this.widget.data!.no_polisi_kendaraan+')',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF32395D),),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
  Widget _buildQrCode(BuildContext context){
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 300,
        child: Column(
        children: [
          Container(
            width: 280,
            child: _camState
                ? QRBarScannerCamera(
              fit: BoxFit.cover,
              onError: (context, error) => Text(
                error.toString(),
                style: TextStyle(color: Colors.red),
              ),
              qrCodeCallback: (code) {
                _qrCallback(code);
              },
            ):Center(
              child: Text(_qrInfo!),
            ),
          ),
          Container(
            height: 8,
          ),
          SizedBox(
            height: 50,
            child: RaisedButton(
              onPressed: () {
                 showDialog(context: context,
                builder: (BuildContext context){
                   return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Paddings.padding),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: contentBox(context),
                  );
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color(0xFF506C95),
              child: Center(
                child: Text(
                  "Tambah",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
  Widget _buildHeaderSmu(BuildContext context){
    return Expanded(
      child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 56,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Wrap(
                            children: [
                              Text('Daftar barang | Total'),
                              Container(width: 4,),
                              Text('0 Koli', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3C5170),),),
                            ],
                          ),
                        ),
                       Align(
                         alignment: Alignment.centerRight,
                         child:  SizedBox(
                           height: 46,
                           width: 120,
                           child: RaisedButton(
                             onPressed: () {

                             },
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             color: Colors.green.shade600,
                             child: Center(
                               child: Text(
                                 "Selesai",
                                 style: TextStyle(color: Colors.white),
                               ),
                             ),
                           ),
                         ),
                       )
                      ],
                    )
                ),
                _buildListView(context)
              ],
            ),
    );
  }

  Widget _buildListView(BuildContext context){
      return Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        //           
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),

        ),
      );
  }

  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Paddings.padding,top: Paddings.avatarRadius
              + Paddings.padding, right: Paddings.padding,bottom: Paddings.padding
          ),
          margin: EdgeInsets.only(top: Paddings.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Paddings.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Tambah SMU',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex:1,
                          child: _autoCompleteSmu(context)
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          flex:1,
                          child: _autoCompleteAgen(context)
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex:1,
                          child: _textEditNohp(context)
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          flex:1,
                          child: _textEditAlamat(context)
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex:1,
                          child: _textEditCompany(context)
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          flex:1,
                          child: _autoCompleteBarang(context)
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: Wrap(
                  children: [
                    FlatButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text('Batal',style: TextStyle(fontSize: 18),)),
                    FlatButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text('Tambah',style: TextStyle(fontSize: 18),)),
                  ],
                )
              ),
            ],
          ),
        ),
        Positioned(
          left: Paddings.padding,
          right: Paddings.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Paddings.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Paddings.avatarRadius)),
                child: Container(
                  color: Colors.white,
                  child: Image.asset("assets/images/logo.png"),
                )
            ),
          ),
        ),
      ],
    );
  }

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];
  _autoCompleteSmu(contex){
      return TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: _smuController,
            style: TextStyle(

            ),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'SMU'
            )
        ),
        suggestionsCallback: (pattern) async {
          return await api.getSuggestSmu(pattern);
        },
        itemBuilder: (context, suggestion) {
          return  ListTile(
            title: Text(suggestion.toString())
          );
        },
        onSuggestionSelected: (suggestion) {
          setState(() {
            _smuController.text = suggestion.toString();
          });
        },
      );
  }
  _autoCompleteAgen(contex){
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: _agenController,
          style: TextStyle(

          ),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nama Agen'
          )
      ),
      suggestionsCallback: (pattern) async {
        return await api.getSuggestAgen(pattern);
      },
      itemBuilder: (context, SuggestAgen suggestion) {
        return  ListTile(
            title: Text(suggestion.customer.toString())
        );
      },
      onSuggestionSelected: (SuggestAgen suggestion) {
        setState(() {
          _companyController.text = suggestion.company_name.toString();
          _agenController.text = suggestion.customer.toString();
          _nohpController.text = suggestion.nohp.toString();
          _alamatController.text = suggestion.alamat.toString();
        });
      },
    );
  }
  _textEditCompany(contex){
    return TextField(
      controller: _companyController,
      keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Nama Perusahaan'
        )
    );
  }
  _textEditNohp(contex){
    return TextField(
        controller: _nohpController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'No Hp'
        )
    );
  }
  _textEditAlamat(contex){
    return TextField(
        controller: _alamatController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Alamat'
        )
    );
  }
  _autoCompleteBarang(contex){
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: _barangController,
          style: TextStyle(

          ),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
            hintText: 'Nama Barang'
          )
      ),
      suggestionsCallback: (pattern) async {
        return await api.getSuggestBarang(pattern);
      },
      itemBuilder: (context, SuggestBarang suggestion) {
        return  ListTile(
            title: Text(suggestion.nama_barang.toString()),
            subtitle: Text(suggestion.kode_barang.toString()),
        );
      },
      onSuggestionSelected: (SuggestBarang suggestion) {
        setState(() {
          _barangController.text = suggestion.nama_barang.toString();
        });
      },
    );
  }
}
