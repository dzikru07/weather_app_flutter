part of 'weather_bloc.dart';

@immutable
class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WilayahLoaded extends WeatherState {
  List<WilayahModels> listData;

  WilayahLoaded(this.listData);
}

class WeatherDetailLoaded extends WeatherState {
  List<WeatherModels> listData;

  WeatherDetailLoaded(this.listData);
}

class WilayahError extends WeatherState {
  String message;

  WilayahError(this.message);
}

class WeatherDetailError extends WeatherState {
  String message;

  WeatherDetailError(this.message);
}
