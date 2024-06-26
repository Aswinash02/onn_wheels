import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/auth_controller.dart';
import 'package:onnwheels/controllers/profile_controller.dart';
import 'package:onnwheels/models/user_info_model.dart';
import 'package:onnwheels/utils/image_directory.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/order_details/components/order_page_card.dart';
import 'package:onnwheels/views/order_details/order_details_screen.dart';
import 'package:onnwheels/views/verification/verification_page.dart';

import '../../mytheme.dart';
import '../../utils/shared_value.dart';
import '../auth/signin.dart';
import 'components/profile_list_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController profileController = Get.put(ProfileController());

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onTapLogout();
                Navigator.of(context).pop();
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> onTapLogout() async {
    SharedPreference().clearUserData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: 'Profile',
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          // actions: [
          // GestureDetector(
          //   onTap: () {},
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Icon(Icons.edit_note),
          //   ),
          // )
          // ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Obx(
                    () => Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: MyTheme.white, width: 1),
                      ),
                      child: profileController.user.value.image != null
                          ? ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(100.0)),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/placeholder.png',
                                image: profileController.user.value.image!,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Image.asset(
                              'assets/profile_placeholder.png',
                              height: 165,
                              width: 165,
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: buildUserInfo(),
                ),
                CustomListTile(
                  icons: Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: MyTheme.blue),
                    child: Center(
                      child: Image.asset(ImageDirectory.my_booking),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderCardListView()));
                  },
                  heading: const Text("My Bookings"),
                ),
                const Divider(
                  color: MyTheme.textfield_grey,
                  thickness: 2,
                ),
                CustomListTile(
                  icons: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: MyTheme.green),
                    child: Center(
                      child: Image.asset(
                        ImageDirectory.locationImage,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  onTap: () {},
                  heading: const Text("Saved Address"),
                ),
                const Divider(
                  color: MyTheme.textfield_grey,
                  thickness: 2,
                ),
                CustomListTile(
                  icons: Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: MyTheme.brick_red),
                    child: Center(
                      child: Image.asset(ImageDirectory.cancellation_image),
                    ),
                  ),
                  onTap: () {},
                  heading: const Text("Cancellation Policy"),
                ),
                const Divider(
                  color: MyTheme.textfield_grey,
                  thickness: 2,
                ),
                CustomListTile(
                  icons: Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: MyTheme.pink),
                    child: Center(
                      child: Image.asset(ImageDirectory.about_us),
                    ),
                  ),
                  onTap: () {},
                  heading: const Text("About Us"),
                ),
                const Divider(
                  color: MyTheme.textfield_grey,
                  thickness: 2,
                ),
                CustomListTile(
                  icons: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: MyTheme.orange),
                    child: Center(
                      child: Image.asset(
                        ImageDirectory.helps,
                        height: 20,
                        width: 20,
                        color: MyTheme.white,
                      ),
                    ),
                  ),
                  onTap: () {},
                  heading: const Text("Help & Support"),
                ),
                const Divider(
                  color: MyTheme.textfield_grey,
                  thickness: 2,
                ),
                CustomListTile(
                  icons: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: MyTheme.polo_blue),
                    child: Center(
                      child: Image.asset(
                        ImageDirectory.helps,
                        height: 20,
                        width: 20,
                        color: MyTheme.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(() => VerificationFlowPage());
                  },
                  heading: const Text("Verification Details"),
                ),
                const Divider(
                  color: MyTheme.textfield_grey,
                  thickness: 2,
                ),
                CustomListTile(
                  icons: Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: MyTheme.beetroot),
                    child: Center(
                      child: Image.asset(
                        ImageDirectory.log_out,
                        height: 20,
                        width: 20,
                        color: MyTheme.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    showLogoutConfirmationDialog(context);
                  },
                  heading: const Text("Log Out"),
                ),
                const Divider(
                  color: MyTheme.textfield_grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserInfo() {
    return Column(
      children: [
        Obx(
          () => Text(
            profileController.user.value.name ?? '',
            style: const TextStyle(
                fontSize: 14,
                color: MyTheme.black,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Obx(
              () => Text(
                profileController.user.value.email ?? '',
                style: const TextStyle(
                  color: MyTheme.black,
                ),
              ),
            )),
      ],
    );
  }
}
