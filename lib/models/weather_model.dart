class WeatherModel {
  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.resolvedAddress,
    required this.address,
    required this.timezone,
    required this.tzoffset,
    required this.description,
    required this.days,
    required this.alerts,
  });
  late final double latitude;
  late final double longitude;
  late final String resolvedAddress;
  late final String address;
  late final String timezone;
  late final double tzoffset;
  late final String description;
  late final List<Days> days;
  late final List<dynamic> alerts;

  WeatherModel.fromJson(Map json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    resolvedAddress = json['resolvedAddress'];
    address = json['address'];
    timezone = json['timezone'];
    tzoffset = json['tzoffset'];
    description = json['description'];
    days = List.from(json['days']).map((e) => Days.fromJson(e)).toList();
    alerts = List.castFrom<dynamic, dynamic>(json['alerts']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['resolvedAddress'] = resolvedAddress;
    data['address'] = address;
    data['timezone'] = timezone;
    data['tzoffset'] = tzoffset;
    data['description'] = description;
    data['days'] = days.map((e) => e.toJson()).toList();
    data['alerts'] = alerts;
    return data;
  }
}

class Days {
  Days({
    required this.datetime,
    required this.datetimeEpoch,
    required this.tempmax,
    required this.tempmin,
    required this.temp,
    required this.feelslikemax,
    required this.feelslikemin,
    required this.feelslike,
    required this.dew,
    required this.humidity,
    required this.precip,
    required this.precipprob,
    required this.precipcover,
    required this.preciptype,
    required this.snow,
    required this.snowdepth,
    required this.windgust,
    required this.windspeed,
    required this.winddir,
    required this.pressure,
    required this.cloudcover,
    required this.visibility,
    required this.solarradiation,
    required this.solarenergy,
    required this.uvindex,
    required this.sunrise,
    required this.sunset,
    required this.moonphase,
    required this.conditions,
    required this.description,
    required this.icon,
    this.stations,
    required this.source,
    required this.hours,
  });
  late final String datetime;
  late final int datetimeEpoch;
  late final double? tempmax;
  late final double? tempmin;
  late final double? temp;
  late final double? feelslikemax;
  late final double? feelslikemin;
  late final double? feelslike;
  late final double? dew;
  late final double? humidity;
  late final double? precip;
  late final double? precipprob;
  late final double? precipcover;
  late final List<String> preciptype;
  late final double? snow;
  late final double? snowdepth;
  late final double? windgust;
  late final double? windspeed;
  late final double winddir;
  late final double pressure;
  late final double? cloudcover;
  late final double? visibility;
  late final double? solarradiation;
  late final double? solarenergy;
  late final double uvindex;
  late final String sunrise;
  late final String sunset;
  late final double moonphase;
  late final String conditions;
  late final String description;
  late final String icon;
  late final List<String>? stations;
  late final String source;
  late final List<Hours> hours;

