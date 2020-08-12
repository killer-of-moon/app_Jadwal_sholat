import 'package:jadwalsholat/model/datetime.dart';
import 'package:jadwalsholat/model/location.dart';
import 'package:jadwalsholat/model/settings.dart';

class Results {
  List<Datetime> datetime;
  Location location;
  Settings settings;

  Results.fromJsonMap(Map<String, dynamic> map)
      : datetime = List<Datetime>.from(
            map["datetime"].map((it) => Datetime.fromJsonMap(it))),
        location = Location.fromJsonMap(map["location"]),
        settings = Settings.fromJsonMap(map["settings"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime'] =
        datetime != null ? this.datetime.map((v) => v.toJson()).toList() : null;
    data['location'] = location == null ? null : location.toJson();
    data['settings'] = settings == null ? null : settings.toJson();
    return data;
  }
}
