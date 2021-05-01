import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/listItem/store_location_listitem.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/widgets/verticaltabs/verticaltab.dart';
import 'package:flutter_om_jeweller/widgets/listItem/sort_listview_item.dart';
import 'package:flutter/gestures.dart';

class FilterProductPage extends StatefulWidget {
  FilterProductPage({
    Key key,
  }) : super(key: key);

  @override
  _FilterProductPageState createState() => _FilterProductPageState();
}

class _FilterProductPageState extends State<FilterProductPage> {
  LoginBloc _loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Container(
              color: AppColor.newprimaryColor,
              child:SafeArea(
              child:Column(mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                UiSpacer.verticalSpace(),
                Row(children: [
                    Expanded(
                        flex: 8,
                        child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(
                                left: AppPaddings.contentPaddingSize,
                                right: AppPaddings.contentPaddingSize),
                            //padding: EdgeInsets.only(),
                            child: Text(
                              'Filter',
                              style: AppTextStyle.h2TitleTextStyle(
                                  color: AppColor.textColor(context),
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                              textDirection: AppTextDirection.defaultDirection,
                            ))),
                    Expanded(
                        flex: 2,
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: 'Clear all',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('The button is clicked!');
                                },
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColor.accentColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.accentColor,
                              )),
                        ])))
                  ],
                ),
                UiSpacer.verticalSpace(),
                UiSpacer.divider(
                    thickness: 0.3, color: AppColor.hintTextColor(context)),
                Container(
                  padding: EdgeInsets.only(
                      left: AppPaddings.contentPaddingSize,
                      right: AppPaddings.contentPaddingSize),
                  height: 360,
                  child: VerticalTabs(
                    tabsWidth: 150,
                    indicatorColor: AppColor.accentColor,
                    direction: TextDirection.ltr,
                    selectedTabBackgroundColor: AppColor.appBackground(context),
                    unselectedTabBackgroundColor: AppColor.newprimaryColor,
                    contentScrollAxis: Axis.vertical,
                    changePageDuration: Duration(milliseconds: 500),
                    tabs: <Tab>[
                      Tab(
                          child:
                          Text(
                        'Category',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )
                      ),
                      Tab(child:
                      Text(
                        'Price',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )),
                      Tab(child:  Text(
                        'Collections',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )
                      ),
                      Tab(child:  Text(
                        'Products',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )),
                      Tab(child:  Text(
                        'Offers',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )),
                      Tab(child:  Text(
                        'Purity',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )),
                    ],
                    contents: <Widget>[
                      tabsContent('Flutter', 'www.fluttertutorial.in'),
                      tabsContent('Dart'),
                      tabsContent('NodeJS'),
                      tabsContent('PHP'),
                      tabsContent('PHP'),
                      tabsContent('PHP'),
                    ],
                  ),
                ),
                 Container(
                   color: AppColor.appBackground(context),
                     padding: EdgeInsets.only(
                         top: AppPaddings.contentPaddingSize,
                         bottom: AppPaddings.contentPaddingSize,
                         left: AppPaddings.contentPaddingSize,
                         right: AppPaddings.contentPaddingSize),
                 child:Row(children: [
                   Expanded(
                       flex: 1,
                       child: RichText(
                           textAlign: TextAlign.center,
                           textDirection: AppTextDirection.defaultDirection,
                           text: TextSpan(children: <TextSpan>[
                             TextSpan(
                               text: 'Close',
                               recognizer: TapGestureRecognizer()
                                 ..onTap = () {
                                   print('The button is clicked!');
                                 },
                               style: AppTextStyle.h3TitleTextStyle(
                                   color: AppColor.textColor(context),
                                   fontWeight: FontWeight.w500),
                             ),
                           ]))),
                   Container(
                     width: 1,
                     color: AppColor.newprimaryColor,
                   ),
                   Expanded(
                       flex: 1,
                       child: RichText(
                           textAlign: TextAlign.center,
                           textDirection: AppTextDirection.defaultDirection,
                           text: TextSpan(children: <TextSpan>[
                             TextSpan(
                                 text: 'Apply',
                                 recognizer: TapGestureRecognizer()
                                   ..onTap = () {
                                     print('The button is clicked!');
                                   },
                                 style: AppTextStyle.h3TitleTextStyle(
                                     color: AppColor.accentColor,
                                     fontWeight: FontWeight.w500),
                             ),
                           ])))
                 ],
                 )
                 ),


                /*StreamBuilder<UiState>(
                  stream: _loginBloc.uiState,
                  builder: (context, snapshot) {
                    final uiState = snapshot.data;
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CustomButton(
                          padding: EdgeInsets.only(top: 15,bottom: 15,left: 48,right: 48),
                          color: AppColor.accentColor,
                          onPressed: uiState != UiState.loading
                              ?  (){
                            Navigator.pushNamed(
                              context,
                              AppRoutes.dateTimeRoute,
                              //arguments: category,
                            );
                          }
                              : null,
                          child: uiState != UiState.loading
                              ? Text(
                            "Book an Appointement",
                            style: AppTextStyle.h4TitleTextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.start,
                            textDirection:
                            AppTextDirection.defaultDirection,
                          )
                              : PlatformCircularProgressIndicator(),
                        ));
                  },
                ),*/
              ]),
            )));
  }

  Widget tabsContent(String caption, [String description = '']) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(fontSize: 25),
          ),
          Divider(
            height: 20,
            color: Colors.black45,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
