import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0125 * media.width),
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
                        iconSize:
                            media.width < 800.0 ? 32.0 : 0.04 * media.width,
                        onPressed: () => Navigator.pushNamed(context, '/'),
                        icon: Icon(
                          Icons.home,
                        ),
                      ),
                    ),
                    Container(child: Image.asset('images/chemical_1.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_2.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_3.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_4.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_5.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_6.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_7.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_8.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_9.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
                    Container(child: Image.asset('images/chemical_10.JPG')),
                    SizedBox(
                      height: 0.0125 * media.height,
                    ),
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
