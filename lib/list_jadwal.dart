import 'package:flutter/material.dart';
import 'package:jadwalsholat/model/response_jadwal.dart';
import 'package:jadwalsholat/text_style.dart';

class ListJadwal extends StatelessWidget {
  ResponseJadwal _respon;

  ListJadwal(this._respon);

  Widget containerWaktu(String waktu, String jam) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 70.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff808080), Color(0xff3fada8)])),
      child: Row(
        children: <Widget>[
          Text(waktu, style: styleListText),
          Text(jam, style: styleListText)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 25.0),
      children: <Widget>[
        containerWaktu("Subuh",
            _respon.results.datetime[0].times.Fajr.toUpperCase()),
        containerWaktu("Dzuhur",
            _respon.results.datetime[0].times.Dhuhr.toUpperCase()),
        containerWaktu("Ashar",
            _respon.results.datetime[0].times.Asr.toUpperCase()),
        containerWaktu("Magrib",
            _respon.results.datetime[0].times.Maghrib.toUpperCase()),
        containerWaktu("Isya",
            _respon.results.datetime[0].times.Isha.toUpperCase()),
      ],
    );
  }
}
