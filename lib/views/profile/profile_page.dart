import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/utils/image_directory.dart';
import 'package:onnwheels/views/verification/verification_page.dart';

import '../../mytheme.dart';
import '../../utils/shared_value.dart';
import '../auth/signin.dart';
import '../main_page/main_page.dart';
import 'components/profile_list_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 165,
                  height: 165,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: MyTheme.white, width: 1),
                    //shape: BoxShape.rectangle,
                  ),
                  child: is_logged_in.$
                      ? ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100.0)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: "${avatar_original.$}",
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
                onTap: () {},
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
                  Get.to(()=>VerificationFlowPage());
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
                  if (is_logged_in.$) {
                    onTapLogout(context);
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }
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
    );
  }

  onTapLogout(context) async {
    // AuthHelper().clearUserData();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return Login();
    }), (route) => false);
  }

  Widget buildUserInfo() {
    return is_logged_in.$
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${user_name.$}",
                style: const TextStyle(
                    fontSize: 14,
                    color: MyTheme.black,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    //if user email is not available then check user phone if user phone is not available use empty string
                    user_email.$ != ""
                        ? user_email.$
                        : user_phone.$ != ""
                            ? user_phone.$
                            : '',
                    style: const TextStyle(
                      color: MyTheme.black,
                    ),
                  )),
            ],
          )
        : const Text(
            "Login/Registration",
            style: TextStyle(
                fontSize: 14,
                color: MyTheme.black,
                fontWeight: FontWeight.bold),
          );
  }
}
