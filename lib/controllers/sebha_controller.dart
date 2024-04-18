import 'package:get/get.dart';

class SebhaController extends GetxController{
  var zkrIndex=0.obs,
      counter = 0.obs,
      syghaNo=3.obs,
      zkr="سبحان الله عدد خلقه ورضا نفسه وزنة عرشة ومداد كلماته".obs,
      sygh=[].obs,
      azkar = [
        'سبحان الله ',
        'سبحان الله وبحمده',
        'سبحان الله وبحمده سبحان الله العظيم ',
        'الحمد لله',
        'لا اله الا الله',
        'الله اكبر',
        'لاحول ولا قوة الا بالله',
        'استغفر الله العظيم',
        'لا اله الا انت سبحانك اني كنت من الظالمين',
        'لا اله الا الله وحده لاشريك له له الملك وله الحمد يحي ويميت وهو علي كل شئ قدير',
        'اللهم صل وسلم علي سيدنا محمد'],
      sygh1=[
        "لاشئ",
        "عدد كمال الله وكما يليق بكماله",
        "عدد ماذكره الذاكرون وغفل عن ذكره الغافلون",
        "عدد خلقه ورضا نفسه وزنة عرشة ومداد كلماته",
        "عدد ماخلق وملء ماخلق",
        "عدد مااحصي كتابه وملء مااحصي كتابه",
        " عدد مافي السموات والارض وملء مافي السموات والارض",
        " عدد كل شئ وملء كل شئ"],
      sygh2=[
        "لاشئ",
        "عدد كمال الله وكما يليق بكماله",
        "عدد ماذكرك الذاكرون وغفل عن ذكرك الغافلون",
        "عدد خلقك ورضا نفسك وزنة عرشك ومداد كلماتك",
        "عدد ماخلقت وملء ماخلقت",
        "عدد مااحصي كتابك وملء مااحصي كتابك",
        " عدد مافي السموات والارض وملء مافي السموات والارض",
        " عدد كل شئ وملء كل شئ"
      ];

  @override
  onInit(){
    sygh.value=sygh1;
    super.onInit();
  }

  chooseZikr(int i){
    zkrIndex.value = i;
    sygh.value=zkrIndex<8?sygh1:sygh2;
    String txt=(syghaNo.value==0||(zkrIndex.value!=9&&syghaNo.value==8))?"":sygh[syghaNo.value];
    zkr.value="${azkar[zkrIndex.value]} $txt";
  }

  addElnabyZikr(){
    if(zkrIndex.value==10){
      if(!sygh.contains("الصيغة الابراهيمية")) {
        sygh.add("الصيغة الابراهيمية");
      }
    }else{
      sygh.remove("الصيغة الابراهيمية");
    }
  }

  changeSygh(int i){
    syghaNo.value = i;
    String txt="";
    if(sygh[i]=="الصيغة الابراهيمية"&&zkrIndex.value==10){
      txt="اللهم صل وبارك علي محمد واله كما صليت وباركت علي ابراهيم واله انك حميد مجيد";
      zkr.value=txt;
    }else{
      txt=syghaNo.value==0?"":sygh[syghaNo.value];
      zkr.value="${azkar[zkrIndex.value]} $txt";
    }
  }
}