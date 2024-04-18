import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran/surah_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muslim/data/qur3a.dart';
import 'package:muslim/helpers/internet_conn.dart';
import 'package:muslim/widgets/pop_up.dart';
import '../helpers/notification.dart';

class QuranController extends GetxController{

  AudioPlayer audioPlayer=AudioPlayer();

  var loading=false.obs,
      playing=false.obs,
      openAudioBox=false.obs,
      tapIndex=0.obs,
      surahIndex=0.obs,
      surahName="الفاتحة".obs,
      surahNo="1".obs,
      audioLink="".obs,
      sheikhName="".obs,
      sheikhIndex=0.obs,
      progress=0.0.obs,
      currentPosition=0.obs,
      totalDuration=0.obs,
      time="00:00".obs,
      current = 1.obs,
      seconds = 0.obs,
      val=0.0.obs,
      progressList =[].obs,
      downloading=false.obs,
      downloadClicked=false.obs;

  Timer? timer;
  var timerDuration = const Duration().obs, playedDur = "00:00".obs;

  final quranUrl="https://download.quranicaudio.com/quran/";


  saveIndex(int i)async{
    surahIndex.value=i;
    var prefs=await SharedPreferences.getInstance();
    prefs.setInt("quranPageIndex", surahIndex.value);
  }
  getIndex()async{
    var prefs=await SharedPreferences.getInstance();
    surahIndex.value=prefs.getInt("quranPageIndex")??0;
  }

  Map getSurahData(int surahIndex){
    Map data=surah[surahIndex]??{};
    data["type"]=surah[surahIndex]['place']=="Makkah"?"مكية":"مدنية";
    return data;
  }

  String getSurahNo(int id){
    String result="001";
    if(id<10) {
      result="00$id";
    } else if(id<100 && id>=10) {
      result="0$id";
    } else {
      result="$id";
    }
    return result;
  }
  saveSurah({required String name, required int id}){
    if(surahName.value != name){
      surahName.value = name;
      surahNo.value = getSurahNo(id);
      if(playing.isTrue){
        playing.value=false;
        audioPlayer.stop();
      }
      initLink();
    }
  }

  String getNames(bool firstPageInSurah){
    List pageData=quran.getPageData(surahIndex.value+1);
    if(pageData.length==1){
      if(firstPageInSurah){
        return "";
      }else {
        return quran.getSurahNameArabic(pageData[0]['surah']);
      }
    }else if(pageData.length==2){
      String name1=quran.getSurahNameArabic(pageData[0]['surah']),
          name2=quran.getSurahNameArabic(pageData[1]['surah']) ;
      return "$name1 - $name2";
    }else{
      String name1=quran.getSurahNameArabic(pageData[0]['surah']),
          name2=quran.getSurahNameArabic(pageData[2]['surah']) ;
      return "$name1 : $name2";
    }
  }
  String convertNum(int verseNumber) {
    var arabicNumeric = '';
    var digits = verseNumber.toString().split("").toList();

    for (var e in digits) {
      if (e == "0") {
        arabicNumeric += "٠";
      }
      if (e == "1") {
        arabicNumeric += "۱";
      }
      if (e == "2") {
        arabicNumeric += "۲";
      }
      if (e == "3") {
        arabicNumeric += "۳";
      }
      if (e == "4") {
        arabicNumeric += "٤";
      }
      if (e == "5") {
        arabicNumeric += "۵";
      }
      if (e == "6") {
        arabicNumeric += "٦";
      }
      if (e == "7") {
        arabicNumeric += "۷";
      }
      if (e == "8") {
        arabicNumeric += "۸";
      }
      if (e == "9") {
        arabicNumeric += "۹";
      }
    }

    return arabicNumeric;
  }

  //*****************************Audio
  initLink()async {
    String link = "https://${qur3a[sheikhIndex.value]['url'] + '/' + surahNo.value}.mp3";
    if (audioLink.value != link) {
      sheikhName.value = qur3a[sheikhIndex.value]['name'];
      // audioName.value = "${surahName.value}-${qur3a[sheikhIndex.value]['name']}";
      time.value = "00:00";
      playedDur.value = "00:00";
      progress.value = 0;
      audioPlayer.stop();
      audioLink.value = link;
      // await start();
    }
  }

