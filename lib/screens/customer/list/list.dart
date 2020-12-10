import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pos_app/config/pallate.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class CustomerScreen extends StatefulWidget {
  CustomerScreen({Key key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUltils.buildAppBar(
        // leading: Icon(Mdi.menu),
        height: 40,
        title: 'Khách hàng (0)',
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('customer/add');
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      drawer: new DrawerApp(),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, size: 35),
                        border: InputBorder.none,
                        hintText: 'Tìm tên hoặc thông tin liên hệ'))),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: List.generate(
                    10,
                    (index) => RowContactItem(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowContactItem extends StatelessWidget {
  const RowContactItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cao Thanh Dang',
            style: Pallate.titleProduct(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('chưa có giao dịch', style: TextStyle(color: Colors.grey)),
              Icon(
                FontAwesome.chevron_right,
                size: 10,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
