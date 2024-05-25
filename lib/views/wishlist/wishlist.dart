import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../mytheme.dart';
import '../home/components/custom_gridview.dart';
import '../main_page/components/custom_appbar.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: AppLocalizations.of(context)!.my_wishlist_ucf,
          backgroundColor: MyTheme.white,
          textColor: MyTheme.black),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // CustomWidget.buildCustomGridView(context),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
