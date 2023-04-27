part of 'weather_bloc.dart';

@immutable
class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetDataWilayah extends WeatherEvent {}

class GetWeatherDetail extends WeatherEvent {
  String id;

  GetWeatherDetail(this.id);
}
