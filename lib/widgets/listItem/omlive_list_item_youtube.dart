import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_images.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/omlive.dart';
import 'package:flutter_om_jeweller/utils/youtube_thumbanail.dart';
import 'package:url_launcher/url_launcher.dart';

class OMLiveYoutubeListItems extends StatefulWidget {
  final OMLive video;

  OMLiveYoutubeListItems({this.video, Key key}) : super(key: key);

  @override
  _OMLiveYoutubeListItemsState createState() => _OMLiveYoutubeListItemsState();
}

class _OMLiveYoutubeListItemsState extends State<OMLiveYoutubeListItems> {
  //YoutubePlayerController _youtubePlayerController;
  //PodPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        await launch(widget.video.videoWebUrl??"");
      },
      child:Container(
      width: (AppSizes.getScreenWidth(context)) - 60,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 8,
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                          )),
                      child: Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                            child: CachedNetworkImage(
                              imageUrl: YoutubeThumbnail(
                                      youtubeId: widget.video.videoWebUrl
                                          .split("=")[1])
                                  .standard()
                                  .toString(),
                              errorWidget: (context, url, error) => Padding(
                                  padding: AppPaddings.mediumButtonPadding(),
                                  child: Image.asset(
                                    AppImages.defaultPlaceHolder,
                                    fit: BoxFit.contain,
                                  )),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ))),
                     Positioned(
                         child: Align(
                           alignment: Alignment.center,
                             child:Icon(
                               FlutterIcons.youtube_ant,
                               size: 56,
                               color: Colors.red,

                     )))
                ],
              )),
          Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.newprimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
                  child: Text(
                    widget.video.title ?? "",
                    style: AppTextStyle.h5TitleTextStyle(
                        color: AppColor.textColor(context),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    textDirection: AppTextDirection.defaultDirection,
                  ))),
        ],
      ),
    ));
  }
}
