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
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/widgets/listItem/animated_product_listitem.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/platform/platform_circular_progress_indicator.dart';

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
    // _searchBarFocusNode.requestFocus();
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
                padding: EdgeInsets.only(left: 20,right: 20),
                children: <Widget>[
                  //Resut
                  StreamBuilder<List<Product>>(
                    stream: _searchVendorsBloc.searchProducts,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return EmptyProduct();
                      }else if(snapshot.data==null){
                        return Column(
                            children: <Widget>[
                              Container(
                                  width: 60,
                                  height: 60,
                                  alignment: Alignment.center,
                                  child:PlatformCircularProgressIndicator()
                              ),
                              UiSpacer.verticalSpace(space: 30),
                              Text(
                                "Loading... Please Wait",
                                style: AppTextStyle.h3TitleTextStyle(
                                      color: AppColor.textColor(context),
                                    ),
                                textDirection: AppTextDirection.defaultDirection,
                              ),

                            ]
                        );
                      }
                     /* return SearchGroupedVendorsListView(
                        title: SearchStrings.result,
                        titleTextStyle: AppTextStyle.h3TitleTextStyle(
                          color: AppColor.textColor(context),
                        ),
                        products: snapshot.data,
                        platinumRate: _searchVendorsBloc.platiniumRate,
                      );*/

                      //grid listing type
                      return CustomScrollView(
                          primary: true,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          slivers: [
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1/1.7,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return AnimatedProdcutListViewItem(
                                index: index,
                                product: snapshot.data[index],
                                platinumRate: _searchVendorsBloc.platiniumRate,
                              );
                            },
                            childCount: snapshot.data.length,
                          ))]);
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
/*                    Container(
                        alignment: Alignment.topRight,
                        child:CustomButton(
                          padding: EdgeInsets.only(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                      ),
                    )),*/
                    //UiSpacer.verticalSpace(),
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
