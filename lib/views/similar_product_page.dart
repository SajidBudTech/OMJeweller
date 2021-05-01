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
import 'package:flutter_om_jeweller/widgets/listItem/similar_product_list_view_item.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';

class SimilarProductPage extends StatefulWidget {
  SimilarProductPage({
    Key key,
  }) : super(key: key);

  @override
  _SimilarProductPageState createState() => _SimilarProductPageState();
}

class _SimilarProductPageState extends State<SimilarProductPage> {
  LoginBloc _loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => Container(
          color: AppColor.newprimaryColor,
          padding: AppPaddings.defaultPadding(),
          child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UiSpacer.verticalSpace(),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(),
                    child:Text(
                      'Similar Products',
                      style: AppTextStyle.h3TitleTextStyle(
                          color: AppColor.textColor(context),
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.start,
                      textDirection: AppTextDirection.defaultDirection,
                    )),
                UiSpacer.verticalSpace(),
                Container(
                  width: double.infinity,
                  height: AppSizes.getScreenheight(context)/2.6,
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
                      actionFunction: model.getCategories,
                    ),
                  )
                      : ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.wishlistList.length,
                    //padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                    separatorBuilder: (context, index) =>
                        UiSpacer.horizontalSpace(space: 0),
                    itemBuilder: (context, index) {
                      return SimilarProdcutListViewItem(
                        vendor:model.wishlistList[index],
                      );
                    },
                  ),

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

        ));
  }
}
