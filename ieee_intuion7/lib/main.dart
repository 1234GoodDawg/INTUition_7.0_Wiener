import 'package:flutter/material.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:firebase/firebase.dart' as fb;
import 'package:blinking_text/blinking_text.dart';
import 'package:firebase/firestore.dart' as fs;
import 'search.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/search': (context) => SearchPage(),
      },
    ),
  );
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      // Note: 3.5 represents the theoretical height of all my scrollable content. This number will vary for you.
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Stack(
        children: [
          Center(
            child: Container(
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  Size media;
  List<int> _selectedFile;
  Uint8List _bytesData;
  String fileName;
  fb.UploadTask uploadTask;
  html.File file;
  Widget errorMessage = SizedBox();

  //FilePickerResult result;
  // List<FilePickerResult> files;

  Uint8List _handleResult(Object result) {
    _bytesData = Base64Decoder().convert(result.toString().split(",").last);
    return _bytesData;
  }

  uploadToFirebase(html.File file) async {
    final fileExtension = file.name.split(".")[1];
    final filePath = 'UserSearch/${DateTime.now()}.$fileExtension';
    try {
      print(file.name);
      setState(() {
        uploadTask = fb
            .storage()
            .refFromURL(
                'gs://ieeeintuition-hp-chemsearch.appspot.com/' + filePath)
            .put(file);
      });
    } catch (e) {
      print(e);
    }
  }

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final uploadedFile = uploadInput.files.first;
      final reader = new html.FileReader();

      reader.readAsDataUrl(uploadedFile);
      reader.onLoadEnd.listen((e) async {
        setState(() {
          file = uploadedFile;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    media = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.1 * media.width),
      child: Form(
        //autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.025 * media.width),
          child: Column(
            children: [
              Image.asset(
                'images/hp_logo.png',
                width: 0.25 * media.width,
                height: 0.25 * media.width,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.025 * media.height),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    'HP Chemicals Search Engine',
                  ),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: 'Search Here',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0125 * media.height),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: file != null
                            ? Text(
                                file.name,
                                style: TextStyle(
                                  color: Colors.green[400],
                                ),
                              )
                            : errorMessage),
                    Expanded(child: SizedBox()),
                    StreamBuilder<fb.UploadTaskSnapshot>(
                      stream: uploadTask?.onStateChanged,
                      builder: (context, snapshot) {
                        Future sleep1() {
                          return new Future.delayed(
                              const Duration(seconds: 1), () => "1");
                        }

                        print(snapshot.runtimeType);
                        final event = snapshot?.data;
                        double progressPercent = event != null
                            ? event.bytesTransferred / event.totalBytes * 100
                            : 0;
                        if (event != null) {
                          print(event.bytesTransferred / event.totalBytes);
                        }

                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                            return Expanded(
                              child: LinearProgressIndicator(
                                value: progressPercent,
                                backgroundColor: Colors.green[100],
                              ),
                            );
                          case ConnectionState.done:
                            return Icon(
                              Icons.check,
                              color: Colors.green[400],
                            );
                          default:
                            // Show empty when not uploading
                            return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      startWebFilePicker();
                    },
                    child: Text('Add File'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/search'),
                    child: Text(
                      'View Searches',
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (file == null) {
                          setState(() {
                            errorMessage = BlinkText(
                              'File Not Uploaded',
                              style: TextStyle(
                                color: Colors.red[400],
                              ),
                              endColor: Colors.red[900],
                              times: 3,
                              duration: Duration(milliseconds: 500),
                            );
                          });
                        } else {
                          uploadToFirebase(file);
                        }
                      },
                      child: Text(
                        'Submit',
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
