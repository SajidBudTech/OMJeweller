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
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/main_home_viewmodel.dart';
import 'package:flutter_om_jeweller/data/viewmodels/product_page.viewmodel.dart';
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
    this.model,
    this.productList
  }) : super(key: key);

  ProductPageViewModel model;
  List<Product> productList;

  @override
  _FilterProductPageState createState() => _FilterProductPageState();
}

class _FilterProductPageState extends State<FilterProductPage> {
  LoginBloc _loginBloc = LoginBloc();

  List<String> availableCategory=[];
  List<String> availableSubCategory=[];
  List<String> availableCollection=[];
  List<String> availableGoldPurity=[];



  @override
  void initState() {
    super.initState();

    for(Product product in widget.productList){
      availableCategory.add(product.categoryName);
      availableSubCategory.add(product.subcategoryName);
      availableCollection.add(product.collectionName);
      availableGoldPurity.add(product.purityName);
    }

    availableCategory.toSet().toList();
    availableSubCategory.toSet().toList();
    availableCollection.toSet().toList();
    availableGoldPurity.toSet().toList();

    if(widget.model.availableCategoryMap==null){
      widget.model.availableCategoryMap=Map.fromIterable(availableCategory,key: (e)=>e,value: (e)=>false);
    }
    if(widget.model.availableSubCategoryMap==null){
      widget.model.availableSubCategoryMap=Map.fromIterable(availableSubCategory,key: (e)=>e,value: (e)=>false);
    }
    if(widget.model.availableCollectionMap==null){
      widget.model.availableCollectionMap=Map.fromIterable(availableCollection,key: (e)=>e,value: (e)=>false);
    }
    if(widget.model.availableGoldPurityMap==null){
      widget.model.availableGoldPurityMap=Map.fromIterable(availableGoldPurity,key: (e)=>e,value: (e)=>false);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Container(
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
                                  widget.model.clearAll();
                                  Navigator.pop(context);
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
                    selectedTabBackgroundColor: Colors.white,
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
                        'Sub Category',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )),
                      Tab(child:  Text(
                        'Collection',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )
                      ),
                      Tab(child:  Text(
                        'Gold Purity',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )),
                      /*Tab(child:  Text(
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
                      )),*/
                    ],
                    contents: <Widget>[
                      tabsContent('Categories',widget.model.availableCategoryMap),
                      tabsContent('Sub Categories',widget.model.availableSubCategoryMap),
                      tabsContent('Collections',widget.model.availableCollectionMap),
                      tabsContent('Gold Purity',widget.model.availableGoldPurityMap),
                    ],
                  ),
                ),
                 Container(
                   color: Colors.white,
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
                                   Navigator.pop(context);
                                 },
                               style: AppTextStyle.h3TitleTextStyle(
                                   color: AppColor.textColor(context),
                                   fontWeight: FontWeight.w500),
                             ),
                           ]))),
                   Container(
                     width: 1,
                     height: 24,
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
                                      widget.model.filterProductList();
                                      Navigator.pop(context);
                                   },
                                 style: AppTextStyle.h3TitleTextStyle(
                                     color: AppColor.accentColor,
                                     fontWeight: FontWeight.w500),
                             ),
                           ])))
                 ],
                 )
                 ),

              ]),
            ));
  }

  Widget tabsContent(String caption, Map<String,bool> items) {
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            caption,
            style: AppTextStyle.h3TitleTextStyle(color: AppColor.textColor(context),fontWeight: FontWeight.w500),
          ),
          Divider(
            height: 20,
            color: Colors.black45,
          ),
          Expanded(
            child :
            ListView(
              children: items.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(key??""),
                  value: items[key],
                  activeColor: AppColor.accentColor,
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      if(caption=="Categories"){
                        widget.model.availableCategoryMap[key] = value;
                      }else if(caption=="Sub Categories"){
                        widget.model.availableSubCategoryMap[key] = value;
                      }else if(caption=="Collections"){
                        widget.model.availableCollectionMap[key] = value;
                      }else if(caption=="Gold Purity"){
                        widget.model.availableGoldPurityMap[key] = value;
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
