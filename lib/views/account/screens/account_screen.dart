import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/models/user_provider.dart';
import 'package:auto_ecole_app/views/account/screens/edit_profile_screen.dart';
import 'package:auto_ecole_app/views/account/services/account_service.dart';
import 'package:flutter/material.dart';
import 'package:auto_ecole_app/common/animations/slide_down_tween.dart';
import 'package:auto_ecole_app/common/widgets/custom_button_box.dart';
import 'package:auto_ecole_app/common/widgets/custom_heading.dart';
import 'package:auto_ecole_app/common/widgets/custom_place_holder.dart';
import 'package:auto_ecole_app/common/widgets/custom_title.dart';
import 'package:auto_ecole_app/constants/colors.dart';
import 'package:auto_ecole_app/constants/padding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';


class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void logOut(BuildContext context) {
    AccountService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
        GetStorage box = GetStorage();

        User? user = box.read('connectedUser');

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
     body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            children: [
              const SizedBox(
                height: spacer,
              ),
              SlideDownTween(
                offset: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHeading(
                        title: "Compte",
                        subTitle: user?.type == "moniteur" ? "Moniteur" : "Student",
                        color: secondary),
                    Padding(
                      padding: const EdgeInsets.only(top: 65, left: 65),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                        child: IconButton(
                            onPressed: () {
                                      Get.offAll(() => const EditProfileScreen());

                            },
                            hoverColor: primary,
                            icon: const Icon(
                              Icons.edit,
                              color: textBlack,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: spacer,
              ),
              user?.image_url != null
                  ? SlideDownTween(
                      offset: 10,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Hero(
                          tag: 'profile-photo',
                          child: Image.network(
                            user!.image_url,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : CunstomPlaceHolder(title: "Profile Placeholder"),
              const SizedBox(
                height: spacer - 40,
              ),
              SlideDownTween(
                offset: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTitle(
                      title: user!.nom.toUpperCase(),
                      extend: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: spacer - 40,
              ),
              const SizedBox(
                height: spacer,
              ),
              const SlideDownTween(
                offset: 30,
                child: CustomTitle(
                  title: "Paramètre",
                  extend: false,
                ),
              ),
              const SizedBox(
                height: spacer - 25,
              ),
              SlideDownTween(
                offset: 30,
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CunstomPlaceHolder(title: "A propos de nous"),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: spacer - 30,
              ),
              GestureDetector(
                onTap: () {
                  logOut(context);
                },
                child: const SlideDownTween(
                  offset: 30,
                  child: CustomButtonBox(title: "Se déconnecter"),
                ),
              ),
              const SizedBox(
                height: spacer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}