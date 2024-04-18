import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/widgets/text.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = SizedBox(height: 32.h);
    const errorColor = Color(0xffb00020);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size: 150,
            color: errorColor,
          ),
          box,
          TextWidget(text: error!,color: errorColor,fontSize: 18.sp,),
          box,
          ElevatedButton(
            child: TextWidget(text: "اعادة المحاولة",color: Colors.white,fontSize: 16.sp,),
            onPressed: () {
              if (callback != null) callback!();
            }
          )
        ],
      ),
    );
  }
}