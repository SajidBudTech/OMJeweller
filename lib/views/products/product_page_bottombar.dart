import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/login.bloc.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/auth.string.dart';
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
import 'package:flutter_om_jeweller/widgets/listItem/shop_by_product_listitem.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/widgets/listItem/shop_by_categories_listitem.dart';
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';


class ProductCategoryPage extends StatefulWidget {
  ProductCategoryPage({Key key}) : super(key: key);

  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  //SearchVendorsBloc instance
  final ProductSearchBloc _searchVendorsBloc = ProductSearchBloc();

  //search bar focus node
  final _searchBarFocusNode = FocusNode();
  LoginBloc _loginBloc = LoginBloc();

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
      onModelReady: (model) => model.getCategories(),
      builder: (context, model, child) =>
          Scaffold(
            body: SingleChildScrollView(
                 primary: true,
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                   children :[
              //  slivers: [
                   UiSpacer.verticalSpace(space: 18),
                  Container(
                        width: double.infinity,
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
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          itemCount: model.categories.length,
                        //  padding: EdgeInsets.only(left: AppPaddings.contentPaddingSize,right: AppPaddings.contentPaddingSize),
                          separatorBuilder: (context, index) =>
                              UiSpacer.horizontalSpace(space: 0),
                          itemBuilder: (context, index) {
                            return ShopByCategoryListViewItem(
                              category: model.categories[index],
                            );
                          },
                        ),
                      )
               ]))

          ),
          );
  }
}
