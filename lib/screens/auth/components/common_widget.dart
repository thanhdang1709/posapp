import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class FindOutLogo extends StatelessWidget {
  final double fontSize;

  const FindOutLogo({
    Key key,
    this.fontSize = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fontSize * 4,
      child: Hero(
        tag: 'logo',
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Align(
                // alignment: Alignment.centerLeft,
                // child: Text(
                //   'pos',
                //   style: GoogleFonts.poppins(
                //       fontWeight: FontWeight.w700,
                //       fontSize: fontSize,
                //       color: Colors.white),
                // ),
                child: Image.asset(
                  'assets/img/logo.png',
                  height: 80,
                ),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   heightFactor: .3,
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: <Widget>[
              //       Icon(FontAwesome.mobile,
              //           size: fontSize * .7, color: Colors.orange),
              //       Text(
              //         'app',
              //         style: GoogleFonts.poppins(
              //             height: .4,
              //             fontWeight: FontWeight.w700,
              //             fontSize: fontSize,
              //             color: Colors.white),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class FindOutHorizontalLogo extends StatelessWidget {
  final double fontSize;

  const FindOutHorizontalLogo({
    Key key,
    this.fontSize = 28.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: fontSize,
        shadows: [
          Shadow(
            color: Colors.white,
            blurRadius: 10,
          )
        ]);
    return Hero(
      tag: 'horizontal_logo',
      child: Material(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Text('pos', style: TextStyle(color: Colors.white)),
            Icon(
              FontAwesome.search,
              size: fontSize * .8,
              color: Colors.pinkAccent,
            ),
            Text(
              'app',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class TitlePlace extends StatelessWidget {
  const TitlePlace({
    Key key,
    @required this.place,
    this.baseFontSize = 40,
  }) : super(key: key);

  final Place place;
  final double baseFontSize;

  @override
  Widget build(BuildContext context) {
    var typePlace;
    return Hero(
      tag: place.title,
      child: Material(
        color: Colors.transparent,
        child: RichText(
          overflow: TextOverflow.fade,
          text: TextSpan(
              text: place.typePlace,
              style: GoogleFonts.poppins(
                fontSize: baseFontSize * .6,
              ),
              children: [
                TextSpan(
                    text: '\n' + place.title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        fontSize: baseFontSize))
              ]),
        ),
      ),
    );
  }
}

class Place {
  final String title;
  final String typePlace;
  Place({this.title, this.typePlace});
}
