import 'package:dpkmobileflutter/model/project.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';

class SmuCheckerPage extends StatefulWidget {
  SmuCheckerPage({Key? key, this.data}) : super(key: key);
  Project? data;
  @override
  _SmuCheckerPageState createState() => _SmuCheckerPageState();
}

class _SmuCheckerPageState extends State<SmuCheckerPage> {
  List<DatatableHeader> _headers = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: false,
        sortable: true,
        textAlign: TextAlign.right),
    DatatableHeader(
        text: "No",
        value: "no",
        show: true,
        sortable: true,
        editable:true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Status",
        value: "status",
        show: true,
        flex: 1,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "SMU",
        value: "smu",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Koli",
        value: "koli",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Nama Barang",
        value: "nama_barang",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Berat",
        value: "berat",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Check",
        value: "check",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];
  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  late int _currentPerPage;
  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _source = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> _selecteds = List<Map<String, dynamic>>();
  String _selectableKey = "id";

  late String _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;

  List<Map<String, dynamic>> _generateData({int n: 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    var i = _source.length;
    print(i);
    for (var data in source) {
      temps.add({
        "id": '000${(i+1)}',
        "no": "$i",
        "status": "Product Product Product Product $i",
        "smu": "DPM-00$i",
        "koli": "${i}/${i}",
        "nama_barang": "20.00",
        "berat": "${i}0 Kg",
        "check": "true"
      });
      i++;
    }
    return temps;
  }


  _initData() async {
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _source.addAll(_generateData(n: 10)); //1000
      setState(() => _isLoading = false);
    });
  }

  @override
  void initState(){
    super.initState();
    _initData();
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                this.widget.data!.no.toString(),
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF32395D),),
                              ),
                            ),
                            Container(width: 16,),
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
                                  this.widget.data!.nama_pengemudi.toString() + ' ('+ this.widget.data!.no_polisi_kendaraan.toString()+')',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF32395D),),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:  SizedBox(
                        height: 46,
                        width: 120,
                        child: RaisedButton(
                          onPressed: () async {

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
                    ),
                  ],
                ),
                Container(
                  height: 16
                ),
      ResponsiveDatatable(
        title: !_isSearch
            ? RaisedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text("ADD CATEGORY"))
            : null,
        actions: [
          if (_isSearch)
            Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              _isSearch = false;
                            });
                          }),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search), onPressed: () {})),
                )),
          if (!_isSearch)
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isSearch = true;
                  });
                })
        ],
        headers: _headers,
        source: _source,
        selecteds: _selecteds,
        showSelect: _showSelect,
        autoHeight: false,
        onTabRow: (data) {
          print(data);
        },
        onSort: (value) {
          setState(() {
            _sortColumn = value;
            _sortAscending = !_sortAscending;
            if (_sortAscending) {
              _source.sort((a, b) =>
                  b["$_sortColumn"].compareTo(a["$_sortColumn"]));
            } else {
              _source.sort((a, b) =>
                  a["$_sortColumn"].compareTo(b["$_sortColumn"]));
            }
          });
        },
        sortAscending: _sortAscending,
        sortColumn: _sortColumn,
        isLoading: _isLoading,
        onSelect: (value, item) {
          print("$value  $item ");
          if (value) {
            setState(() => _selecteds.add(item));
          } else {
            setState(
                    () => _selecteds.removeAt(_selecteds.indexOf(item)));
          }
        },
        onSelectAll: (value) {
          if (value) {
            setState(() => _selecteds =
                _source.map((entry) => entry).toList().cast());
          } else {
            setState(() => _selecteds.clear());
          }
        },
        footers: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Rows per page:"),
          ),
          if (_perPages != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButton(
                  value: _currentPerPage,
                  items: _perPages
                      .map((e) => DropdownMenuItem(
                    child: Text("$e"),
                    value: e,
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      //_currentPerPage = parseInt;
                    });
                  }),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child:
            Text("$_currentPage - $_currentPerPage of $_total"),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
            onPressed: () {
              setState(() {
                _currentPage =
                _currentPage >= 2 ? _currentPage - 1 : 1;
              });
            },
            padding: EdgeInsets.symmetric(horizontal: 15),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {
              setState(() {
                _currentPage++;
              });
            },
            padding: EdgeInsets.symmetric(horizontal: 15),
          )
        ],
      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
