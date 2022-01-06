import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/advertisment_banner.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/banner.viewmodel.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_outline_button.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/data/models/appointment.dart';
import 'package:flutter_om_jeweller/data/models/datetime.arguments.dart';
import 'package:flutter_om_jeweller/bloc/appointment.bloc.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppointmentSlider extends StatefulWidget {
 // final Function(AdvertismentBanner) onBannerTapped;
  final List<Appointment> appointments;
  MyAppointmentSlider({@required this.appointments, Key key}) : super(key: key);

  @override
  _MyAppointmentSliderState createState() => _MyAppointmentSliderState();
}

class _MyAppointmentSliderState extends State<MyAppointmentSlider> {

  AppointmentBloc _appointmentBloc = AppointmentBloc();
  String address;
  bool isLocationAvailable = false;
  Location location = new Location();
  LocationData currentLocationData;

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CarouselSlider(
                items: _getPageSliders(widget.appointments,context),
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  aspectRatio: 1/1.4,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ],
          ),
        );
     }

  int _current = 0;
  String currentdate=DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime newDate=DateTime.now();
  List<Widget> _getPageSliders(List<Appointment> appointments, BuildContext context) {



    return appointments
        .map((appointment) {
          int days=DateFormat("yyyy-MM-dd").parse(currentdate).difference(DateTime.parse(appointment.appointmentDate)).inDays;
          bool reshedule=false;
          DateTime currentSheduleDate=DateFormat("yyyy-MM-dd hh:mm aa").parse(appointment.appointmentDate+" "+appointment.appointmentTime);
          if(isCurrentDateIsAfter(newDate, currentSheduleDate)) {
            reshedule=true;
          }
          return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded(child:
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text(
                        days.isNegative ?
                        "In " + (days).toString().replaceAll("-", "") + " days" :
                        (days==0? "Today" :
                       "From " + days.toString() + " days"),
                    style: AppTextStyle.h4TitleTextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor(context),
                    ),
                    overflow: TextOverflow.ellipsis,
                    textDirection: AppTextDirection.defaultDirection,
                  )),
              //),
              //Expanded(child:
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 13),
                  child: Text(
                    "In " + appointment.appointmentType +
                        " appointment at Om Jewellers - " +
                        appointment.appointmentDetail,
                    style: AppTextStyle.h16TitleTextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.textColor(context),
                    ),
                    textDirection: AppTextDirection.defaultDirection,
                  )),
              //),
              // Expanded(child:
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/my_app_cal.svg',
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        DateFormat("MMMM dd").format(
                            DateFormat("yyyy-MM-dd").parse(
                                appointment.appointmentDate)),
                        style: AppTextStyle.h5TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                        textDirection: AppTextDirection.defaultDirection,
                      ))
                ],
              ),
              UiSpacer.verticalSpace(space: 13),
              Visibility(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/my_app_time.svg',
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            appointment.appointmentTime,
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                            textDirection: AppTextDirection.defaultDirection,
                          ))
                    ],
                  )
              ),
              //),
              /* Expanded(
           child:*/
              UiSpacer.verticalSpace(space: 13),
              Visibility(
                  visible: appointment.appointmentType == "Store Visit",
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SvgPicture.asset(
                        'assets/images/dra_visit.svg',
                      ),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                appointment.appointmentDetail == "Borivali"
                                    ? _appointmentBloc.storeaddresses[0]
                                    : _appointmentBloc.storeaddresses[1],
                                style: AppTextStyle.h5TitleTextStyle(
                                    color: AppColor.textColor(context),
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                                textDirection: AppTextDirection
                                    .defaultDirection,
                              ))
                      ),
                    ],
                  )
              ),
              // ),
              UiSpacer.verticalSpace(space: 3),
              Visibility(
                  visible: appointment.appointmentType == "Store Visit",
                  child: Container(
                      padding: EdgeInsets.only(left: 22),
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        child: Text(
                          'Directions',
                          style: AppTextStyle.h5TitleTextStyle(
                              color: AppColor.accentColor,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                          textDirection: AppTextDirection.defaultDirection,
                        ),
                        onTap: () {
                          address = appointment.appointmentDetail == "Borivali"
                              ? _appointmentBloc.storeaddresses[0]
                              : _appointmentBloc.storeaddresses[1];
                          getLocationPermissionStatus();
                        },
                      ))
              ),
              UiSpacer.verticalSpace(space: 13),
              Visibility(
                  visible: appointment.appointmentType == "Store Visit",
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/my_app_call.svg',
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            appointment.appointmentDetail == "Borivali"
                                ? _appointmentBloc.storePhone[0]
                                : _appointmentBloc.storePhone[1],
                            style: AppTextStyle.h5TitleTextStyle(
                                color: AppColor.textColor(context),
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                            textDirection: AppTextDirection.defaultDirection,
                          ))
                    ],
                  )),
              UiSpacer.verticalSpace(space: 24),
              Container(
                alignment: Alignment.topLeft,
                child: CustomOutlineButton(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  width: 143,
                  borderColor: (days>0 || (days==0 && reshedule))?AppColor.hintTextColor(context):AppColor.accentColor,
                  title: "Reschedule",
                  onPressed: () {
                    if(days>0|| (days==0 && reshedule)) {

                    }else{
                      Navigator.pushNamed(
                        context,
                        AppRoutes.dateTimeRoute,
                        arguments: DateTimeArguments(
                            appointment: appointment,
                            status: false
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          )

        /*    ClipRRect(
          */ /*borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),*/ /*
          child: InkWell(
            onTap: () => widget.onBannerTapped(banner),
            child: Image(
              image: AssetImage(banner.image),
              //imageUrl: banner.image,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),*/
      );
    }).toList();

  }

  bool isCurrentDateIsAfter(DateTime newCurrent,DateTime currentDate) {
    return newCurrent.compareTo(currentDate) > 0 ;
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
