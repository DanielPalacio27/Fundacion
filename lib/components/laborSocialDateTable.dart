import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:upb_app/class/labor_social.dart';
import 'package:upb_app/request/login.dart';
import 'dart:convert';
import 'package:upb_app/class/global.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LaborSocialDateTable extends StatefulWidget {
  final List<LaborSocial> lst;
  const LaborSocialDateTable({Key key, @required this.lst}) : super(key: key);

  @override
  _LaborSocialDateTable createState() => _LaborSocialDateTable();
}

class _LaborSocialDateTable extends State<LaborSocialDateTable> {

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: Text("Información labor social"),
        rowsPerPage: _rowsPerPage,
        availableRowsPerPage: <int>[5, 10, 15],
        onRowsPerPageChanged: (int value) {
          setState(() {
            _rowsPerPage = value;
          });
        },
        columns: kTableColumns,
        source: LaborSocialDataSoruse(widget.lst),
      ),
    );
  }
}

const kTableColumns = <DataColumn>[
  //DataColumn(label: const Text("detalle")),
  //DataColumn(label: const Text("cantidad"), tooltip: ""),
  DataColumn(label: const Text("HORAS"), tooltip: ""),
  DataColumn(label: const Text("NOMBRE USUARIO"), tooltip: ""),
  DataColumn(label: const Text("IDENTIFICACIÓN"), tooltip: ""),
  DataColumn(label: const Text("DOCUMENTO"), tooltip: ""),
];

class LaborSocialDataSoruse extends DataTableSource {
  final List<LaborSocial> lst;
  LaborSocialDataSoruse(this.lst);
  int _selectedCount = 0;
  final List<LaborSocial> _labor = <LaborSocial>[
    new LaborSocial(1, "prueba", 23, "123433", "1234124", "prueba"),
  ];

  final textDocumentoNull = TextSpan(
    text: "Ver",
    style: new TextStyle(color: Colors.black),
  );

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= lst.length) return null;
    final LaborSocial labor = lst[index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      //DataCell(Text('${labor.id}')),
      //DataCell(Text('${labor.usuario}')),
      DataCell(Text('${labor.horas}')),
      DataCell(Text('${labor.nombreUsuario}')),
      DataCell(Text('${labor.idUniversitario}')),
      //DataCell(Text('${labor.documento}')),
      DataCell(Center(
        child:  new RichText(text: labor.documento == null ? textDocumentoNull: new TextSpan(
          text: "Ver",
          style: new TextStyle(color: Colors.blue),
          recognizer: new TapGestureRecognizer()
            ..onTap = () {launch(globals.url + '${labor.documento}');
            },
        ))
      )),
    ]);
  }

  @override
  int get rowCount => lst.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
