import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:muslim/controllers/shared.dart';
import 'package:muslim/widgets/app_bar.dart';
import 'package:muslim/widgets/text.dart';
import '../controllers/videos_controller.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  double w=Get.width>370?Get.width*0.65:Get.width*0.7;
  double h=Get.height*0.25;
  final videosController=Get.put(VideosController());
  @override
  void initState() {
    if(videosController.videos.isEmpty){
      videosController.getData();
    }
    super.initState();
  }
  @override
  void dispose() {
    videosController.disposeVideos();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingController.bodyColor.value,
      appBar: appBar(name: "مقتطفات"),
      body: Obx(() =>
      videosController.dbItems.isNotEmpty? Stack(
        children: [
          ListView.builder(
              padding: EdgeInsets.only(bottom: 15.h),
              controller: videosController.scroller,
              itemCount: videosController.videos.length,
              itemBuilder: (context,i){
                Video video = videosController.videos[i];
                return Container(
                    width: w, height: 220.h,
                    decoration: BoxDecoration(
                      color: settingController.darkMode.isFalse?const Color(0xffdddddd):
                        settingController.boxColor.value,
                      borderRadius: BorderRadius.circular(20.r)
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(h*0.125),
                      //     bottomRight:Radius.circular(h*0.125) )
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: Get.width*0.05),
                    child: video.controller!=null? Stack(
                      children: [
                        // VideoPlayer(video.controller!),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Expanded(
                            // aspectRatio: w/200.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: VideoPlayer(video.controller!)),
                          ),
                        ),
                        Positioned(
                          left: 0,bottom: 0,right: 0,
                          child: Container(
                            height: 45.h,
                            padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
                            // margin: EdgeInsets.symmetric(horizontal: w*0.04),
                            decoration: BoxDecoration(
                              color: settingController.mainColor.value.withOpacity(0.6),
                              // borderRadius: BorderRadius.circular(h*0.125)
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r)
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(onTap: ()async{
                                  // print(Get.width);
                                  setState(() {
                                    if (video.controller != null && video.controller!.value.isPlaying) {
                                      videosController.pauseVideo(i);
                                    } else {
                                      videosController.playVideos(i);
                                    }
                                  });
                                }, child:
                                // video.controller == null?Icon(Icons.play_arrow,size: 30,color: txtColor.value,):
                                Obx(() => Icon(video.playing.isTrue? Icons.pause:Icons.play_arrow,size: 30,color: Colors.white))
                                ),
                                Container(width: w*0.9-(80.w),
                                    padding: EdgeInsets.only(right: 2.w,bottom: 2.h),
                                    child:video.controller != null?
                                    VideoProgressIndicator(
                                      video.controller!,
                                      allowScrubbing: true,
                                      colors:VideoProgressColors(
                                        playedColor: settingController.mainColor.value,
                                        bufferedColor: Colors.grey,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ): const LinearProgressIndicator(value: 0)),
                                // Obx(() =>Txt(video.progress.value,Colors.white, FontWeight.w500, 18.sp,noResize: true))
                                Obx(() =>TextWidget(
                                  text: video.progress.value,
                                  color:Colors.white,
                                  fontSize :18.sp,
                                  noResize: true)
                                )
                              ],
                            )
                          )
                        ),
                      ],
                    ):Center(
                      child: GestureDetector(
                        onTap: ()async{
                          setState(() =>videosController.playVideos(i));
                        },
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: settingController.bodyColor.value,
                          child: Icon(
                            Icons.play_arrow,size: 50.w,
                            color: settingController.darkMode.isFalse?const Color(0xff333333)
                             :settingController.txtColor.value,
                          ),
                        ),
                      ),
                    )
                );
              }),
          Positioned(
            bottom: 10.h,right: 0,left: 0,
            child: videosController.loading.isFalse?const SizedBox(height: 0,):
            const Center(child: CircularProgressIndicator())
          )
        ],
      ):videosController.loading.isTrue?
      const Center(child: CircularProgressIndicator()):
      Center(child: TextWidget(
        text: videosController.online.isTrue?"لاتوجد بيانات":"لايوجد اتصال بالانترنت",
        fontSize: 20.sp)
      ))
    );
  }
}
