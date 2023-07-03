import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_parck/constants/user_data.dart';

import '../../localization/localization_const.dart';
import '../../pages/profile/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = Name??'';
    mobileController.text = phone??"";
    emailController.text = email??"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: scaffoldBgColor,
        titleSpacing: 0.0,
        shadowColor: shadowColor.withOpacity(0.25),
        foregroundColor: lightBlackColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          getTranslation(context, 'edit_profile.edit_profile'),
          style: bold18LightBlack,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          userProfileImage(size),
          heightSpace,
          heightSpace,
          heightSpace,
          nameField(context),
          heightSpace,
          heightSpace,
          mobileField(context),
          heightSpace,
          heightSpace,
          emailField(context),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          updateButton(context),
        ],
      ),
    );
  }

  updateButton(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update(
          {
            'email':emailController.text,
            'name':nameController.text,
            'phone':mobileController.text,
            'uid':FirebaseAuth.instance.currentUser?.uid,
          }
        ).then((value) {
          print('update sucsses ');
          getUserData();
        }).catchError((e){
          print('faild to update => $e');
        });

      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(fixPadding * 1.4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [buttonShadow],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslation(context, 'edit_profile.update'),
          style: bold18LightBlack,
        ),
      ),
    );
  }

  emailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'edit_profile.email_address'),
          style: semibold16LightBlack,
        ),
        heightSpace,
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [boxShadow],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: primaryColor)),
            child: TextField(
              controller: emailController,
              cursorColor: primaryColor,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: fixPadding * 1.5, horizontal: fixPadding * 2),
                border: InputBorder.none,
                hintText:
                    getTranslation(context, 'edit_profile.enter_email_address'),
                hintStyle: semibold15Grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  nameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'edit_profile.name'),
          style: semibold16LightBlack,
        ),
        heightSpace,
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [boxShadow],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: primaryColor)),
            child: TextField(
              controller: nameController,
              cursorColor: primaryColor,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: fixPadding * 1.5, horizontal: fixPadding * 2),
                border: InputBorder.none,
                hintText: getTranslation(context, 'edit_profile.enter_name'),
                hintStyle: semibold15Grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  mobileField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslation(context, 'edit_profile.mobile_number'),
          style: semibold16LightBlack,
        ),
        heightSpace,
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [boxShadow],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: primaryColor)),
            child: TextField(
              controller: mobileController,
              cursorColor: primaryColor,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: fixPadding * 1.5, horizontal: fixPadding * 2),
                border: InputBorder.none,
                hintText:
                    getTranslation(context, 'edit_profile.enter_mobile_number'),
                hintStyle: semibold15Grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  userProfileImage(Size size) {
    return Center(
      child: SizedBox(
        height: size.height * 0.155,
        width: size.height * 0.15,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.15,
              width: size.height * 0.15,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("$image"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            languageValue == 4
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        changePhotoBottomSheet(size);
                      },
                      child: Container(
                        height: size.height * 0.045,
                        width: size.height * 0.045,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: [boxShadow],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 18,
                          color: lightBlackColor,
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        changePhotoBottomSheet(size);
                      },
                      child: Container(
                        height: size.height * 0.045,
                        width: size.height * 0.045,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: [boxShadow],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 18,
                          color: lightBlackColor,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  changePhotoBottomSheet(Size size) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTranslation(context, 'edit_profile.change_photo'),
                style: bold18LightBlack,
              ),
              heightSpace,
              heightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  imageChangeOption(
                      context,
                      size,
                      Icons.camera_alt,
                      getTranslation(context, 'edit_profile.camera'),
                      const Color(0xFF1E4799)),
                  imageChangeOption(
                      context,
                      size,
                      Icons.photo,
                      getTranslation(context, 'edit_profile.gallery'),
                      const Color(0xFF1E996D)),
                  imageChangeOption(
                      context,
                      size,
                      CupertinoIcons.delete_solid,
                      getTranslation(context, 'edit_profile.remove_image'),
                      const Color(0xFFEF1717)),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  imageChangeOption(BuildContext context, Size size, icon, title, color) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Container(
            height: size.height * 0.07,
            width: size.height * 0.07,
            decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.25),
                  blurRadius: 6,
                )
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: color,
            ),
          ),
          heightSpace,
          Text(
            title,
            style: medium15LightBlack,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
