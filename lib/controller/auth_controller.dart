import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raktoo/views/auth/login/login.dart';
import 'package:raktoo/views/auth/profile_set_up/profile_set_up.dart';
import 'package:raktoo/views/home/home.dart';

class AuthController extends GetxController {
  RxString email = RxString('');
  RxString password = RxString('');
  RxString cPassword = RxString('');
  RxString fullName = RxString('');
  RxString address = RxString('');
  RxString phoneNumber = RxString('');
  RxBool isLoading = RxBool(false);

  var selectedImage = File('').obs;
  late String image_url = "";

  final formKey = GlobalKey<FormState>();
  final setupFormKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  //=================== sign up ====================

  signUp() async {
    if (formKey.currentState!.validate()) {
      if (password.value != cPassword.value) {
        Get.snackbar(
          "Invalid Password",
          "Password & Confirm Password doesn't matched",
        );
        return;
      }

      isLoading.value = true;
      update();

      try {
        await auth
            .createUserWithEmailAndPassword(
          email: email.value,
          password: password.value,
        )
            .then(
          (value) {
            isLoading.value = false;
            update();
            if (value.user != null) {
              Get.to(() => const ProfileSetUp());
            }
          },
        );
      } on FirebaseAuthException catch (error) {
        isLoading.value = false;
        update();
        Get.snackbar('Error', error.message ?? 'Something is wrong');

        print('Error is ${error.message}');
      }
    }
  }

  //=================== Profile setup ====================

  pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
      update();
      // userModel.value.profilePicture = selectedImage.value.path;
    } else {
      print('No image selected.');
    }
  }

  profileSetUp() async {
    isLoading.value = true;
    update();

    final token = await FirebaseMessaging.instance.getToken();

    // UploadTask uploadTask = ref.putData(selectedImage.value);

    try {
      Reference ref = _storage.ref().child(selectedImage.value.path);
      UploadTask task = ref.putFile(selectedImage.value);
      TaskSnapshot snapshot = await task;
      image_url = await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('error occurred');
    }

    await FirebaseFirestore.instance.collection('Users').doc(email.value).set({
      'email': email.value,
      'full_name': fullName.value,
      'address': address.value,
      'phone_number': phoneNumber.value,
      'token': token,
      'image_link': image_url,
    });

    isLoading.value = false;
    update();
    Get.offAll(() => const Home());
  }

//=================== log in ====================

  signIn() async {
    isLoading.value = true;
    update();

    try {
      auth
          .signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      )
          .then(
        (value) {
          isLoading.value = false;
          update();
          if (value.user != null) {
            Get.offAll(() => const Home());
          }
        },
      );

      // getToken();
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      update();
      Get.snackbar("Error", error.message ?? "Something is wrong");
      print("Error is ${error.message}");
    }
  }

  signOut() {
    auth.signOut();
    Get.offAll(() => const Login());
  }

  getToken() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference reference = firestore.collection("User");
    QuerySnapshot snapshot = await reference.get();
    for (var doc in snapshot.docs) {
      print(doc.data());
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print(data['token']);
    }
  }
}
