import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:muslim/controllers/quran_controller.dart';
import '../helpers/internet_conn.dart';

class VideosController extends GetxController{
  var fileUrls = [].obs,
      loading=false.obs,
      online=true.obs,
      progress=0.0.obs,
      totalDuration=0.obs,
      playing=0.obs, //not playing
      playedDur="".obs,
      lastUrl="".obs,
      totalVideoLength=0.obs;
  QuranController audioController=QuranController();

  RxList<Video> videos = <Video>[].obs;
  RxList<Reference> dbItems=<Reference>[].obs;
  // RxMap videos1={}.obs;
  var scroller=ScrollController();

  onScroll(){
    if(scroller.position.pixels==scroller.position.maxScrollExtent) {
      if (loading.isFalse && videos.length < dbItems.length) {
         getData();
      }
    }
  }

  getData() async {
    loading.value=true;
    online.value=await InternetConnection.connected();
    if(online.isTrue){
     if(dbItems.isEmpty){
       // how to order items by recent date,flutter firebase
       FirebaseStorage storage = FirebaseStorage.instance;
       Reference storageRef = storage.ref();
       ListResult listResult = await storageRef.listAll();
       List<Reference> items = listResult.items;
       List<Map<String, dynamic>> itemsWithTimeCreated = [];
       for (final item in items) {
         final FullMetadata metadata = await item.getMetadata();
         final timeCreated = metadata.timeCreated;
         itemsWithTimeCreated.add({
           'item': item,
           'timeCreated': timeCreated,
         });
       }
       itemsWithTimeCreated.sort((a, b) => b['timeCreated'].compareTo(a['timeCreated']));
       dbItems.value = itemsWithTimeCreated.map<Reference>((item) => item['item']).toList();
     }
      int remain=dbItems.length-videos.length;
      int len = remain>4?4:remain;
      List<Reference> sublist = dbItems.sublist(videos.length, videos.length+len);

      for (var item in sublist) {
        String downloadUrl = await item.getDownloadURL();
        videos.add(Video(url: downloadUrl, playing: false.obs,progress: "00:00".obs));
      }

      if(videos.isNotEmpty){
       if(videos[0].controller==null){
         initializeVideo(0);
       }
      }

      scroller.addListener(onScroll);
    }
    loading.value=false;
  }


  void initializeVideo(int index) {
    final video = videos[index];
    video.controller = VideoPlayerController.network(video.url);
    video.controller!.initialize().then((_) {
      Duration dur=video.controller!.value.duration;
      String durTxt=audioController.getDuration(dur.inMilliseconds);
      video.progress.value=durTxt;
      video.controller!.addListener(() {
        if(video.controller!.value.position == video.controller!.value.duration){
          video.playing.value=false;
          video.progress.value=durTxt;
        }else{
          video.playing.value=video.controller!.value.isPlaying;
          if(video.playing.isTrue){
            Duration remaining=dur-video.controller!.value.position;
            video.progress.value=audioController.getDuration(remaining.inMilliseconds);
          }
        }
      });
      update();
    });
  }

  void playVideos(int index) {
    final video = videos[index];
    if (video.controller == null) {
     initializeVideo(index);
    }
    video.controller!.play();
  }

  void pauseVideo(int index) {
    final video = videos[index];
    if (video.controller != null) {
      video.controller!.pause();
    }
  }

  void disposeVideos() {
    for(int i=0;i<videos.length;i++){
      final video = videos[i];
      if (video.playing.isTrue) {
        pauseVideo(i);

      }
    }

  }

}
class Video {
  final String url;
  Rx<String> progress;
  Rx<bool> playing;

  VideoPlayerController? controller;

  Video({required this.url,required this.playing,required this.progress});
}