import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/img/empty.png',
          height: 100,
        ),
        SizedBox(
          height: 10,
        ),
        Text('Không có dữ liệu')
      ],
    );
  }
}
