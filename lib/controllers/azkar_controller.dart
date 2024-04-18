import 'package:get/get.dart';
import 'package:muslim/data/azkar.dart';

class AzkarController extends GetxController{
  var index=0.obs;
  List list = [
    "اذكار الصباح",
    "اذكار المساء",
    "اذكار الاستيقاظ",
    "اذكار النوم",
    "اذكار الصلاة",
    "اذكار الوضوء",
    "اذكار المسجد",
    "اذكار الطعام",
    "اذكار المنزل",
  ], data=[];

  void initData(int i){
    data=azkar[i];
  }

  void next(){
    if (index.value < data.length - 1) {
      index.value++;
    }
  }
  void prev(){
    if (index.value>0) {
      index.value--;
    }
  }

  String getCountStr() {
    String txt = "",
        number=data[index.value]['count'];
    if (number == "1") {
      txt = "مرة واحدة";
    } else if (number == "2") {
      txt = "مرتان";
    } else {
      txt = "$number مرات";
    }
    return txt;
  }
}