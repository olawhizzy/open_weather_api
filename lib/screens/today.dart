import 'package:flutter/material.dart';
import 'package:open_weather_api/models/currentWeatherModel.dart';
import 'package:open_weather_api/models/oneCallApiModel.dart' as one;
import 'package:open_weather_api/screens/today/today_widgets.dart';
import 'package:open_weather_api/services/getClass.dart';
import 'package:open_weather_api/shared/variables.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';
class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  String city;
  String description;
  double temp;
  Future<CurrentWeatherModel> _getCurrentModel;
  Future<one.OneCallApiModel> _getcurrentOnecallapi;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getCurrentModel = getClass().getCurrentWeather('new delhi');
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
          //return Text(snapshot.data.name);
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: _buildBoxImage(),
                  expandedHeight: 60.h,
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
                        padding: EdgeInsets.symmetric(vertical:5.h, horizontal: 6.w),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TodayWidgets(
                                  weather_icon: WeatherIcons.thermometer,
                                  title: 'Feel like',
                                  value: '${snapshot.data.current.feelsLike}',
                                  current_day: 'Today',
                                ),
                                TodayWidgets(
                                  weather_icon: WeatherIcons.raindrops,
                                  title: 'Humidity',
                                  value: '${snapshot.data.current.humidity} %',
                                  current_day: '',
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TodayWidgets(
                                  weather_icon: WeatherIcons.strong_wind,
                                  title: 'Wind',
                                  value: '${snapshot.data.current.windSpeed} km/h',
                                  current_day: '',
                                ),
                                TodayWidgets(
                                  weather_icon: WeatherIcons.day_sunny,
                                  title: 'UV Index',
                                  value: '${snapshot.data.current.uvi}',
                                  current_day: '',
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ])
                )
              ],
            ),
          );
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }


  //Image container
  Widget _buildBoxImage(){
    return Container(
      //height: 50.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/desert.jpeg'),
                fit: BoxFit.cover
            )
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
              SizedBox(height: 20.h,),
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
