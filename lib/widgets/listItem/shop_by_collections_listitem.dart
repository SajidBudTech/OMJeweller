import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_images.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/page_arguments.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/api.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';

class ShopByCollectionListViewItem extends StatelessWidget {
  final Collection collection;
  const ShopByCollectionListViewItem({
    this.collection,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(
              context,
              AppRoutes.productListPageRoute,
              arguments: PageArguments(
                category: null,
                subCategory: null,
                collection: collection
              )
          );
        },
        highlightColor: Colors.transparent,
        splashColor: AppColor.newprimaryColor.withOpacity(0.5),
        child: Card(
            elevation: 0,
            margin: EdgeInsets.only(right: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
                width: 250,
                child:

               /* Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 8,
                      child:*/

                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                             bottomRight: Radius.circular(10.0)),
                          child:
                          CachedNetworkImage(
                            imageUrl: Api.downloadUrlPath +collection.collectionImage,
                            errorWidget: (context, url, error) =>Padding(padding: AppPaddings.mediumButtonPadding(),child:Image.asset(AppImages.defaultPlaceHolder,fit: BoxFit.contain,)),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                          )
                      ),

                    ),
                    /*Expanded(
                        flex: 2,
                        child: Container(
                          // color: AppColor.primaryColorDark,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFE8D1),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0))
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              collection.collectionName,
                              style: AppTextStyle.h4TitleTextStyle(
                                  color: AppColor.textColor(context),
                                  fontWeight: FontWeight.w500
                              ),
                              textAlign: TextAlign.center,
                              textDirection: AppTextDirection.defaultDirection,
                            )))*/

                /*  ],
                ))*/
        )
    );
      //  ],
     // ),
   // );
  }
}
