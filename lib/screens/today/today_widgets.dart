import 'package:flutter/material.dart';
import 'package:open_weather_api/shared/variables.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:sizer/sizer.dart';
class TodayWidgets extends StatelessWidget {
  String title;
  String value;
  String current_day;
  IconData weather_icon;
  TodayWidgets({this.weather_icon, this.value, this.title, this.current_day});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BoxedIcon(weather_icon, size: 25.sp,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: grey18RegularTextStyle,),
            Row(
              children: [
                Text(value, style: black14SemiBoldTextStyle.copyWith(fontWeight: FontWeight.w700),),
                SizedBox(width: 5.w,),
                Text(current_day == null ? '' : current_day, style: black14SemiBoldTextStyle.copyWith(color: Colors.blue),),
              ],
            )
          ],
        )
      ],
    );
  }
}
