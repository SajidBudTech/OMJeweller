import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_om_jeweller/data/models/category_banner.dart';
import 'package:flutter_om_jeweller/data/models/state_data_model.dart';
import 'package:flutter_om_jeweller/data/viewmodels/banner.viewmodel.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/widgets/shimmers/vendor_shimmer_list_view_item.dart';
import 'package:flutter_om_jeweller/widgets/state/state_loading_data.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialViews extends StatelessWidget {
  SocialViews({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                luanchFacebook();
              },
              child:Container(
                  padding: EdgeInsets.only(),
                  margin: EdgeInsets.only(right: 8),
                  //decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
                  child:SvgPicture.asset(
                    'assets/images/face_svg.svg',
                     height: 44,
                     width: double.infinity,
                    fit: BoxFit.fill,
                  )),

            )),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                luanchInstagram();
              },
              child:Container(
                  padding: EdgeInsets.only(),
                  margin: EdgeInsets.only(left: 1),
                  //decoration: BoxDecoration(color: Color(0xFFFFEEFA)),
                  child: Image.asset(
                    'assets/images/insta_png.png',
                    height: 44,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )
              ),

            )),
      ],
       ),
        UiSpacer.verticalSpace(space: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    luanchFacebookGroup();
                  },
                  child:Container(
                      padding: EdgeInsets.only(),
                      margin: EdgeInsets.only(right: 8),
                      //decoration: BoxDecoration(color: Color(0xFFEEF2FF)),
                      child:SvgPicture.asset(
                        'assets/images/face_group.svg',
                        height: 44,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      )),

                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    luanchGoogleReview();
                  },
                  child:Container(
                      padding: EdgeInsets.only(),
                      margin: EdgeInsets.only(left: 1),
                      //decoration: BoxDecoration(color: Color(0xFFFFEEFA)),
                      child: Image.asset(
                        'assets/images/google_re.png',
                        height: 44,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      )
                  ),

                )),
          ],
        ),
      ],
    );
  }

  void luanchFacebook() async{
    const url = 'https://www.facebook.com/OmJewellersIndia/';
    var encoded = Uri.encodeFull(url);
    await launch(encoded);
    /*if (await canLaunch(encoded)) {
        await launch(encoded);
    } else {
      throw 'Could not launch $url';
    }*/
  }

  void luanchFacebookGroup() async{
    const url = 'https://www.facebook.com/groups/omjewellers';
    var encoded = Uri.encodeFull(url);
    await launch(encoded);
    /*if (await canLaunch(encoded)) {
        await launch(encoded);
    } else {
      throw 'Could not launch $url';
    }*/
  }

  void luanchInstagram() async{
    const url = 'https://www.instagram.com/om_jewellers/';
    var encoded = Uri.encodeFull(url);
    await launch(encoded);
    /*if (await canLaunch(encoded)) {
        await launch(encoded);
    } else {
       throw 'Could not launch $url';
    }*/
  }

  void luanchGoogleReview() async{
    const url = 'https://www.google.com/search?q=om+jewellers+mumbai&rlz=1C1CHBD_enIN839IN839&oq=om+jewellers+&aqs=chrome.1.69i57j0l3j46i175i199j69i60l3.3839j0j7&sourceid=chrome&ie=UTF-8#lrd=0x3be7b0e709dc5933:0x9666f484e431ffac,3,,,';
    var encoded = Uri.encodeFull(url);
    await launch(encoded);
   /* if (await canLaunch(encoded)) {
    await launch(encoded);
    } else {
    throw 'Could not launch $url';
    }*/
  }
}
