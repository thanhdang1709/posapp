import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PushNotificationsManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance = PushNotificationsManager._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _initialized = false;
  GetStorage box = GetStorage();
  Future<void> init() async {
    if (!_initialized) {
      print('initial fcm');
      if (Platform.isIOS) {
        _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true),
        );
      } else {
        _firebaseMessaging.requestNotificationPermissions();
      }
      // _firebaseMessaging.requestNotificationPermissions(
      //     const IosNotificationSettings(
      //         sound: true, badge: true, alert: true, provisional: true));
      // _firebaseMessaging.onIosSettingsRegistered
      //     .listen((IosNotificationSettings settings) {
      //   print("Settings registered: $settings");
      // });

      _firebaseMessaging.subscribeToTopic('all');
      _firebaseMessaging.configure(
        onMessage: (message) async {
          Map notification;

          // if (message['notification'] == null) {
          //   notification = message['aps']['alert'];
          // } else {
          //   notification = message['notification'];
          // }
          notification = message['notification'];
          print('onMesssage: $message');

          _pushNotification(
            title: notification['title'],
            content: notification['body'],
          );

          // switch (message['msg_type']) {
          //   case 'DEVICE_APPROVED':
          //     // EventPushNotification.deviceApproved(_context, message);
          //     break;
          //   default:
          // }
          // ignore: close_sinks
          // NotificationBloc notificationBloc =
          //     BlocProvider.of<NotificationBloc>(context);
          // PagingController<int, NotificationUser> pagingController =
          //     notificationBloc.state.pagingController;
          // pagingController.itemList.insert(
          //   0,
          //   NotificationUser(
          //     id: int.tryParse(notification['id']),
          //     title: notification['title'],
          //     content: notification['body'],
          //     isSeen: false,
          //     createdAt: $Datetime
          //         .timestampToDateTime(int.tryParse(notification['created'])),
          //   ),
          // );
          // notificationBloc.add(UpdateNotificationBloc.getMoreNotifications());
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // _navigateToItemDetail(message);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // _navigateToItemDetail(message);
        },
      );
      print('initial config');

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print(token.toString());
      print("Token: $token");

      _initialized = true;
      await initNotificationService();
    }
  }

  Future initNotificationService() async {
    AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
        print('IOSInitializationSettings');
        return Container();
      },
    );
    MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _handleOpenNotify,
    );
  }

  _pushNotification({
    String title,
    String content,
  }) async {
    print(title);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      content,
      platformChannelSpecifics,
      payload: json.encode({'title': title, 'content': content}),
    );
  }

  Future _handleOpenNotify(message) async {
    // String token = await Store().getTokenFcm();
    bool isLogged = box.hasData('token');

    if (isLogged) {
      var role = box.read('role');
      // Navigator.push(
      //     _context, MaterialPageRoute(builder: (_) => NotifyListScreen()));
      if (role == 1 || role == 2 || role == 3) {
        Get.offAllNamed('order');
      }
    } else {
      // Get.offAll(BottomBarScreen(
      //   tabIndex: 2,
      // ));
      // ignore: unused_local_variable
      Map messageDecoded = json.decode(message);
    }
  }
}
