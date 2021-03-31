import 'package:flutter/material.dart';
import 'package:pos_app/config/palette.dart';
import 'package:timeline_tile/timeline_tile.dart';

// ignore: must_be_immutable
class TimeLineStatus extends StatelessWidget {
  TimeLineStatus({
    this.iconData,
    this.iconSize,
    this.iconColor = Colors.white,
    this.hour,
    this.title,
    this.subTitle,
    this.content,
    this.isFirst = false,
    this.isLast = false,
    this.textColor = Colors.black,
    this.timelineColor = Colors.pink,
  });
  final IconData iconData;
  final double iconSize;
  final String hour;
  final String title;
  final String subTitle;
  final String content;
  final bool isLast;
  final bool isFirst;
  final Color textColor;
  final Color timelineColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.05,
      beforeLineStyle: LineStyle(color: timelineColor.withOpacity(0.7)),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.3,
        drawGap: true,
        width: 30,
        height: 30,
        indicator: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //color: timelineColor.withOpacity(.7),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    iconData,
                    size: iconSize,
                    color: iconColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isFirst: isFirst,
      isLast: isLast,
      startChild: Center(
        child: Container(
          alignment: Alignment(1.0, -1.0),
          child: Text(
            hour,
            style: TextStyle(
              fontSize: 18,
              color: textColor.withOpacity(0.6),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      endChild: Padding(
        padding: EdgeInsets.only(left: 16, right: 30, top: 10, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Palette.textStyle().copyWith(
                fontSize: 18,
                color: textColor.withOpacity(0.8),
                //fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            subTitle != null
                ? Text(
                    subTitle,
                    style: Palette.textStyle().copyWith(
                      fontSize: 15,
                      color: textColor.withOpacity(0.8),
                      //fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),

            // const SizedBox(height: 4),
            // Text(
            //   temperature,
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.white.withOpacity(0.8),
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            const SizedBox(height: 5),
            Text(
              content,
              style: Palette.textStyle().copyWith(
                fontSize: 14,
                color: textColor.withOpacity(0.6),
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _IconIndicator extends StatelessWidget {
  const _IconIndicator({
    Key key,
    this.iconData,
    this.size,
  }) : super(key: key);

  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Icon(
                iconData,
                size: size,
                color: const Color(0xFF9E3773).withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
