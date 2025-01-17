import 'package:flutter/material.dart';

import '../mytheme.dart';
import '../utils/shared_value.dart';
import 'box_decorations.dart';


class AuthScreen {
  static Widget buildScreen(
      BuildContext context, String headerText, Widget child) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        //key: _scaffoldKey,
        //drawer: MainDrawer(),
        backgroundColor: Colors.white,
        //appBar: buildAppBar(context),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              color: MyTheme.accent_color,
              alignment: Alignment.topRight,
              // child: Image.asset(
              //   "assets/background_1.png",
              // ),
            ),
            CustomScrollView(
              //controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(top: 48.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                  color: MyTheme.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.asset('assets/app_logo.png'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                        child: Text(
                          headerText,
                          style: const TextStyle(
                              color: MyTheme.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration:
                              BoxDecorations.buildBoxDecoration_1(radius: 16),
                          child: child,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

