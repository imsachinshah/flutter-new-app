import 'package:flutter/material.dart';


class Stamp extends StatefulWidget {


  const Stamp(this.imageUrl, {this.width = 150.0, this.locked = false, required this.onClick});

  final bool withStartAnimation = false;
  final String imageUrl;

  final double width;

  final double aspectRatio = 1.5333333;

  final double relativeHoleRadius = 1.0;

  final bool locked;

  final VoidCallback onClick;

  @override
  State<StatefulWidget> createState() => _StampState();

}


class _StampState extends State<Stamp> with SingleTickerProviderStateMixin{

//  AnimationController animationController;
  late Animation animation;


  @override
  void initState() {
    super.initState();
  //  animationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 1000));

 //   animation  = new Tween(begin: 0.0, end: 4.0).animate(animationController);

 //   animationController.forward();

  }


  @override
  Widget build(BuildContext context) {


    var width  = widget.width;
    var height = widget.width * widget.aspectRatio;

    var holeRadius = widget.relativeHoleRadius * (width / 10.0);

    Widget result =  GestureDetector(
      onTap: widget.onClick,
      child: Container(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(width, height)),
            child: Material(
              elevation: 8.0,
              color: Colors.transparent,
              child: Center(
                child: _clippedNetwork(context, width, height, holeRadius),
              ),
            ),
          ),
        ),
      ),
    );



    return result;

  }

  Widget _clippedV1(BuildContext context, double card_width, double card_height) {
    return ClipPath(
      clipper: StampClipper(),
      child: Image.asset("assets/test_img.jpg",
        width: card_width,
        height: card_height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _clippedNetwork(BuildContext context, double card_width, double card_height, double holeRadius) {
    List<Widget> stackChildren = [];

    stackChildren.add(
        Image.network(widget.imageUrl,
          width: card_width,
          height: card_height,
          fit: BoxFit.cover,
    ));

    if(widget.locked) {
      stackChildren.add(
          Container(
            color: const Color(0xbb000000),
            width: card_width,
            height: card_height,
          ));
      stackChildren.add(const Align(alignment: Alignment.center,child: Icon(Icons.lock, color: Colors.white,)));
    }



    return ClipPath(
      clipper: StampClipper(holeRadius: holeRadius),
      child: Container(
        color: Colors.white,
        child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: stackChildren
            )
        ),
      ),
    );
  }

  Widget _clippedNetwork2(BuildContext context, double card_width, double card_height) {
    return Container(
      color: Colors.white,
      child: Align(
          alignment: Alignment.topCenter,
          child: Image.network(widget.imageUrl,
            width: card_width,
            height: card_height,
            fit: BoxFit.cover,
          )
      ),
    );
  }

  Widget _clippedV2(BuildContext context, double card_width, double card_height) {
    return ClipPath(
      clipper: StampClipper(),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/test_img.jpg",
                  width: card_width,
                  height: card_height- 30.0,
                  fit: BoxFit.cover,
                )
            ),
            const Text("Elon Musk", style: TextStyle(fontSize: 20.0),),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }


}

class StampClipper extends CustomClipper<Path> {


  StampClipper({this.holeRadius = 15.0});


  final holeRadius;

  @override
  Path getClip(Size size) {
    Path path = Path();

    int num = (size.width / holeRadius).round();

    double radius;
    if(num % 2 == 0) {
      num++;
    }
    radius = size.width / num;

    for(int i = 0; i < num / 2 - 1; i++) {
      path.relativeLineTo(radius, 0.0);
      path.relativeArcToPoint(Offset(radius, 0.0), radius: Radius.circular(radius / 2), clockwise: false);
    }
    path.relativeLineTo(radius, 0.0);


    int numVert = (size.height / radius).round();
    for(int i = 0; i < numVert / 2 - 1; i++) {
      path.relativeLineTo(0.0, radius);
      path.relativeArcToPoint(Offset(0.0, radius), radius: Radius.circular(radius / 2), clockwise: false);
    }
    path.relativeLineTo(0.0, radius);


    for(int i = 0; i < num / 2 - 1; i++) {
      path.relativeLineTo(-radius, 0.0);
      path.relativeArcToPoint(Offset(-radius, 0.0), radius: Radius.circular(radius / 2), clockwise: false);
    }
    path.relativeLineTo(-radius, 0.0);

    for(int i = 0; i < numVert / 2 - 1; i++) {
      path.relativeLineTo(0.0, -radius);
      path.relativeArcToPoint(Offset(0.0, -radius), radius: Radius.circular(radius / 2), clockwise: false);
    }
    path.relativeLineTo(0.0, -radius);


    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return holeRadius != holeRadius;
  }
}