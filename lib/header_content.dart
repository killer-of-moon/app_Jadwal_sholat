import 'package:flutter/material.dart';
import 'package:jadwalsholat/model/response_jadwal.dart';
import 'package:jadwalsholat/text_style.dart';

class HeaderContent extends StatelessWidget {
  ResponseJadwal respon;

  HeaderContent(this.respon);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20.0,
      bottom: 20.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            respon.results.location.city,
            style: styleCityHeader,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.white,
                size: 20.0,
              ),
              Text(
                respon.results.location.country,
                style: styleAddressHeader,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              )
            ],
          )
        ],
      ),
    );
  }
}
