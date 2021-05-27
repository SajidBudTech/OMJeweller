import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitStoreListViewItem extends StatefulWidget {
  VisitStoreListViewItem({
    Key key,
    @required this.address,
    @required this.location,
    @required this.phone,
  }) : super(key: key);

  final String address;
  final String location;
  final String phone;

  @override
  _VisitStoreListViewItemState createState() => _VisitStoreListViewItemState();
}

class _VisitStoreListViewItemState extends State<VisitStoreListViewItem> {

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(19.155001,72.849998);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  String address;
  bool isLocationAvailable = false;
  Location location = new Location();
  LocationData currentLocationData;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
       color: Colors.white,
      // margin: EdgeInsets.only(bottom: 4),
      child: Column(children: <Widget>[
        Container(
         // alignment: Alignment.topRight,
         // margin: EdgeInsets.only(top: 16),
          height: 220,
          child: GoogleMap(
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: AppPaddings.contentPaddingSize,
           right: AppPaddings.contentPaddingSize,
           top: 18,
           // vertical: 18,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            textDirection: AppTextDirection.defaultDirection,
            children: <Widget>[
              //vendor name
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                   Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.location,
                            style: AppTextStyle.h4TitleTextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.textColor(context),
                            ),
                            overflow: TextOverflow.ellipsis,
                            textDirection: AppTextDirection.defaultDirection,
                          )),
                  Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 18,bottom: 4),
                          child:
                          InkWell(
                            onTap: (){
                              address=widget.address;
                              getLocationPermissionStatus();
                            },
                            child:SvgPicture.asset("assets/images/map_direction.svg")
                          )
                  ),
                ],
              ),

              //product types and minimum order amount
             Text(
                 widget.address,
                style: AppTextStyle.h5TitleTextStyle(
                  color: AppColor.hintTextColor(context),
                  fontWeight: FontWeight.w400
                ),
                textDirection: AppTextDirection.defaultDirection,
                //overflow: TextOverflow.ellipsis,
              ),
              Container(
                  margin: EdgeInsets.only(top: 4),
                  child:Row(
                children: [
                  Text(
                    "Phone No: ",
                    style: AppTextStyle.h5TitleTextStyle(
                        color: AppColor.hintTextColor(context),
                        fontWeight: FontWeight.w400
                    ),
                    textDirection: AppTextDirection.defaultDirection,
                    //overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.phone,
                    style: AppTextStyle.h5TitleTextStyle(
                        color: AppColor.textColor(context),
                        fontWeight: FontWeight.w500
                    ),
                    textDirection: AppTextDirection.defaultDirection,
                    //overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
              UiSpacer.verticalSpace(space: 20),
              UiSpacer.divider(thickness: 1,color: Color(0xFFD3D3D3)),
              UiSpacer.verticalSpace(space: 20),

              //UiSpacer.divider(thickness: 0.5,color: AppColor.hintTextColor(context)),
            ],
          ),
        ),
      ]),
    );
    // );
  }


  void launchMap() async {
    currentLocationData = await location.getLocation();
    String url = 'https://www.google.com/maps/dir/?api=1&origin' +
        currentLocationData.latitude.toString() +
        "," +
        currentLocationData.longitude.toString() +
        '=&destination={$address}&travelmode=driving&dir_action=navigate';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void getLocationPermissionStatus() async {
    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      isLocationAvailable = true;
      launchMap();
    } else {
      requestLocationPermission();
    }
  }

//request location permission
  void requestLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        isLocationAvailable = false;
        launchMap();
      } else {
        isLocationAvailable = true;
        launchMap();
      }
    } else {
      launchMap();
    }
  }
}
