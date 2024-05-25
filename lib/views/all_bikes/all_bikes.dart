import 'package:flutter/material.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import '../../mytheme.dart';
import '../home/components/custom_gridview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllBikesPage extends StatefulWidget {
  const AllBikesPage({super.key});

  @override
  State<AllBikesPage> createState() => _AllBikesPageState();
}

class _AllBikesPageState extends State<AllBikesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: AppLocalizations.of(context)!.all_bikes,
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
