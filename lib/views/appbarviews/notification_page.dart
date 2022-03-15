import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/notification.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_notification.dart';
import 'package:flutter_om_jeweller/data/models/notification_data.dart';
import 'package:flutter_om_jeweller/bloc/notification.bloc.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/listItem/notification_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/general_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:flutter_om_jeweller/widgets/state/unauthenticated.dart';
import 'package:flutter_om_jeweller/widgets/storelocationlist/notification_details.dart';
import 'package:stacked/stacked.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  //SearchVendorsBloc instance
  final NotificationsBloc _notificationBloc = NotificationsBloc();

  //search bar focus node
  final _searchBarFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _notificationBloc.initBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _notificationBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget pageBody;
    if (AuthBloc.authenticated()) {
      pageBody = ViewModelBuilder<NotificationViewModel>.reactive(
          viewModelBuilder: () => NotificationViewModel(context),
          onModelReady: (model) => model.getNotifications(),
          builder: (context, model, child) =>
              Scaffold(
                backgroundColor: Colors.white,
                appBar: EmptyAppBar(
                  backgroundColor: AppColor.newprimaryColor,
                ),
                body: Container(
                  child: Stack(
                    children: <Widget>[
                      //vendors
                      Positioned(
                        //if you are using CustomAppbar
                        //use this AppSizes.customAppBarHeight
                        //or this AppSizes.secondCustomAppBarHeight, if you are using the second custom appbar
                          top: AppSizes.secondCustomAppBarHeight,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child:
                          /*StreamBuilder<List<NotificationData>>(
                    stream: _notificationBloc.notifications,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child:EmptyNotification());
                      } else if (!snapshot.hasData) {
                        return Padding(padding: EdgeInsets.only(left: 20,right: 20),child:GeneralShimmerListViewItem());
                      } else if (snapshot.data.length == 0) {
                        return Center(child:EmptyNotification());
                      } else if (snapshot.data.length > 0) {
                        return*/
                          model.notificationLoadingState ==
                              LoadingState.Loading
                          //the loadinng shimmer
                              ? Padding(
                            padding:
                            EdgeInsets.only(left: 20, right: 20),
                            child: VendorShimmerListViewItem(),
                          )
                          // the faild view
                              : model.notificationLoadingState ==
                              LoadingState.Failed
                              ? LoadingStateDataView(
                            stateDataModel: StateDataModel(
                              showActionButton: true,
                              actionButtonStyle:
                              AppTextStyle.h4TitleTextStyle(
                                color: Colors.red,
                              ),
                              actionFunction: () =>
                              model.getNotifications,
                            ),
                          )
                          // the vendors list
                              : model.notificationList.length == 0
                              ? Center(
                            child: EmptyWishlist(),
                          )
                              : ListView.separated(
                            padding: EdgeInsets.only(
                                bottom: AppPaddings
                                    .contentPaddingSize,
                                left: AppPaddings
                                    .contentPaddingSize,
                                right: AppPaddings
                                    .contentPaddingSize),
                            separatorBuilder:
                                (context, index) =>
                                UiSpacer.verticalSpace(),
                            itemBuilder: (context, index) {
                              return NotificationListViewItem(
                                notification: model
                                    .notificationList[index],
                                onPressed: () {
                                  _showNotificationDetails(model
                                      .notificationList[index]);
                                },
                              );
                            },
                            itemCount:
                            model.notificationList.length,
                          )),

                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        //normal
                        child: LeadingAppBar(
                          title: 'Notification',
                          subTitle: "",
                        ),
                      ),
                    ],
                  ),
                ),
              ));
    }else{
      pageBody=Scaffold(body:UnauthenticatedPage());
    }
    return pageBody;
    //);
  }

  void _showNotificationDetails(NotificationData notification) {
    //update the read status of the notification
    /* notification.read = 1;
    _notificationsBloc.appDatabase.notificationDao.updateItem(
      notification,
    );
  */
    //show the notifcation details
    CustomDialog.showCustomBottomSheet(
      context,
      backgroundColor: Colors.white,
      content: NotificationDetails(
        notification: notification,
      ),
    );
  }
}
