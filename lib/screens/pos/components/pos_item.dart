import 'package:flutter/material.dart';
import 'package:pos_app/screens/pos/components/add_new_card_item.dart';
import 'package:pos_app/screens/pos/components/grid_item.dart';
import 'package:pos_app/screens/pos/components/pos_action_row.dart';

class TabPosItem extends StatefulWidget {
  const TabPosItem({
    Key key,
  }) : super(key: key);

  @override
  _TabPosItemState createState() => _TabPosItemState();
}

class _TabPosItemState extends State<TabPosItem>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  int count = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    //PosController _posController = new PosController(context: context);
    //print('re build $_scale');
    final Size size = MediaQuery.of(context).size;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: PosActionRow(),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.8,
            controller: new ScrollController(keepScrollOffset: true),
            scrollDirection: Axis.vertical,
            children: _buildCardItem(
                size: size, color: Colors.orange, controller: _controller),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Transform.scale(
          scale: _scale,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.cyan,
            ),
            width: size.width - 20,
            padding: EdgeInsets.all(7),
            margin: EdgeInsets.all(0),
            child: Center(
                child: Text(
              '$count Item = 0 vnd',
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
          ),
        ),
      )
      // SizedBox(
      //   height: size.height * .3,
      // )
    ]);
  }

  List<Widget> _buildCardItem({size, color, controller}) {
    return [
      CardFoodGridItem(
        size: size,
        color: Colors.orange,
        title: 'Gà rán',
        price: 15000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.blue,
        title: 'Cà phê',
        price: 1000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.green,
        title: 'Trà sữa',
        price: 25000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.green,
        title: 'Trà sữa',
        price: 25000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.blue,
        title: 'Trà sữa',
        price: 25000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.pink,
        title: 'Trà sữa',
        price: 25000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.cyan,
        title: 'Trà sữa',
        price: 25000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.black,
        title: 'Trà sữa',
        price: 25000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.yellow,
        title: 'Trà sữa',
        price: 25000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      CardFoodGridItem(
        size: size,
        color: Colors.red,
        title: 'Trà sữa',
        price: 25000,
        imageUrl:
            'https://i.pinimg.com/736x/60/de/7f/60de7f8fc369c1f4b023360c3c0f279a.jpg',
        onPressed: () {
          setState(() {
            count += 1;
          });
          bounceButtonAction(controller);
          //print('hello');
        },
      ),
      AddNewCardItem()
    ];
  }
}

bounceButtonAction(controller) {
  controller.forward();
  Future.delayed(Duration(milliseconds: 100), () {
    controller.reverse();
  });
}
