import 'package:flutter/material.dart';

class VisualisePage extends StatefulWidget {
  @override
  _VisualisePageState createState() => _VisualisePageState();
}

class _VisualisePageState extends State<VisualisePage> {
  ScrollController _controller;
  Size media;

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
    media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Stack(
        children: [
          Container(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal:
                          media.width < 800.0 ? 14 : 0.0175 * media.width,
                      vertical:
                          media.height < 800.0 ? 12.5 : 0.0125 * media.height,
                    ),
                    child: IconButton(
                      tooltip: 'Home',
                      hoverColor: Colors.blue,
                      iconSize: media.width < 800.0 ? 32.0 : 0.04 * media.width,
                      onPressed: () => Navigator.pushNamed(context, '/'),
                      icon: Icon(
                        Icons.home,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
