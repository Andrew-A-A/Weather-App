
class WeatherInfo{
 Current current;
   WeatherInfo({
    required this.current
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      current: Current.fromJson(json['current'])
    );
  }
}

class Current{
double temp;
Condition condition;
double feelsLike;
String windDirection;
Current({required this.temp, required this.condition,required this.feelsLike,required this.windDirection});
factory Current.fromJson(Map<String, dynamic> json){
  return Current(
      temp: json['temp_c'],
      condition: Condition.fromJson(json['condition']),
      feelsLike: json['feelslike_c'],
      windDirection: json['wind_dir']
  );
}
}

class Condition{
  String text;
Condition({required this.text});
factory Condition.fromJson(Map<String, dynamic> json){
  return Condition(
   text: json['text']
  );
}
}

