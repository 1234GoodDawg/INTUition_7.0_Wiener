import 'package:flutter/material.dart';
import 'package:flutter_web_scrollbar/flutter_web_scrollbar.dart';

void main() {
  runApp(LandingPage());
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
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

  @override
  Widget build(BuildContext context) {
    media = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.1 * media.width),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Image.asset(
              'images/hp_logo.png',
              width: 0.25 * media.width,
              height: 0.25 * media.width,
            ),
            SizedBox(
              height: 0.025 * media.width,
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
            SizedBox(
              height: 0.025 * media.width,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Processing Data'),
                    ),
                  );
                }
              },
              child: Text(
                'Submit',
              ),
            )
          ],
        ),
      ),
    );
  }
}