  Days.fromJson(Map json) {
    datetime = json['datetime'];
    datetimeEpoch = json['datetimeEpoch'];
    tempmax = json['tempmax'];
    tempmin = json['tempmin'];
    temp = json['temp'];
    feelslikemax = json['feelslikemax'];
    feelslikemin = json['feelslikemin'];
    feelslike = json['feelslike'];
    dew = json['dew'];
    humidity = json['humidity'];
    precip = json['precip'];
    precipprob = json['precipprob'];
    precipcover = json['precipcover'];
    preciptype = List.castFrom<dynamic, String>(json['preciptype']);
    snow = json['snow'];
    snowdepth = json['snowdepth'];
    windgust = json['windgust'];
    windspeed = json['windspeed'];
    winddir = json['winddir'];
    pressure = json['pressure'];
    cloudcover = json['cloudcover'];
    visibility = json['visibility'];
    solarradiation = json['solarradiation'];
    solarenergy = json['solarenergy'];
    uvindex = json['uvindex'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonphase = json['moonphase'];
    conditions = json['conditions'];
    description = json['description'];
    icon = json['icon'];
    stations = List.castFrom<dynamic, String>(json['stations'] ?? []);
    source = json['source'];
    hours = List.from(json['hours']).map((e) => Hours.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['datetime'] = datetime;
    data['datetimeEpoch'] = datetimeEpoch;
    data['tempmax'] = tempmax;
    data['tempmin'] = tempmin;
    data['temp'] = temp;
    data['feelslikemax'] = feelslikemax;
    data['feelslikemin'] = feelslikemin;
    data['feelslike'] = feelslike;
    data['dew'] = dew;
    data['humidity'] = humidity;
    data['precip'] = precip;
    data['precipprob'] = precipprob;
    data['precipcover'] = precipcover;
    data['preciptype'] = preciptype;
    data['snow'] = snow;
    data['snowdepth'] = snowdepth;
    data['windgust'] = windgust;
    data['windspeed'] = windspeed;
    data['winddir'] = winddir;
    data['pressure'] = pressure;
    data['cloudcover'] = cloudcover;
    data['visibility'] = visibility;
    data['solarradiation'] = solarradiation;
    data['solarenergy'] = solarenergy;
    data['uvindex'] = uvindex;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['moonphase'] = moonphase;
    data['conditions'] = conditions;
    data['description'] = description;
    data['icon'] = icon;
    data['stations'] = stations;
    data['source'] = source;
    data['hours'] = hours.map((e) => e.toJson()).toList();
    return data;
  }
}

class Hours {
  Hours({
    required this.datetime,
    required this.datetimeEpoch,
    required this.temp,
    required this.feelslike,
    required this.humidity,
    required this.dew,
    required this.precip,
    required this.precipprob,
    required this.snow,
    required this.snowdepth,
    this.preciptype,
    required this.windgust,
    required this.windspeed,
    required this.winddir,
    required this.pressure,
    required this.visibility,
    required this.cloudcover,
    required this.solarradiation,
    required this.solarenergy,
    required this.uvindex,
    required this.conditions,
    required this.icon,
    required this.source,
  });
  late final String datetime;
  late final int datetimeEpoch;
  late final double? temp;
  late final double? feelslike;
  late final double? humidity;
  late final double? dew;
  late final double? precip;
  late final double? precipprob;
  late final double? snow;
  late final double? snowdepth;
  late final List<String>? preciptype;
  late final double? windgust;
  late final double? windspeed;
  late final double? winddir;
  late final double? pressure;
  late final double? visibility;
  late final double? cloudcover;
  late final double? solarradiation;
  late final double? solarenergy;
  late final double uvindex;
  late final String conditions;
  late final String icon;
  late final String source;

  Hours.fromJson(Map json) {
    datetime = json['datetime'];
    datetimeEpoch = json['datetimeEpoch'];
    temp = json['temp'];
    feelslike = json['feelslike'];
    humidity = json['humidity'];
    dew = json['dew'];
    precip = json['precip'];
    precipprob = json['precipprob'];
    snow = json['snow'];
    snowdepth = json['snowdepth'];
    preciptype = List.castFrom<dynamic, String>(json['preciptype'] ?? []);
    windgust = json['windgust'];
    windspeed = json['windspeed'];
    winddir = json['winddir'];
    pressure = json['pressure'];
    visibility = json['visibility'];
    cloudcover = json['cloudcover'];
    solarradiation = json['solarradiation'];
    solarenergy = json['solarenergy'];
    uvindex = json['uvindex'];
    conditions = json['conditions'];
    icon = json['icon'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['datetime'] = datetime;
    data['datetimeEpoch'] = datetimeEpoch;
    data['temp'] = temp;
    data['feelslike'] = feelslike;
    data['humidity'] = humidity;
    data['dew'] = dew;
    data['precip'] = precip;
    data['precipprob'] = precipprob;
    data['snow'] = snow;
    data['snowdepth'] = snowdepth;
    data['preciptype'] = preciptype;
    data['windgust'] = windgust;
    data['windspeed'] = windspeed;
    data['winddir'] = winddir;
    data['pressure'] = pressure;
    data['visibility'] = visibility;
    data['cloudcover'] = cloudcover;
    data['solarradiation'] = solarradiation;
    data['solarenergy'] = solarenergy;
    data['uvindex'] = uvindex;
    data['conditions'] = conditions;
    data['icon'] = icon;
    data['source'] = source;
    return data;
  }
}
