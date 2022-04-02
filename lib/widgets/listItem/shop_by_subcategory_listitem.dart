import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_images.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/subcategory.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/data/models/page_arguments.dart';

class ShopBySubCategoryListViewItem extends StatelessWidget {
  final Subcategory subCategory;
  final Category category;
  final Function onPressed;
  const ShopBySubCategoryListViewItem({
    this.subCategory,
    this.onPressed,
    this.category,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Navigator.pushNamed(
            context,
            AppRoutes.productListPageRoute,
            arguments: PageArguments(
              category: null,
              subCategory: subCategory,
              collection: null
            )
          );
        },
        highlightColor: Colors.transparent,
        splashColor: AppColor.newprimaryColor.withOpacity(0.5),
        child: Card(
            elevation: 0,
            margin: EdgeInsets.only(right: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child:Container(
                width: 160,
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 8,
                      child:ClipRRect(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0), topRight:Radius.circular(10.0)),
                          child:
                          CachedNetworkImage(
                            imageUrl: Api.downloadUrlPath+subCategory.subcategoryImage,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Container(
                              //height: ((AppSizes.getScreenWidth(context)/2)-50)+(((AppSizes.getScreenWidth(context)/2)-50)*0.3),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>Padding(padding: AppPaddings.mediumButtonPadding(),child:Image.asset(AppImages.defaultPlaceHolder,fit: BoxFit.contain,)),
                            width: MediaQuery.of(context).size.width,
                          )
                      ),

                    ),
                    Expanded(
                        flex: 2,
                        child:Container(
                          // color: AppColor.primaryColorDark,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFE8D1),
                                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10.0), bottomRight:Radius.circular(10.0))
                            ),
                            alignment: Alignment.center,
                            child:Text(
                              subCategory.subcategoryName,
                              style: AppTextStyle.h5TitleTextStyle(
                                  color: AppColor.textColor(context),
                                  fontWeight: FontWeight.w500
                              ),
                              textAlign: TextAlign.center,
                              textDirection: AppTextDirection.defaultDirection,
                            )))

                  ],
                ))
        )
    );
    // );
    //  ],
    // ),
    // );
  }
}