  start()async{
    bool connected=await InternetConnection.connected();
    if(connected) {
      loading.value=true;
      stopTimer();
      await audioPlayer.play(audioLink.value);
      playing.value=true;
      loading.value=false;
      audioPlayer.onPlayerCompletion.listen((event){
        playing.value=false;
        progress.value=0.0;
      });
      audioPlayer.onDurationChanged.listen((Duration duration) {
        totalDuration.value=duration.inMilliseconds;
        time.value=getDuration(duration.inMilliseconds);
      });
      audioPlayer.onAudioPositionChanged.listen((Duration duration) {
        currentPosition.value=duration.inMilliseconds;
        progress.value=currentPosition.value / totalDuration.value;
        playedDur.value =getDuration(duration.inMilliseconds);
      });

    }else {
      popUp("يرجي الاتصال بالانترنت للاستماع للقران");
    }
  }

  play()async{
    if(loading.isFalse){
      if(audioPlayer.state==PlayerState.STOPPED){
        await start();
      }else if(audioPlayer.state==PlayerState.PLAYING){
        playing.value=false;
        await audioPlayer.pause();
      }else {
        playing.value=true;
        await audioPlayer.resume();
      }
    }
  }

  changeSurah(int id){
    surahNo.value=getSurahNo(id);
    surahName.value=quran.getSurahNameArabic(id);
    initLink();
    start();
  }
  nextSurah(){
    print(surahNo.value);
    int newId=int.parse(surahNo.value)+1;
    if(newId<115){
      changeSurah(newId);
    }
  }
  prevSurah(){
    int newId=int.parse(surahNo.value)-1;
    if(newId>0){
      changeSurah(newId);
    }
  }

  void seekAudioPosition(double val) {
    Duration newPosition = Duration(milliseconds: (val * totalDuration.value).round());
    audioPlayer.seek(newPosition);
    playedDur.value =getDuration(newPosition.inMilliseconds);
  }

  playedDuration() {
    if (seconds.value > 0 && current.value < seconds.value) {
      current.value += 1;
      val.value = ((current / seconds.value * 100) / 100).toDouble();
    } else {
      timer?.cancel();
      current.value = 0;
      val.value = 0;
    }
  }

  getDuration(totalDuration) {
    Duration newDur = Duration(milliseconds: totalDuration);
    if(newDur.inHours>=1){
      int hours = newDur.inHours,
          minutes = newDur.inMinutes.remainder(60),
          seconds = newDur.inSeconds.remainder(60);
      return "$hours:$minutes:$seconds";
    }else{
      double duration=totalDuration.toDouble() / 1000;
      final int minutes = (duration / 60).truncate();
      final int seconds = (duration % 60).round();
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }

  double currentProgress(int index) {
    try {
      return progressList[index];
    } catch (e) {
      progressList.add(0.0);
      return 0;
    }
  }

  Future<void> downloadMP3(String url, String name,int index) async {
    downloadClicked.value=true;
    bool connected=await InternetConnection.connected();
    if(connected) {
      bool hasPermission = await checkPermission();
      if (!hasPermission) {
        checkPermission().then((value) {
          hasPermission = value;
        });
      } else {
        String savePath = "";
        if (Platform.isAndroid) {
          savePath = '/sdcard/download/$name.mp3';
        } else if (Platform.isIOS) {
          final documentsDir = await getApplicationDocumentsDirectory();
          savePath = '${documentsDir.path}/$name';
        }

        final directory = Directory(dirname(savePath));
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
          // print('Directory created: ${directory.path}');
        } else {
          // print('Directory already exists: ${directory.path}');
        }
        if (savePath.isNotEmpty) {
          Dio dio=Dio();
          // dio.close(force: true);
          try {
            //when app is terminated the data shown in notification didn't updated
            dio.download(url, savePath,
                onReceiveProgress: ((count, total) async {
                  downloading.value=true;
                  // final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await Future.delayed(const Duration(seconds: 1), () {
                    int progress=((count / total) * 100).toInt();
                    // prefs.setInt("progress", progress);
                    NotificationHelper.initInfo();
                    if(count==total){
                      downloading.value=false;
                    }
                    NotificationHelper.createNotification(100, progress,total==count?'تم التحميل':'جاري التحميل',name);
                    // progressList[index] = (count / total);

                  });
                }));
          } catch (e) {
            popUp("عفوا حدث خطا ما");
          }
        }
      }
    }else {
      popUp("يرجي الاتصال بالانترنت ");
    }
    downloadClicked.value=false;
  }

  reset() {
    timerDuration.value = const Duration();
  }

  Future<bool> checkPermission() async {
    PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted) {
      var permission = await Permission.storage.request();
      if (permission == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }

    return false;
  }
  void addTime() {
    const addSeconds = 1;
    final seconds = timerDuration.value.inSeconds + addSeconds;
    if (seconds < 0) {
      timer?.cancel();
    } else {
      timerDuration.value = Duration(seconds: seconds);
    }
  }

  void startTimer({bool resets = true}) {
    if (resets) reset();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) reset();
    timer?.cancel();
  }
}
