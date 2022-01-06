import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
import 'package:flutter_om_jeweller/widgets/myappointment_slider.dart';
import 'package:flutter_om_jeweller/widgets/listItem/animated_map_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/product_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/listItem/faq_listview_item.dart';
import 'package:flutter_om_jeweller/widgets/sort_page_content/sort_page.dart';
import 'package:flutter_om_jeweller/widgets/fliters/filter_content_page.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/utils/custom_dialog.dart';

class FAQPage extends StatefulWidget {
  FAQPage({Key key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  //SearchVendorsBloc instance
  final ProductSearchBloc _searchVendorsBloc = ProductSearchBloc();

  //search bar focus node
  final _searchBarFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchBarFocusNode.requestFocus();
    _searchVendorsBloc.initBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _searchVendorsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainHomeViewModel>.reactive(
        viewModelBuilder: () => MainHomeViewModel(context),
        onModelReady: (model) => model.getFAQ(),
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
                              title: "FAQ",
                              subTitle: "",
                            ),
                          ),
                          Expanded(
                              child:Container(
                                color: Colors.white,
                             child: CustomScrollView(slivers: [
                               /* SliverToBoxAdapter(
                                  child: Container(
                                    height: 12,
                                    color: Colors.white,
                                  ),
                                ),*/

                              SliverPadding(
                                  padding: AppPaddings.defaultPadding(),
                                  sliver: model.omLiveLoadingState ==
                                      LoadingState.Loading
                                  //the loadinng shimmer
                                      ? SliverToBoxAdapter(
                                    child: VendorShimmerListViewItem(),
                                  )
                                  // the faild view
                                      : model.omLiveLoadingState ==
                                      LoadingState.Failed
                                      ? SliverToBoxAdapter(
                                    child: LoadingStateDataView(
                                      stateDataModel: StateDataModel(
                                        showActionButton: true,
                                        actionButtonStyle:
                                        AppTextStyle.h4TitleTextStyle(
                                          color: Colors.red,
                                        ),
                                        actionFunction: () =>
                                        model.getFAQ,
                                      ),
                                    ),
                                  )
                                  // the vendors list
                                      : model.faqQuestionList.length == 0
                                      ? SliverToBoxAdapter(
                                      child: Center(
                                        child: EmptyWishlist(),
                                      ))
                                      :
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                        return AnimatedMapListViewItem(
                                          index: index,
                                          address: model.faqQuestionList[index],
                                          listViewItem: FAQListViewItem(
                                            question: model.faqQuestionList[index],
                                            answer: model.faqAnswerList[index],
                                          ),
                                        );
                                      },
                                      childCount: model.faqQuestionList.length,
                                    ),
                                  ),
                                ),
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
