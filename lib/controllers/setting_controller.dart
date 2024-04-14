import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController{
  var mainColor = const Color(0xff367c98).obs,
      bodyColor = Colors.white.obs,
      boxColor = Colors.white.obs,
      txtColor = Colors.black.obs,
      fontVal = 0.obs,
      fontSize = 23.0.obs,
      shadowColor = const Color(0x00000000),
      darkMode = false.obs;

  List fontOptions = [
    {"text":"حجم صغير","val":-4},
    {"text":"حجم متوسط","val":0},
    {"text":"حجم كبير","val":5},
  ];

  initializeVars() async {
    var prefs=await SharedPreferences.getInstance();
    darkMode.value=prefs.getBool("darkMode")??false;
    fontVal.value=prefs.getInt("font")??0;
    if (darkMode.isTrue) {
      boxColor.value = const Color(0xff26273b);
      bodyColor.value = const Color(0xff1b1c31);
      txtColor.value = Colors.white;
      darkMode.value = true;
    }
  }

  saveFont()async{
    var prefs=await SharedPreferences.getInstance();
    prefs.setInt("font", fontVal.value);
  }

  saveMode()async{
    var prefs=await SharedPreferences.getInstance();
    prefs.setBool("darkMode", darkMode.value);
  }

  toggleTheme() {
    if (darkMode.value) {
      boxColor.value = Colors.white;
      bodyColor.value = const Color(0xffededed);
      txtColor.value = Colors.black;
      darkMode.value = false;
    } else {
      boxColor.value = const Color(0xff26273b);
      bodyColor.value = const Color(0xff1b1c31);
      txtColor.value = Colors.white;
      darkMode.value = true;
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  mailLauncher(){
    Get.back();
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',path: "kamlaa_saad888@yahoo.com",
      query: encodeQueryParameters(<String, String>{'subject': 'Hello from zakr app!'}),
    );
    launchUrl(emailLaunchUri);
  }

  goToRateApp()async{
    Get.back();
    String url="https://play.google.com/store/apps/details?id=com.kamla.awrady";
    var result=await canLaunchUrl(Uri.parse((url)));
    if (result) {
      await launchUrl(Uri.parse((url)));
    }
  }
}
