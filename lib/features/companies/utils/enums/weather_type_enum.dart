enum WeatherTypeEnum {
  Thunderstorm,
  Drizzle,
  Rain,
  Snow,
  Clear,
  Clouds,
  other,
}

extension WeatherTypeEnumExtension on String? {
  WeatherTypeEnum? toWeatherType() {
    WeatherTypeEnum? value;
    switch (this) {
      case 'Thunderstorm':
        value = WeatherTypeEnum.Thunderstorm;
        break;
      case 'Drizzle':
        value = WeatherTypeEnum.Drizzle;
        break;
      case 'Snow':
        value = WeatherTypeEnum.Snow;
        break;
      case 'Rain':
        value = WeatherTypeEnum.Rain;
        break;
      case 'Clear':
        value = WeatherTypeEnum.Clear;
        break;
      case 'Clouds':
        value = WeatherTypeEnum.Clouds;
        break;
      default:
        value = WeatherTypeEnum.other;
        break;
    }
    return value;
  }
}
