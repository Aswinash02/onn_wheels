import 'package:flutter/material.dart';

import '../../../mytheme.dart';

class AppBars {
  AppBar customAppBar(
      {title, backgroundColor, textColor, setLeading, List<Widget>? actions}) {
    return AppBar(
      leading: setLeading,
      backgroundColor: backgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      actions: actions,
    );
  }
}
