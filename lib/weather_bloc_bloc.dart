import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather/weather.dart';
import 'package:wether_app/data/my_data.dart';

import 'package:wether_app/weather_bloc_event_bloc.dart';
import 'package:wether_app/weather_bloc_states_bloc.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(apiKey, language: Language.ENGLISH);
        Position position = await Geolocator.getCurrentPosition();

        Weather weather = await wf.currentWeatherByLocation(
          position.latitude,
          position.longitude,
        );
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
