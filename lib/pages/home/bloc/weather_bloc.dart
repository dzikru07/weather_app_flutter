import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_flutter/pages/home/models/weather_detail_models.dart';
import 'package:weather_app_flutter/pages/home/models/wilayah_models.dart';

import '../view_models/home_view_models.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    WilayahViewModels servicePage = WilayahViewModels();
    on<WeatherEvent>((event, emit) async {
      try {
        emit(WeatherLoading());
        final response = await servicePage.getProvince();
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as List;
          final listData = data.map((e) => WilayahModels.fromJson(e)).toList();
          emit(WilayahLoaded(listData));
        } else {}
      } catch (e) {
        emit(WilayahError(e.toString()));
      }
    });
  }
}

class WeatherDetailBloc extends Bloc<GetWeatherDetail, WeatherState> {
  WeatherDetailBloc() : super(WeatherInitial()) {
    WilayahViewModels servicePage = WilayahViewModels();
    on<GetWeatherDetail>((event, emit) async {
      try {
        emit(WeatherLoading());
        final response = await servicePage.getDetailWeather(event.id);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as List;
          final listData = data.map((e) => WeatherModels.fromJson(e)).toList();
          await Future.delayed(Duration(milliseconds: 1500));
          emit(WeatherDetailLoaded(listData));
        } else {}
      } catch (e) {
        emit(WeatherDetailError(e.toString()));
      }
    });
  }
}
