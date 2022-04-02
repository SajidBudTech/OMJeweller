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
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/data/models/datetime.arguments.dart';



class StoreLocationContent extends StatefulWidget {
  StoreLocationContent({
    Key key,
    @required this.vendor,
  }) : super(key: key);

  final String vendor;
  @override
  _StoreLocationContentState createState() => _StoreLocationContentState();
}

class _StoreLocationContentState extends State<StoreLocationContent> {
  LoginBloc _loginBloc = LoginBloc();

  int SELECTED_POSITION=-1;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.getStoreVisitData(),
        builder: (context, model, child) => Container(
            padding: AppPaddings.defaultPadding(),
            child:Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               UiSpacer.verticalSpace(),
               Container(
                   alignment: Alignment.topLeft,
                   padding: EdgeInsets.only(bottom: 8),
                   child:Text(
                     'Select Store Location',
                     style: AppTextStyle.h16TitleTextStyle(
                         color: AppColor.accentColor,
                         fontWeight: FontWeight.w600
                     ),
                     textAlign: TextAlign.start,
                     textDirection: AppTextDirection.defaultDirection,
                   )),
               UiSpacer.verticalSpace(space: 12),
               Container(
                 width: double.infinity,
                 height:56,
                 child: model.categoriesLoadingState == LoadingState.Loading
                 //the loadinng shimmer
                     ? Padding(
                   padding: EdgeInsets.symmetric(
                     horizontal: AppPaddings.contentPaddingSize,
                   ),
                   child: VendorShimmerListViewItem(),
                 )
                 // the faild view
                     : model.categoriesLoadingState == LoadingState.Failed
                     ? LoadingStateDataView(
                   stateDataModel: StateDataModel(
                     showActionButton: true,
                     actionButtonStyle: AppTextStyle.h4TitleTextStyle(
                       color: Colors.red,
                     ),
                     actionFunction: model.getStoreVisitData,
                   ),
                 )
                     : ListView.separated(
                   shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                   itemCount: model.storeVisitList.length,
                   //padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                   separatorBuilder: (context, index) =>
                       UiSpacer.horizontalSpace(space: 0),
                   itemBuilder: (context, index) {
                     return StoreLocationListViewItem(
                       notification: model.storeVisitList[index],
                       current_index: index,
                       SELECTED_INDEX: SELECTED_POSITION,
                       onPressed: (){
                         setState(() {
                           SELECTED_POSITION=index;
                           AppStrings.selectedTypeDetails=model.storeVisitList[index];
                         });
                       },
                     );
                   },
                 ),

               ),
            StreamBuilder<UiState>(
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
                        if(SELECTED_POSITION!=-1) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.dateTimeRoute,
                            arguments: DateTimeArguments(
                                appointment: null,
                                status: true
                            ),
                          );
                        }else{
                          EdgeAlert.show(
                            context,
                            title: "Please select store location!",
                            description: "select one of store location option.",
                            backgroundColor: AppColor.accentColor,
                            icon: FlutterIcons.error_mdi,
                          );
                        }
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
              ),
             ]),

            ));
  }
}
