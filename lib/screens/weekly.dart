import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_api/screens/today/today_widgets.dart';
import 'package:open_weather_api/services/getClass.dart';
import 'package:open_weather_api/shared/variables.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:open_weather_api/models/oneCallApiModel.dart' as one;

class Weekly extends StatefulWidget {
  @override
  _WeeklyState createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  Future<one.OneCallApiModel> _getcurrentOnecallapi;
  String city;
  String description;
  double temp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getcurrentOnecallapi = getClass().getCurrentWeatherOneCallApi(3.75, 6.5833);
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<one.OneCallApiModel>(
      future: _getcurrentOnecallapi,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          city = 'Lagos';
          description = snapshot.data.current.weather.first.description as String;
          temp = snapshot.data.current.temp;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: _buildBoxImage(),
                  expandedHeight: 40.h,
                  pinned: true,
                  collapsedHeight: 200,
                  leading: Icon(Icons.menu),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right:5.w),
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        padding: EdgeInsets.symmetric(vertical:0.0.h, horizontal: 3.w),
                        height: 50.h,
                        child: ListView.builder(
                          itemCount: snapshot.data.daily.length,
                          itemBuilder: (context, index){
                            var item = snapshot.data.daily[index];
                            int timeInMillis = item.dt * 1000;
                            var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
                            var formattedDate = DateFormat.EEEE().format(date);
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 1.2.h),
                              child: Row(
                                children: [
                                  BoxedIcon(WeatherIcons.day_thunderstorm, size: 20.sp,),
                                  SizedBox(width: 3.w,),
                                  Text('${formattedDate.substring(0, 3)}', style: grey14MediumTextStyle,),
                                  SizedBox(width: 3.w,),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: '${temp}',
                                              style: TextStyle(color: Colors.black, fontSize: 12.sp)),
                                          WidgetSpan(
                                            child: Transform.translate(
                                              offset: const Offset(2, -5),
                                              child: Text(
                                                'O ',
                                                //superscript is usually smaller in size
                                                textScaleFactor: 0.7,
                                                style: TextStyle(color: Colors.black, fontSize: 9.sp, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                      Text('/'),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: '${temp}',
                                              style: TextStyle(color: Colors.black, fontSize: 12.sp)),
                                          WidgetSpan(
                                            child: Transform.translate(
                                              offset: const Offset(2, -5),
                                              child: Text(
                                                'O ',
                                                //superscript is usually smaller in size
                                                textScaleFactor: 0.7,
                                                style: TextStyle(color: Colors.black, fontSize: 9.sp, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                  //Text('${item.temp.day}/${item.temp.night}', style: grey14MediumTextStyle,),
                                  SizedBox(width: 3.w,),
                                  Expanded(child: Text('${item.weather.first.description}', style: grey14MediumTextStyle,overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ])
                )
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }
    );
  }


  //Image container
  Widget _buildBoxImage(){
    return Container(
      //height: 50.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff2A3551),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 15.h, right: 5.w, left: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(city, style: white26SemiBoldTextStyle,),
                      Text('${DateFormat.yMMMMEEEEd().format(DateTime.now())}', style: white12SemiBoldTextStyle,),
                      SizedBox(height: 5.h,),
                      Text('${description}', style: white12SemiBoldTextStyle,),
                    ],
                  ),
                  BoxedIcon(WeatherIcons.storm_showers, size: 50.sp,color: Colors.white,),
                  //FaIcon(FontAwesomeIcons.),
                ],
              ),
              SizedBox(height: 5.h,),
              //Text('${temp} \u2103', style: white26SemiBoldTextStyle.copyWith(fontSize: 40.sp, fontWeight: FontWeight.normal),),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '${temp}',
                      style: TextStyle(color: Colors.white, fontSize: 40.sp)),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(2, -20),
                      child: Text(
                        '\u2103',
                        //superscript is usually smaller in size
                        textScaleFactor: 0.7,
                        style: TextStyle(color: Colors.white, fontSize: 35.sp),
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        )
    );
  }
}
