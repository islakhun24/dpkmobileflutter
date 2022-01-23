import 'package:dpkmobileflutter/model/project.dart';
import 'package:dpkmobileflutter/model/smu.dart';
import 'package:dpkmobileflutter/pages/checker/Document.dart';
import 'package:dpkmobileflutter/pages/homePage.dart';
import 'package:dpkmobileflutter/services/Api.dart';
import 'package:flutter/material.dart';

class SmuCheckerPage extends StatefulWidget {
  const SmuCheckerPage({Key? key, this.data}) : super(key: key);
  final Project? data;

  @override
  _SmuCheckerPageState createState() => _SmuCheckerPageState();
}

class _SmuCheckerPageState extends State<SmuCheckerPage> {
  late Api api = Api();
  late Future futurePost;
  late List<Smu?> smu = [];
  late bool checkLoading;
  late bool checkFirstSMU = true;
  int position = 0;
  @override
  void initState() {
    super.initState();
    checkLoading = false;
  }

  Future loadList() {
    Future<List<Smu>> futureCases = api.checkerSmu(widget.data!.id);
    futureCases.then((smuList) {
      setState(() {
        checkFirstSMU = false;
        this.smu = smuList;
      });
    });
    return futureCases;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          header(context),
          Positioned(
            top: 210,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Card(
                color: Colors.white,

                // margin: EdgeInsets.only(top: -40),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daftar SMU',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: FutureBuilder(
                              builder: (context, snapshoot) {
                                return checkFirstSMU == true
                                    ? const Text('loading...')
                                    : smu.isEmpty
                                        ? const Text('data kosong')
                                        : ListView.separated(
                                            itemBuilder: (context, int index) {
                                              return Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      smu[index]!
                                                          .smu
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(smu[
                                                                          index]!
                                                                      .koli
                                                                      .toString() +
                                                                  ' koli')),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(smu[
                                                                          index]!
                                                                      .berat_total
                                                                      .toString() +
                                                                  ' Kg')),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(smu[
                                                                      index]!
                                                                  .status
                                                                  .toString())),
                                                          checkLoading ==
                                                                      true &&
                                                                  index ==
                                                                      position
                                                              ? new CircularProgressIndicator()
                                                              : Checkbox(
                                                                  value: smu[index]!
                                                                          .check ??
                                                                      false,
                                                                  onChanged:
                                                                      (val) async {
                                                                    this.checkLoading =
                                                                        true;
                                                                    this.position =
                                                                        index;
                                                                    Future<List<Smu?>>
                                                                        futureCheck =
                                                                        api.updateSmuChecker(
                                                                            smu[index]!.id);
                                                                    futureCheck
                                                                        .then(
                                                                            (smuList) {
                                                                      setState(
                                                                          () {
                                                                        this.checkLoading =
                                                                            false;
                                                                        smu =
                                                                            smuList;
                                                                      });
                                                                    });
                                                                  })
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            itemCount: smu.length,
                                            separatorBuilder:
                                                (context, index) => Divider(
                                              color: Colors.grey.shade300,
                                            ),
                                          );
                              },
                              future: loadList(),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget header(BuildContext context) {
    return Container(
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
        ),
        child: Padding(
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
              Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        cardSmu(context, 'Pengemudi',
                            widget.data!.nama_pengemudi.toString()),
                        cardSmu(context, 'No Kendaraan',
                            widget.data!.no_polisi_kendaraan.toString()),
                        cardSmu(
                            context, 'TPS', widget.data!.asal_tps.toString())
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: RaisedButton(
                    color: Colors.blue,
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
              )
            ],
          ),
        ));
  }

  Widget cardSmu(BuildContext context, String header, String desc) {
    return Expanded(
        flex: 1,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  header,
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w100,
                      fontSize: 12),
                  textAlign: TextAlign.left,
                ),
                Text(
                  desc,
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ));
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
}
