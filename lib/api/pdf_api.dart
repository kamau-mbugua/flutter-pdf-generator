import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class User {
  final String name;
  final int age;
  const User({required this.name, required this.age});
}

class PdfApi {
  static Future<File> generateTable() async {
    final pdf = Document();
    final header = ['Name', 'Age'];
    final users = [
      User(name: 'James', age: 19),
      User(name: 'Sarah', age: 21),
      User(name: 'Emma', age: 28),
      User(name: 'James', age: 19),
      User(name: 'Sarah', age: 21),
      User(name: 'Emma', age: 28),
      User(name: 'James', age: 19),
      User(name: 'Sarah', age: 21),
      User(name: 'Emma', age: 28),
      User(name: 'James', age: 19),
      User(name: 'Sarah', age: 21),
      User(name: 'Emma', age: 28),
      User(name: 'James', age: 19),
      User(name: 'Sarah', age: 21),
      User(name: 'Emma', age: 28),
    ];
    pdf.addPage(Page(
        build: (context) => Table.fromTextArray(
            headers: header,
            // ignore: non_constant_identifier_names
            data: users.map((User) => [User.name, User.age]).toList())));

    return saveDocument(name: 'mypdf.pdf', pdf: pdf);
  }

  static Future<File> generateImage() async {
    final pdf = Document();

    final imageSvg =
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List();
    final imagefb =
        (await rootBundle.load('assets/fb.png')).buffer.asUint8List();
    final imagetwt =
        (await rootBundle.load('assets/twt.png')).buffer.asUint8List();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) {
        if (context.pageNumber == 1) {
          return FullPage(
            ignoreMargins: true,
            // child: Image(MemoryImage(imageJpg), fit: BoxFit.cover),
          );
        } else {
          return Container();
        }
      },
    );

    pdf.addPage(MultiPage(
        pageTheme: pageTheme,
        build: (context) => [
              Container(
                child: Center(
                  child: builderHearder(imageSvg),
                ),
              ),
              SizedBox(height: 1 * PdfPageFormat.cm),
              Container(
                child: Center(
                  child: buildTitle(),
                ),
              ),
              //buildTitle(),
              Divider(),
              buildInvoice(),
              SizedBox(height: 3 * PdfPageFormat.cm),
              Divider(),
              SizedBox(height: 2 * PdfPageFormat.cm),
              buildTotal(imagefb, imagetwt),
            ]));

    return saveDocument(name: 'mypdf.pdf', pdf: pdf);
  }

  static Widget builderHearder(Uint8List imageSvg) =>
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image(MemoryImage(imageSvg)),
      ]);
  static Widget buildTitle() => Column(children: [
        Text('Transaction Reciept',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: PdfColors.cyanAccent700))
      ]);
  static Widget buildInvoice() => Column(children: [
        SizedBox(height: 3 * PdfPageFormat.cm),
        Row(children: [
          Container(
            decoration: BoxDecoration(
                // border: Border.all(
                //   color: PdfColors.cyanAccent700,
                // ),
                color: PdfColors.cyanAccent700,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: 150,
            height: 150,
            child: Center(
              child: Text('KES 1,999',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PdfColors.white)),
            ),
          ),
          SizedBox(width: 2 * PdfPageFormat.cm),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: Kelvin Mbugua',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 1 * PdfPageFormat.cm),
                Text('Transaction Date: 08/07/2021',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 1 * PdfPageFormat.cm),
                Text('To: Viu sasa Goat Eters',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 1 * PdfPageFormat.cm),
                Text('Status: Reconciled',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ])
        ]),
      ]);
  static Widget buildTotal(Uint8List imagefb, Uint8List imagetwt) =>
      Row(children: [
        Container(width: 70),
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Ralph Bunche Road, Elgon Court Block D1, Upperhill,',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  )),
              Text('Nairobi, Kenya',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  )),
              Text('P.O. BOX 104230 - 00101, Nairobi, Kenya',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  )),
              Text('+254 733 366 240',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              Text('info@chamasoft.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
        // Container(
        //     child: Center(
        //         child: Row(children: [
        //   Column(children: [
        //     Image(MemoryImage(imagefb)),
        //     Text('@ChamaSoft',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           fontSize: 18,
        //           fontWeight: FontWeight.normal,
        //         )),
        //   ]),
        //   Column(children: [
        //     Image(MemoryImage(imagetwt)),
        //     Text('@ChamaSoft',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           fontSize: 18,
        //           fontWeight: FontWeight.normal,
        //         )),
        //   ])
        // ])))
      ]);

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    //await PDFDocument.fromFile(file);
    await OpenFile.open(url);
  }
}
