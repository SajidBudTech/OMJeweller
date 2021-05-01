import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/appbars/leading_app_bar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_product.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_wishlist.dart';
import 'package:flutter_om_jeweller/widgets/inputs/textinput_edittext_textfield.dart';
import 'package:flutter_om_jeweller/widgets/myappointment_slider.dart';
import 'package:flutter_om_jeweller/widgets/listItem/animated_map_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/faq_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';
import 'package:flutter_om_jeweller/widgets/sort_page_content/sort_page.dart';
import 'package:flutter_om_jeweller/widgets/fliters/filter_content_page.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';

class DrawerEditProfilePage extends StatefulWidget {
  DrawerEditProfilePage({Key key}) : super(key: key);

  @override
  _DrawerEditProfilePageState createState() => _DrawerEditProfilePageState();
}

class _DrawerEditProfilePageState extends State<DrawerEditProfilePage> {
  //SearchVendorsBloc instance
  final LoginBloc _loginBloc = LoginBloc();

  //search bar focus node
  final _searchBarFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => AnnotatedRegion<
            SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: AppColor.newprimaryColor,
            ),
            child: Scaffold(
              // backgroundColor: AppColor.newprimaryColor,
              //extendBodyBehindAppBar: true,
                backgroundColor: AppColor.newprimaryColor,
                body: Container(
                  child: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: LeadingAppBar(
                              title: "Edit Profile",
                              subTitle: "",
                            ),
                          ),
                          Expanded(
                              child:Container(
                                  color: Colors.white,
                                  padding: AppPaddings.defaultPadding(),
                                  child: CustomScrollView(slivers: [

                                    SliverToBoxAdapter(
                                        child:Container(
                                        child:Text(
                                      'Personal Details',
                                      style: AppTextStyle.h3TitleTextStyle(
                                          color: AppColor.textColor(context),
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                      textDirection: AppTextDirection.defaultDirection,
                                    ))),
                                    SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                                    SliverToBoxAdapter(
                                        child:StreamBuilder<bool>(
                                          stream: _loginBloc.validMobileNumber,
                                          builder: (context, snapshot) {
                                            return  CustomHintLableTextFormField(
                                              isFixedHeight: false,
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              labelText:"Phone Number",
                                              keyboardType: TextInputType.phone,
                                              textStyle: AppTextStyle.h4TitleTextStyle(
                                                  color: AppColor.textColor(context)
                                              ),
                                              textInputAction: TextInputAction.next,
                                              textEditingController: _loginBloc.mobileNumberTEC,
                                              errorText: snapshot.error,
                                              onChanged: _loginBloc.validateMobileNumber,
                                            );
                                          },
                                        )),
                                    SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                                    SliverToBoxAdapter(
                                        child:StreamBuilder<bool>(
                                          stream: _loginBloc.validMobileNumber,
                                          builder: (context, snapshot) {
                                            return  CustomHintLableTextFormField(
                                                isFixedHeight: false,
                                                left: 0,
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                labelText: "Name",
                                                keyboardType: TextInputType.phone,
                                                textStyle: AppTextStyle.h4TitleTextStyle(
                                                    color: AppColor.textColor(context)
                                                ),
                                                textInputAction: TextInputAction.next,
                                                textEditingController: _loginBloc.mobileNumberTEC,
                                                errorText: snapshot.error,
                                                onChanged: _loginBloc.validateMobileNumber
                                            );
                                          },
                                        )),
                                    SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                                    SliverToBoxAdapter(
                                        child:StreamBuilder<bool>(
                                          stream: _loginBloc.validMobileNumber,
                                          builder: (context, snapshot) {
                                            return  CustomHintLableTextFormField(
                                              isFixedHeight: false,
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              labelText: "Gender",
                                              keyboardType: TextInputType.emailAddress,
                                              textStyle: AppTextStyle.h4TitleTextStyle(
                                                  color: AppColor.textColor(context)
                                              ),
                                              textInputAction: TextInputAction.next,
                                              textEditingController: _loginBloc.passwordTEC,
                                              errorText: snapshot.error,
                                              onChanged: _loginBloc.validateEmailAddress,
                                              suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 12,color: Colors.black,),

                                            );
                                          },
                                        )),
                                    SliverToBoxAdapter(child:UiSpacer.verticalSpace()),
                                    SliverToBoxAdapter(
                                        child:StreamBuilder<bool>(
                                          stream: _loginBloc.validMobileNumber,
                                          builder: (context, snapshot) {
                                            return  CustomHintLableTextFormField(
                                                isFixedHeight: false,
                                                left: 0,
                                                right: 0,
                                                top: 0,
                                                bottom: 0,
                                                labelText: "Email",
                                                keyboardType: TextInputType.phone,
                                                textStyle: AppTextStyle.h4TitleTextStyle(
                                                    color: AppColor.textColor(context)
                                                ),
                                                textInputAction: TextInputAction.next,
                                                textEditingController: _loginBloc.mobileNumberTEC,
                                                errorText: snapshot.error,
                                                onChanged: _loginBloc.validateMobileNumber
                                            );
                                          },
                                        )),
                                    SliverToBoxAdapter(child:UiSpacer.verticalSpace()),

                                    SliverToBoxAdapter(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [

                                          Expanded(child:StreamBuilder<bool>(
                                              stream: _loginBloc.validMobileNumber,
                                              builder: (context, snapshot) {
                                                return  CustomHintLableTextFormField(
                                                  isFixedHeight: false,
                                                  left: 0,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0,
                                                  labelText: "Date Of Birth",
                                                  keyboardType: TextInputType.emailAddress,
                                                  textStyle: AppTextStyle.h4TitleTextStyle(
                                                      color: AppColor.textColor(context)
                                                  ),
                                                  textInputAction: TextInputAction.next,
                                                  textEditingController: _loginBloc.passwordTEC,
                                                  errorText: snapshot.error,
                                                  onChanged: _loginBloc.validateEmailAddress,
                                                  suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 10,color: Colors.black,),

                                                );
                                              })),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child:StreamBuilder<bool>(
                                                stream: _loginBloc.validMobileNumber,
                                                builder: (context, snapshot) {
                                                  return  CustomHintLableTextFormField(
                                                    isFixedHeight: false,
                                                    left: 0,
                                                    right: 0,
                                                    top: 0,
                                                    bottom: 0,
                                                    labelText: "Anniversary",
                                                    keyboardType: TextInputType.emailAddress,
                                                    textStyle: AppTextStyle.h4TitleTextStyle(
                                                        color: AppColor.textColor(context)
                                                    ),
                                                    textInputAction: TextInputAction.next,
                                                    textEditingController: _loginBloc.passwordTEC,
                                                    errorText: snapshot.error,
                                                    onChanged: _loginBloc.validateEmailAddress,
                                                    suffixWidget: Icon(FlutterIcons.arrow_down_sli,size: 10,color: Colors.black,),

                                                  );
                                                },
                                              )
                                          )


                                        ],
                                      ),
                                    ),
                                    SliverToBoxAdapter(child:UiSpacer.verticalSpace(space: 40)),
                                    SliverToBoxAdapter(
                                        child:StreamBuilder<UiState>(
                                          stream: _loginBloc.uiState,
                                          builder: (context, snapshot) {
                                            final uiState = snapshot.data;

                                            return CustomButton(
                                              padding: AppPaddings.mediumButtonPadding(),
                                              color: AppColor.accentColor,
                                              onPressed: uiState != UiState.loading
                                                  ?  (){

                                              }
                                                  : null,
                                              child: uiState != UiState.loading
                                                  ? Text(
                                                "Save Details",
                                                style: AppTextStyle.h4TitleTextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                textAlign: TextAlign.start,
                                                textDirection:
                                                AppTextDirection.defaultDirection,
                                              )
                                                  : PlatformCircularProgressIndicator(),
                                            );
                                          },
                                        )),
                                    SliverToBoxAdapter(child:UiSpacer.verticalSpace()),


                                  ]))),
                        ]),
                  ),
                ))));

    //);
  }

/*void showSortBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(context, content: SortProductPage());
  }

  void showFilterBottomSheetDialog() {
    CustomDialog.showCustomBottomSheet(context, content: FilterProductPage());
  }*/
}
