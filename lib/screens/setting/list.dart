import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:mdi/mdi.dart';
import 'package:pos_app/config/palette.dart';
import 'package:pos_app/screens/setting/account/info.dart';
import 'package:pos_app/ultils/app_ultils.dart';
import 'package:pos_app/widgets/drawer/drawer.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppUltils.buildAppBar(
          height: 40,
          title: 'common.settings'.tr,
        ),
        drawer: DrawerApp(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                RowSettingItem(
                  title: 'common.common_setting'.tr,
                  icon: Icons.settings,
                ),
                InkWell(
                  onTap: () {
                    Get.to(AccountScreen());
                  },
                  child: RowSettingItem(
                    title: 'label.store_info'.tr,
                    icon: Icons.house,
                  ),
                ),
                RowSettingItem(
                  title: 'label.order_and_category'.tr,
                  icon: Mdi.cart,
                ),
                RowSettingItem(
                  title: 'label.receipt'.tr,
                  icon: Icons.receipt,
                ),
                RowSettingItem(
                  title: 'label.finance'.tr,
                  icon: FontAwesome.dollar,
                ),
                RowSettingItem(
                  title: 'Voucher'.tr,
                  icon: Mdi.cursorPointer,
                ),
                // RowSettingItem(
                //   title: 'Hoá đơn',
                //   icon: Icons.receipt,
                // )
              ],
            ),
          ),
        ));
  }
}

class RowSettingItem extends StatelessWidget {
  const RowSettingItem({Key key, this.title, this.icon}) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blueGrey,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: Palette.titleProduct(),
            ),
          ),
          Icon(
            FontAwesome.chevron_right,
            color: Colors.blueGrey,
            size: 20,
          )
        ],
      ),
    );
  }
}
