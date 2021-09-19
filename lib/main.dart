import 'package:flutter/material.dart';
import 'package:flutter_pdf_ii/api/pdf_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter PDF Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  final pdfFile = await PdfApi.generateTable();
                  PdfApi.openFile(pdfFile);
                },
                child: Text('Generate Table PDFs')),
            ElevatedButton(
                onPressed: () async {
                  final pdfFile = await PdfApi.generateImage();
                  PdfApi.openFile(pdfFile);
                },
                child: Text('Generate image PDF')),
          ],
        ),
      ),
    );
  }
}
