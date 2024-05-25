import 'package:flutter/material.dart';
class CustomListTile extends StatelessWidget {
   const CustomListTile({super.key,required this.heading, required this.icons, required this.onTap});

  final Widget heading;
  final Widget icons;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: heading,
      onTap: onTap,
      textColor:Colors.black,
      leading: icons,
      trailing: const Icon(Icons.arrow_forward_ios,
        size: 20,
        color: Colors.black,),
    );
  }
}
