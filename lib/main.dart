import 'package:flutter/material.dart';
import './clip_shadow_path.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class HeaderLeftClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const itemWidth = 168.0;
    const bottomHeight = 0;
    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, 20)
      ..quadraticBezierTo(0, 0, 20, 0)
      ..lineTo(itemWidth - 40, 0)
      ..quadraticBezierTo(itemWidth - 20, 0, itemWidth - 20, 20)
      ..lineTo(itemWidth - 20, size.height - 20 - bottomHeight)
      ..quadraticBezierTo(itemWidth - 20, size.height - bottomHeight, itemWidth, size.height - bottomHeight)
      ..lineTo(size.width, size.height - bottomHeight)
      ..lineTo(size.width, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HeaderCenterClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(20, size.height, 20, size.height -  20)
      ..lineTo(20, 20)
      ..quadraticBezierTo(20, 0, 40, 0)
      ..lineTo(size.width - 40, 0)
      ..quadraticBezierTo(size.width - 20, 0, size.width - 20, 20)
      ..lineTo(size.width - 20, size.height - 20)
      ..quadraticBezierTo(size.width - 20, size.height, size.width, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HeaderRightClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    var path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(20, size.height, 20, size.height - 20)
      ..lineTo(20, 20)
      ..quadraticBezierTo(20, 0, 40, 0)
      ..lineTo(size.width - 20, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 20)
      ..lineTo(size.width, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HeaderContainerPath extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    return Rect.fromLTRB(-10, -10, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Row(
          children: <Widget>[
            Container(
              width: 20,
              height: 300,
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _buildBody(),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: _buildHeader(),
                  )
                ],
              ),
            )
//            Expanded(

//            )
          ],
        ),
      )
    );
  }

  _buildHeader() {
    List<Function> tabOrder = [_buildLeftHeader, _buildCenterHeader, _buildRightHeader];
    Function activeOrder = tabOrder.removeAt(activeIndex);
    tabOrder = tabOrder.reversed.toList();
    tabOrder.add(_buildShadow);
    tabOrder.add(activeOrder);

    return ClipRect(
      clipper: HeaderContainerPath(),
      child: Container(
        height: 60,
        child: Stack(
          children: tabOrder.map<Widget>((fn) => fn()).toList(),
        ),
      ),
    );
  }

  _buildLeftHeader() {
    return Positioned(
      left: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeIndex = 0;
          });
        },
        child: ClipShadowPath(
          shadow: BoxShadow(color: Color(0x44333333), offset: Offset(0, 0), blurRadius: 10),
          clipper: HeaderLeftClipPath(),
          child: Container(
            width: 168,
            height: 60,
            padding: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                color: Color(0xffffffff)
            ),
            child: Center(
              child: Text('0', style: TextStyle(
                fontSize: 20
              ),),
            ),
          ),
        ),
      ),
    );
  }

  _buildCenterHeader() {
    return Positioned(
      left: 135 - 8.0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeIndex = 1;
          });
        },
        child: ClipShadowPath(
          shadow: BoxShadow(color: Color(0x44333333), offset: Offset(0, 0), blurRadius: 10),
          clipper: HeaderCenterClipPath(),
          child: Container(
            width: 187,
            height: 60,
            decoration: BoxDecoration(
                color: Color(0xffffffff)
            ),
            child: Center(
              child: Text('1', style: TextStyle(
                  fontSize: 20
              ),),
            ),
          ),
        ),
      ),
    );
  }

  _buildRightHeader() {
    return Positioned(
      left: 283 - 9.0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeIndex = 2;
          });
        },
        child: ClipShadowPath(
          shadow: BoxShadow(color: Color(0x44333333), offset: Offset(0, 0), blurRadius: 10),
          clipper: HeaderRightClipPath(),
          child: Container(
            width: 168,
            height: 60,
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: Color(0xffffffff)
            ),
            child: Center(
              child: Text('2', style: TextStyle(
                  fontSize: 20
              ),),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShadow() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 8,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color.fromRGBO(255, 255,255, 0), Color.fromRGBO(0, 0, 0, 0.1)], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
      ),
    );
  }

  _buildBody() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Color(0x44333333), offset: Offset(0, 0), blurRadius: 10)],
        color: Color(0xffffffff)
      ),
      child: Center(
        child: Text(activeIndex.toString(), style: TextStyle(
            fontSize: 30
        ),),
      ),
    );
  }
}
