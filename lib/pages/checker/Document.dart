// import 'dart:html';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dpkmobileflutter/model/document_response.dart';
import 'package:dpkmobileflutter/model/project.dart';
import 'package:dpkmobileflutter/model/smu.dart';
import 'package:dpkmobileflutter/pages/homePage.dart';
import 'package:dpkmobileflutter/services/Api.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class DocumentDetailPage extends StatefulWidget {
  const DocumentDetailPage({Key? key, this.data}) : super(key: key);
  final Project? data;
  @override
  _DocumentDetailPageState createState() => _DocumentDetailPageState();
}

enum Transit { ada, tidakAda }

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  final _kotaAsalController = TextEditingController();
  final _kotaTujuanController = TextEditingController();
  final _kotaAsalTransitController = TextEditingController();
  final _kotaTujuanTransitController = TextEditingController();
  final _noPolisiKendaraanController = TextEditingController();
  final _namaPengemudiController = TextEditingController();
  final _statuskeaamananditerbitkanolehController = TextEditingController();
  final _pengecualianPemeriksaanController = TextEditingController();
  final _metodePemeriksaanyanglainController = TextEditingController();
  List<Map<String, dynamic>> warehouseList = [];
  List<Map<String, dynamic>> tanggals = [];
  List<String?> isiKirimanList = [];
  List<String?> namaAgenList = [];

  List<Smu?> formSmuList = [];
  String? _transit = 'TIDAK ADA';
  bool isSpx = false;
  bool isSco = false;
  bool isShr = false;
  bool isXray = false;
  bool isEtd = false;
  bool isEdd = false;
  bool isOther = false;
  bool isTransit = false;
  bool isLoadingCreate = false;
  late Api api;
  late Future futurePost;
  late List<Smu?> smu = [];
  late bool checkLoading;
  int position = 0;
  // late  Future<DocumentResponse?> detailChecker;
  final childrenSmu = <Widget>[];
  late DocumentResponse? _documentResponse;
  late bool isLoading = true;
  final childrenWarehouse = <Widget>[];
  List<TextEditingController> _controllerNamaCustomers = [];
  List<TextEditingController> _controllerNoSmus = [];
  List<TextEditingController> _controllerTglPenerberbangan = [];
  List<TextEditingController> _controllerWarehouses = [];
  final format = DateFormat("yyyy-MM-dd HH:mm");
  List<String> _warehouseList = ['DBM', 'PERSERO BATAM']; // Option 2
  late String _warehouse;
  @override
  void initState() {
    super.initState();
    api = Api();
    checkLoading = false;
    _warehouse = "DBM";
    _documentResponse = new DocumentResponse();
    loadDetails();
    loadSmu();
  }

  Future loadSmu() {
    Future<List<Smu>> futureCases = api.documentSmuDetail(widget.data!.id);
    futureCases.then((smuList) {
      setState(() {
        this.smu = smuList;
      });
    });
    return futureCases;
  }

  Future loadDetails() {
    Future<DocumentResponse?> futureCases = api.documentDetail(widget.data!.id);
    futureCases.then((smuList) {
      setState(() {
        this._documentResponse = smuList;
        this.isLoading = false;
      });
      _kotaAsalController.text =
          this._documentResponse!.detail!.kotaAsal.toString();
      _kotaTujuanController.text =
          this._documentResponse!.detail!.kotaTujuan.toString();
      _kotaAsalTransitController.text = _kotaTujuanController.text;
      for (var i = 0; i < _documentResponse!.smu!.length; i++) {
        childrenSmu.add(new Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.blue.shade100,
          ),
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
          margin: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
          child: Text(
            _documentResponse!.smu![i].smu.toString(),
            style: TextStyle(color: Colors.blue),
          ),
        ));
      }

      for (var i = 0; i < _documentResponse!.warehouses!.length; i++) {
        _controllerNamaCustomers.add(TextEditingController());
        _controllerNamaCustomers[i].text =
            _documentResponse!.warehouses![i].namaAgen.toString();
        _controllerNoSmus.add(TextEditingController());
        _controllerNoSmus[i].text =
            _documentResponse!.warehouses![i].maskapai.toString() +
                ' (' +
                _documentResponse!.warehouses![i].smu.toString() +
                ')';
        _controllerTglPenerberbangan.add(TextEditingController());
        _controllerWarehouses.add(TextEditingController());
        _controllerWarehouses[i].text =
            _documentResponse!.warehouses![i].warehouse.toString();

        childrenWarehouse.add(new Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: _widgetNamaCustomer(
                        context, _controllerNamaCustomers[i])),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    flex: 1,
                    child: _widgetNoSMU(context, _controllerNoSmus[i])),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 1,
                  // child: _widgetWarehouse(context, _controllerWarehouses[i])
                  child: _documentResponse!.warehouses![i].warehouse == 'DBM' ||
                          _documentResponse!.warehouses![i].warehouse ==
                              'PERSERO BATAM'
                      ? _widgetWarehouse(context, _controllerWarehouses[i])
                      : _selectWarehouse(
                          context, _documentResponse!.warehouses![i]),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    flex: 1,
                    child: _widgetTglPenerbangan(
                        context, _controllerTglPenerberbangan[i]))
              ],
            )));
      }
    });
    return futureCases;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
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
          isLoading
              ? const Center(
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotate,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
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
                      SizedBox(
                        height: 16,
                      ),
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
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          top: 2,
                                          bottom: 2,
                                          right: 16),
                                      splashColor: Colors.blue.shade600,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      onPressed: () async {
                                        handleClick();
                                        //
                                        // api.adminSelesai(newData, widget.data!.id);
                                      },
                                      child: Text(
                                        'Document',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
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
                                              onTap: () {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return _widgetModal(
                                                        context);
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  color: Colors.blue.shade200,
                                                ),
                                                child: Icon(
                                                  Icons.fullscreen,
                                                  color: Colors.blue.shade500,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: _gridQty(
                                                      context,
                                                      _documentResponse!
                                                          .data!.koli
                                                          .toString())),
                                              Expanded(
                                                  flex: 1,
                                                  child: _gridBerat(
                                                      context,
                                                      _documentResponse!
                                                          .data!.beratTotal
                                                          .toString())),
                                              Expanded(
                                                  flex: 1,
                                                  child: _gridDiterimaDari(
                                                      context,
                                                      _documentResponse!
                                                          .detail!.asalTps
                                                          .toString())),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child:
                                                      _gridSmu(context, 'PKD'))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 24,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text('Nama Agen')),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text('No SMU')),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text('Warehouse')),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                      'Tanggal Penerbangan'))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Column(children: childrenWarehouse),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Divider(color: Colors.grey),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 16),
                                                      _widgetFieldKotaAsal(
                                                          context),
                                                      SizedBox(height: 16),
                                                      _widgetFieldKotaTujuan(
                                                          context),
                                                      SizedBox(height: 16),
                                                      _widgetFieldNoPolisiKendaraan(
                                                          context),
                                                      SizedBox(height: 16),
                                                      _widgetFieldNamaPengemudi(
                                                          context),
                                                    ],
                                                  )),
                                              SizedBox(width: 50),
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(height: 16),
                                                      Text('Status Keamanan'),
                                                      SizedBox(height: 4),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: _checkboxSpx(
                                                                context),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: _checkboxSco(
                                                                context),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: _checkboxShr(
                                                                context),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 16),
                                                      Text(
                                                          'Metode Pemeriksaan'),
                                                      SizedBox(height: 4),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                _checkboxXray(
                                                                    context),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: _checkboxEtd(
                                                                context),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: _checkboxEdd(
                                                                context),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:
                                                                _checkboxOther(
                                                                    context),
                                                          )
                                                        ],
                                                      ),
                                                      isOther
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 16,
                                                                      bottom:
                                                                          16),
                                                              child:
                                                                  _widgetFieldPengecualianPemeriksaan(
                                                                      context),
                                                            )
                                                          : SizedBox(
                                                              height: 16),
                                                      Text(
                                                          'Transit (jika ada)'),
                                                      SizedBox(height: 4),
                                                      _radioTransit(context),
                                                      _transit == 'ADA'
                                                          ? _fieldTransit(
                                                              context)
                                                          : SizedBox(
                                                              height: 16),
                                                      _widgetFieldPengecualianPemeriksaan(
                                                          context),
                                                      SizedBox(height: 16),
                                                      _widgetFieldStatuskeaamananditerbitkanoleh(
                                                          context),
                                                    ],
                                                  ))
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
                  )),
        ],
      ),
    );
  }

  Widget _widgetFieldKotaAsal(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _kotaAsalController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kota Asal',
          ),
        )
      ],
    );
  }

  Widget _widgetFieldMetodePemeriksaanYanglain(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _metodePemeriksaanyanglainController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Metode pemeriksaan yang lain',
          ),
        )
      ],
    );
  }

  Widget _widgetFieldKotaTujuan(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _kotaTujuanController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kota Tujuan',
          ),
          onChanged: (text) {
            setState(() {
              _kotaAsalTransitController.text = text;
            });
          },
        )
      ],
    );
  }

  Widget _widgetFieldNoPolisiKendaraan(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _noPolisiKendaraanController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nomor Polisi Kendaraan',
          ),
        )
      ],
    );
  }

  Widget _widgetFieldNamaPengemudi(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _namaPengemudiController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama Pengemudi',
          ),
        )
      ],
    );
  }

  Widget _widgetFieldStatuskeaamananditerbitkanoleh(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _statuskeaamananditerbitkanolehController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Status keamanan diterbitkan oleh',
          ),
        )
      ],
    );
  }

  Widget _widgetFieldPengecualianPemeriksaan(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _pengecualianPemeriksaanController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Pengecualian Pemeriksaan',
          ),
        )
      ],
    );
  }

  //CHECKBOX
  Widget _checkboxSpx(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isSpx,
            onChanged: (bool? value) {
              setState(() {
                isSpx = value!;
              });
            }),
        SizedBox(
          width: 8,
        ),
        Text('SPX')
      ],
    );
  }

  Widget _checkboxSco(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isSco,
            onChanged: (bool? value) {
              setState(() {
                isSco = value!;
              });
            }),
        SizedBox(
          width: 8,
        ),
        Text('SCO')
      ],
    );
  }

  Widget _checkboxShr(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isShr,
            onChanged: (bool? value) {
              setState(() {
                isShr = value!;
              });
            }),
        SizedBox(
          width: 8,
        ),
        Text('SHR')
      ],
    );
  }

  Widget _checkboxXray(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isXray,
            onChanged: (bool? value) {
              setState(() {
                isXray = value!;
              });
            }),
        SizedBox(
          width: 8,
        ),
        Text('X-Ray')
      ],
    );
  }

  Widget _checkboxEtd(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isEtd,
            onChanged: (bool? value) {
              setState(() {
                isEtd = value!;
              });
            }),
        SizedBox(
          width: 8,
        ),
        Text('ETD')
      ],
    );
  }

  Widget _checkboxEdd(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isEdd,
            onChanged: (bool? value) {
              setState(() {
                isEdd = value!;
              });
            }),
        SizedBox(
          width: 8,
        ),
        Text('EDD')
      ],
    );
  }

  Widget _checkboxOther(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isOther,
            onChanged: (bool? value) {
              setState(() {
                isOther = value!;
              });
            }),
        SizedBox(
          width: 8,
        ),
        Text('Other')
      ],
    );
  }

  Widget _gridQty(BuildContext context, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Qty',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey.shade500),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue.shade500),
        ),
      ],
    );
  }

  Widget _gridBerat(BuildContext context, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Total Berat',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey.shade500),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          value + " KG",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue.shade500),
        ),
      ],
    );
  }

  Widget _gridDiterimaDari(BuildContext context, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Diterima dari',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey.shade500),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue.shade500),
        ),
      ],
    );
  }

  Widget _gridSmu(BuildContext context, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'No SMU',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey.shade500),
        ),
        SizedBox(
          height: 4,
        ),
        Wrap(
          children: childrenSmu,
        )
      ],
    );
  }

  //CUSTOMER
  Widget _widgetNamaCustomer(
      BuildContext context, TextEditingController controller) {
    return Column(
      children: [
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama Agen',
          ),
        )
      ],
    );
  }

  Widget _widgetNoSMU(BuildContext context, TextEditingController controller) {
    return Column(
      children: [
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'No SMU',
          ),
        )
      ],
    );
  }

  Widget _widgetWarehouse(
      BuildContext context, TextEditingController controller) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Warehouse',
          ),
        )
      ],
    );
  }

  Widget _widgetTglPenerbangan(
      BuildContext context, TextEditingController controller) {
    return Column(
      children: [
        DateTimeField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Tanggal penerbangan',
          ),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
        ),
      ],
    );
  }

  Widget _radioTransit(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Row(
          children: [
            Radio(
              value: 'ADA',
              groupValue: _transit,
              onChanged: (String? value) {
                setState(() {
                  _transit = value!;
                });
              },
            ),
            Text('Ada'),
          ],
        )),
        Expanded(
            child: Row(
          children: [
            Radio(
              value: 'TIDAK ADA',
              groupValue: _transit,
              onChanged: (String? value) {
                setState(() {
                  _transit = value!;
                });
              },
            ),
            Text('Tidak ada'),
          ],
        ))
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
              child: const Text(
                'Tidak',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Document'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DocumentDetailPage(data: widget.data)));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _fieldTransit(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: _kotaAsalTransitController,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kota Asal Transit',
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: _kotaTujuanTransitController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Kota Tujuan Transit',
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _widgetModal(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text((index + 1).toString())),
                    Expanded(flex: 1, child: Text(smu[index]!.smu.toString())),
                    Expanded(
                        flex: 1,
                        child: Text(smu[index]!.nama_barang.toString()))
                  ],
                ),
              );
            },
            itemCount: smu.length,
          ))
        ],
      ),
    );
  }

  Widget _selectWarehouse(BuildContext context, Warehouses warehous) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text("Select Device"),
              value: _warehouse,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  warehouseList.add({
                    "warehouse": newValue,
                    "warehouseid": warehous.warehouse
                  });
                });
              },
              items: _warehouseList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void handleClick() async {
    _documentResponse!.isiKiriman!
        .map((e) => {isiKirimanList.add(e.namaBarang)});
    _documentResponse!.namaAgen!.map((e) => {namaAgenList.add(e.namaAgen)});
    for (int i = 0; i < _controllerTglPenerberbangan.length; i++) {
      tanggals.add({
        'tanggal_penerbangan': _controllerTglPenerberbangan[i].text,
        'smu': _documentResponse!.warehouses![i].smu
      });
    }
    smu.map((e) => formSmuList.add(e));
    isLoadingCreate = true;
    var formdata = <String, dynamic>{
      "project_id": widget.data!.id.toString(),
      "isi_kiriman": isiKirimanList,
      "nama_agen": namaAgenList,
      "qty": _documentResponse!.data!.koli.toString(),
      "total_berat": _documentResponse!.data!.beratTotal.toString(),
      "asal_tps": _documentResponse!.detail!.asalTps.toString(),
      "kota_asal": _kotaAsalController.text.toString(),
      "kota_tujuan": _kotaTujuanController.text.toString(),
      "nomor_polisi_kendaraan": _noPolisiKendaraanController.text.toString(),
      "nama_pengemudi": _namaPengemudiController.text.toString(),
      "pengecualian_pemeriksaan":
          _pengecualianPemeriksaanController.text.toString(),
      "status_keamanan_diterbitkan_oleh":
          _statuskeaamananditerbitkanolehController.text.toString(),
      "transit": _transit == 'ADA' ? 'ADA' : 'TIDAK ADA',
      "datawarehouse": warehouseList,
      "smu": formSmuList,
      "spx": isSpx.toString(),
      "sco": isSco.toString(),
      "shr": isShr.toString(),
      "xray": isXray.toString(),
      "etd": isEtd.toString(),
      "other": isOther.toString(),
      "metode_pemeriksaan_lain":
          _metodePemeriksaanyanglainController.text.toString(),
      "edd": isEdd.toString(),
      "tujuan_transit": _kotaTujuanTransitController.text.toString(),
      "asal_transit": _kotaAsalTransitController.text.toString(),
      "tanggals": tanggals
    };
    // print(formdata);
    var creteCsd = await api.createCSD(formdata);
    if (creteCsd == true) {
      print('berhasil');
      setState(() {
        isLoadingCreate = false;
      });
    } else {
      print('gagal');
      setState(() {
        isLoadingCreate = false;
      });
    }
  }
}
