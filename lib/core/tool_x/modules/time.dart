part of '../tool_x.dart';

extension Time on ToolX {
  setTimeout(Function callback, int timeout) => Future.delayed(Duration(milliseconds: timeout), callback);
  setInterval(Function callback, int timeout) => Timer.periodic(Duration(milliseconds: timeout), callback);
}
