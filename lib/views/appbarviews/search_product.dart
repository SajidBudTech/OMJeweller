import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/bloc/product_search.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/buttons/custom_button.dart';
import 'package:flutter_om_jeweller/widgets/empty/empty_product.dart';
import 'package:flutter_om_jeweller/widgets/search/search_bar.dart';
import 'package:flutter_om_jeweller/widgets/search/search_groupedlist_view.dart';

class SearchProductsPage extends StatefulWidget {
  SearchProductsPage({Key key}) : super(key: key);

  @override
  _SearchProductsPageState createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {
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
    return Scaffold(
      appBar: EmptyAppBar(backgroundColor: AppColor.newprimaryColor),
      body: Container(
        color: Colors.white,
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
              child: ListView(
                //padding: AppPaddings.defaultPadding(),
                padding: EdgeInsets.fromLTRB(
                  AppPaddings.contentPaddingSize,
                  MediaQuery.of(context).size.height * 0.10,
                  AppPaddings.contentPaddingSize,
                  AppPaddings.contentPaddingSize,
                ),
                children: <Widget>[
                  //Resut
                  StreamBuilder<List<String>>(
                    stream: _searchVendorsBloc.searchVendors,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return EmptyProduct();
                      }
                      return SearchGroupedVendorsListView(
                        title: SearchStrings.result,
                        titleTextStyle: AppTextStyle.h3TitleTextStyle(
                          color: AppColor.textColor(context),
                        ),
                        products: snapshot.data,
                      );
                    },
                  ),
                ],
              ),
            ),

            //filter and search header/bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              //normal
              child: Container(
                // height: AppSizes.secondCustomAppBarHeight,
                padding: AppPaddings.defaultPadding(),
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: AppTextDirection.defaultDirection,
                  children: <Widget>[
                    //top view
                   /* Row(
                      textDirection: AppTextDirection.defaultDirection,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            SearchStrings.title,
                            style: AppTextStyle.h2TitleTextStyle(
                              color: AppColor.textColor(context),
                            ),
                            textDirection: AppTextDirection.defaultDirection,
                          ),
                        ),

                        //close button
                        CustomButton(
                          color: Colors.transparent,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                          ),
                        ),
                      ],
                    ),*/

                    UiSpacer.verticalSpace(),
                    SearchBar(
                      hintText: 'Search for jewellery',
                      onSearchBarPressed: null,
                      onSubmit: _searchVendorsBloc.initSearch,
                      focusNode: _searchBarFocusNode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
   // );
  }
}
