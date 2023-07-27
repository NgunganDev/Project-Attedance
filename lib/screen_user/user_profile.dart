import 'dart:io';

// import 'package:attedance/authentication/auth_method.dart';
import 'package:attedance/authentication/auth_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User user = FirebaseAuth.instance.currentUser!;
  ImagePicker imagePicker = ImagePicker();
  String imgUrl = '';
  XFile? file;

  void pickImg() async {
    try {
      file = await imagePicker.pickImage(source: ImageSource.gallery);
      print('${file?.path}');
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('Profile Photos');
      Reference referenceImageToUpload = referenceDirImages.child(user.email!);
      // Reference nameDir = referenceImageToUpload.
      await referenceImageToUpload.putFile(File(file!.path));
      imgUrl = await referenceImageToUpload.getDownloadURL();
      await updatePhoto(user.email!, imgUrl);
      if (file == null) return;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        width: size.width,
        height: size.height,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(children: [
              Container(
                width: size.width,
                height: size.height * 0.16,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Color.fromARGB(255, 81, 81, 81)),
              ),
              // Positioned(
              //   top: size.height * 0.1,
              //   child: Container(
              //     width: size.width * 0.6,
              //     height: size.height * 0.1,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       color: Colors.grey
              //     ),
              //   ),
              // ),
            ]),
            SizedBox(
              height: size.height * 0.08,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  // vertical: size.height * 0.03,
                  horizontal: size.width * 0.03),
              width: size.width,
              height: size.height * 0.2,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.email!)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.data();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              pickImg();
                            },
                            child: CircleAvatar(
                                radius: size.height * 0.07,
                                backgroundColor: Colors.blue,
                                backgroundImage: data!['photoUrl'] == null
                                    ? const NetworkImage(
                                        'https://www.aquaknect.com.au/wp-content/uploads/2014/03/blank-person-500x500.jpg')
                                    : NetworkImage(data['photoUrl'])),
                          ),
                          Text(
                            // 'kiki',
                            data['username'],
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.04),
              width: size.width * 0.9,
              height: size.height * 0.12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.grey[200]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bio',
                          style: TextStyle(
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined))
                      ],
                    ),
                  ),
                  Text(
                    'Jery tong jujur bukan parlente',
                    style: TextStyle(fontSize: size.height * 0.02),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
