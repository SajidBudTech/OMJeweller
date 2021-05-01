import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/persistent_header.dart';
import 'package:flutter_om_jeweller/widgets/appbars/product_page.appbar.dart';
import 'package:flutter_om_jeweller/widgets/header/product_page_header.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/general_shimmer_list_view_item.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:flutter_om_jeweller/views/products/details_view.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({
    Key key,
    // this.vendor,
  }) : super(key: key);

  //final Vendor vendor;
  LoginBloc _loginBloc = LoginBloc();
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductPageViewModel>.reactive(
      viewModelBuilder: () => ProductPageViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColor.appBackground(context),
          appBar: PreferredSize(
            preferredSize: Size(double.infinity,
                model.makeAppBarTransparent ? kToolbarHeight : 56),
            child: ProductPageAppBar(
              model: model,
            ),
          ),
          //extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              // body
              Container(
                padding: EdgeInsets.all(0),
                // color: AppColor.appBackground(context),
                child: NestedScrollView(
                    controller: model.vendorPageStrollController,
                    headerSliverBuilder: (context, value) {
                      return [
                        //vendor information header
                        ProductPageHeader(
                          vendor: "",
                        ),

                        // vendor menu types appbar with tabs
                        SliverPersistentHeader(
                          pinned: false,
                          floating: false,
                          delegate: PersistentHeader(
                            widget: Container(
                              width: double.infinity,
                              //height: 100,
                               //color: AppColor.newprimaryColor,
                              decoration: BoxDecoration(
                                borderRadius:
                                    AppSizes.containerTopBorderRadiusShape(),
                                color: AppColor.appBackground(context),
                              /*  boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0.5, 0.2), // changes position of shadow
                                  ),
                                ],*/
                              ),
                              child:
                                  model.isBusy || !model.makeAppBarTransparent
                                      ? UiSpacer.horizontalSpace()
                                      : Center(
                                          child: Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                              color: AppColor.accentColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        )),

                              /*TabBar(
                                labelColor: AppColor.primaryColor,
                                unselectedLabelColor:
                                AppColor.hintTextColor(context),
                                isScrollable: true,
                                indicatorWeight: 3.0,
                                indicatorPadding: EdgeInsets.all(0),
                                labelStyle:
                                AppTextStyle.h4TitleTextStyle(),
                                unselectedLabelStyle:
                                AppTextStyle.h5TitleTextStyle(),
                                tabs: model.menus.map(
                                      (menu) {
                                    return Tab(
                                      text: menu.name,
                                    );
                                  },
                                ).toList(),
                              ),*/
                            ),
                          ),
                        ),
                      ];
                    },
                    body: model.isBusy
                        ? GeneralShimmerListViewItem()
                        : Column(
                      children: [
                        Expanded(
                          child:ProductDetailsViewItem(
                            vendor: "",
                          ),
                        ),
                        Container(
                         color: Colors.white,
                          padding: AppPaddings.defaultPadding(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex:8,
                                child:StreamBuilder<UiState>(
                                stream: widget._loginBloc.uiState,
                                builder: (context, snapshot) {
                                  final uiState = snapshot.data;

                                  return CustomButton(
                                    padding: AppPaddings.mediumButtonPadding(),
                                    color: AppColor.accentColor,
                                    onPressed: uiState != UiState.loading
                                        ?  (){Navigator.pushNamed(
                                      context,
                                      AppRoutes.verifyOTPRoute,
                                    );}
                                        : null,
                                    child: uiState != UiState.loading
                                        ? Text(
                                      "Book an Appointement",
                                      style: AppTextStyle.h4TitleTextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                      ),
                                      textAlign: TextAlign.start,
                                      textDirection:
                                      AppTextDirection.defaultDirection,
                                    )
                                        : PlatformCircularProgressIndicator(),
                                  );
                                },
                              )),
                              Expanded(
                                flex: 2,
                                child:Container(
                                  margin:EdgeInsets.only(left: 8),
                                  padding: EdgeInsets.only(top: 9,bottom: 9),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.accentColor,width: 1),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child:Icon(
                                    FlutterIcons.favorite_border_mdi,
                                    color: AppColor.accentColor,
                                    size: 32,
                                  )
                                )
                              )
                            ],

                          ),
                        ),

                      ],
                    )

                    /*TabBarView(
                      children: model.menus.map(
                            (menu) {
                          return VendorMenuTabBarView(
                            menu: menu,
                            vendor: model.vendor,
                          );
                        },
                      ).toList(),
                    ),*/
                    ),
              ),

              // floating cart button
              /*Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.20,
                  right: AppPaddings.contentPaddingSize,
                  child: FloatingCartButton(),
                ),*/
            ],
          ),
        );
      },
    );
  }
}
