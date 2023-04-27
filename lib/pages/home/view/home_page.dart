import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:unicons/unicons.dart';
import 'package:weather_app_flutter/component/format/time_format.dart';
import 'package:weather_app_flutter/component/local/id_local_data.dart';
import 'package:weather_app_flutter/style/color.dart';

import '../bloc/weather_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.id, Key? key}) : super(key: key);

  String id;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc()..add(GetDataWilayah()),
          ),
          BlocProvider(
            create: (context) => WeatherDetailBloc()..add(GetWeatherDetail(id)),
          ),
        ],
        child: HomeBloc(
          id: id,
        ),
      ),
    );
  }
}

class HomeBloc extends StatefulWidget {
  HomeBloc({required this.id, super.key});
  String id;

  @override
  State<HomeBloc> createState() => _HomeBlocState();
}

class _HomeBlocState extends State<HomeBloc> {
  var categoryValue;
  int mainIndex = 0;

  @override
  Widget build(BuildContext context) {
    // bloc
    WeatherBloc getProvinceBloc = context.read<WeatherBloc>();
    WeatherDetailBloc getDetailBloc = context.read<WeatherDetailBloc>();

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    var dropdownButton = BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WilayahLoaded) {
          int index =
              state.listData.indexWhere((element) => element.id == widget.id);
          if (categoryValue == null) {
            categoryValue = state.listData[index].id;
          }
          return Container(
            child: DropdownButton<String>(
              dropdownColor: bgColor,
              value: categoryValue,
              elevation: 16,
              isExpanded: true,
              icon: const Icon(
                UniconsLine.angle_down,
                color: Colors.transparent,
              ),
              underline: Container(
                height: 0,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  categoryValue = value!;
                  mainIndex = 0;
                  SetDataLocal().setDataIDProv(categoryValue);
                  getDetailBloc.add(GetWeatherDetail(categoryValue.toString()));
                });
              },
              items: state.listData.map((value) {
                return DropdownMenuItem(
                  value: value.id,
                  child: Center(
                    child: Text(
                      value.kota,
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );

    return SafeArea(
      bottom: false,
      child: BlocBuilder<WeatherDetailBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherDetailLoaded) {
            return Scaffold(
              backgroundColor: bgColor,
              bottomNavigationBar: Container(
                height: _height / 2.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: _width,
                      height: 110,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/wave_accent.png'),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      height: _height / 4.3,
                      width: _width,
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: state.listData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  mainIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: 15, bottom: 15, top: 10),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          state.listData[index].tempC,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                        Icon(
                                          UniconsLine.celsius,
                                          color: Colors.grey,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      FormatData()
                                          .getDataFormat(
                                              state.listData[index].jamCuaca)
                                          .toString(),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 40,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(state
                                                          .listData[index]
                                                          .kodeCuaca ==
                                                      "1"
                                                  ? 'assets/logo/sun_cloud.png'
                                                  : state.listData[index]
                                                              .kodeCuaca ==
                                                          "95"
                                                      ? 'assets/logo/thunder_cloud.png'
                                                      : state.listData[index]
                                                                      .kodeCuaca ==
                                                                  "61" ||
                                                              state
                                                                      .listData[
                                                                          index]
                                                                      .kodeCuaca ==
                                                                  "60"
                                                          ? 'assets/logo/rain_cloud.png'
                                                          : 'assets/logo/cloud.png'),
                                              fit: BoxFit.fill)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 25),
                        child: dropdownButton),
                    Container(
                      margin: EdgeInsets.only(right: 55),
                      width: _width / 1.5,
                      height: 180,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(state
                                          .listData[mainIndex].kodeCuaca ==
                                      "1"
                                  ? 'assets/logo/sun_cloud.png'
                                  : state.listData[mainIndex].kodeCuaca == "95"
                                      ? 'assets/logo/thunder_cloud.png'
                                      : state.listData[mainIndex].kodeCuaca ==
                                                  "61" ||
                                              state.listData[mainIndex]
                                                      .kodeCuaca ==
                                                  "60"
                                          ? 'assets/logo/rain_cloud.png'
                                          : 'assets/logo/cloud.png'),
                              fit: BoxFit.fill)),
                    ),
                    // BlocBuilder<WeatherDetailBloc, WeatherState>(
                    //   builder: (context, state) {
                    //     return Text(state.toString());
                    //   },
                    // ),
                    Text(
                      state.listData[mainIndex].cuaca,
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white.withOpacity(0.2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "suhu : ",
                                style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Row(
                                children: [
                                  Text(
                                    state.listData[mainIndex].tempC,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Icon(
                                    UniconsLine.celsius,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kelembapan : ",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                state.listData[mainIndex].humidity,
                                style: GoogleFonts.montserrat(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Suhu (F) : ",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        state.listData[mainIndex].tempF,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      Icon(
                                        UniconsLine.fahrenheit,
                                        color: Colors.white,
                                        size: 10,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Suhu (C) : ",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        state.listData[mainIndex].tempC,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      Icon(
                                        UniconsLine.celsius,
                                        color: Colors.white,
                                        size: 10,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child:
                        LoadingAnimationWidget.beat(color: bgColor, size: 35)),
              ),
            );
          }
        },
      ),
    );
  }
}
