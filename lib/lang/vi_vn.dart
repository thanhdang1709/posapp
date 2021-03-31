import 'package:pos_app/lang/vi/account.dart';
import 'package:pos_app/lang/vi/auth.dart';
import 'package:pos_app/lang/vi/common.dart';
import 'package:pos_app/lang/vi/dialog.dart';
import 'package:pos_app/lang/vi/label.dart';
import 'package:pos_app/lang/vi/notify.dart';
import 'package:pos_app/lang/vi/report.dart';
import 'package:pos_app/lang/vi/time.dart';
import './plugins.dart';

Map<String, String> viVN = loadLanguages({
  'common': commonLabels,
  'auth': authLabels,
  'account': accountLabels,
  'time': timeLabels,
  'label': localLables,
  'dialog': dialogLabels,
  'notify': notifyLabels,
  'report': reportLabels,
});
