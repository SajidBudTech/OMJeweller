import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/constants/app_text_direction.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/utils/ui_spacer.dart';
import 'package:flutter_om_jeweller/constants/app_paddings.dart';

class AppDrawer extends StatelessWidget {

  List<String> drawerIcon=["assets/images/dra_appointment.svg","assets/images/dra_about.svg","assets/images/dra_visit.svg",
    "assets/images/dra_refer.svg","assets/images/dra_feedback.svg","assets/images/dra_faq.svg","assets/images/dra_review.svg"];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:
      Column(
        children: [
       Container(
            height: 160,
           // alignment: Alignment.bottomLeft,
            child: _createHeader(context),
          ),
          Expanded(
            child:ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 10,right: 10),
              children: <Widget>[
                _createDrawerItem(context: context,position: 0,text: "My Appointments",onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.myAppointmentlistRoute,
                    //arguments: category,
                  );
                }),
                _createDrawerItem(context: context,position: 1,text: "About Brand",onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.aboutusRoute,
                    //arguments: category,
                  );
                }),
                _createDrawerItem(context: context,position: 2,text: "Visit Our Stores",onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.visitOurStoreRoute,
                    //arguments: category,
                  );
                }),
                //_createDrawerItem(context: context,position: 3,text: "Refer a Friend"),
                _createDrawerItem(context: context,position: 4,text: "Feedback & Suggestions",onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.feedbackRoute,
                    //arguments: category,
                  );
                }),
                _createDrawerItem(context: context,position: 5,text: "FAQ",onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.faqRoute,
                    //arguments: category,
                  );
                }),
                _createDrawerItem(context: context,position: 6,text: "Review on Google",onTap: (){

                }),
                 UiSpacer.verticalSpace(space: 40),
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Container(
                    color: AppColor.newprimaryColor,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20,right: 20,top: 16,bottom: 16),
                    child:Text(
                      'Logout',
                      style: AppTextStyle.h16TitleTextStyle(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.start,
                      textDirection: AppTextDirection.defaultDirection,
                    )
                ),
              onTap: () {},
            ),
                // _createDrawerItem(icon: Icons.collections_bookmark, text: 'Steps'),
                // _createDrawerItem(icon: Icons.face, text: 'Authors'),
                // _createDrawerItem(
                //  icon: Icons.account_box, text: 'Flutter Documentation'),
                // _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),
                //Divider(),
                // _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
                 ListTile(
                   contentPadding: EdgeInsets.zero,
                   dense: true,
                  title:Padding(
                    padding: EdgeInsets.only(left: 16),
                    child:Text('App Verison Lorem Ipsum',
                  style: AppTextStyle.h7TitleTextStyle(
                      color: AppColor.hintTextColor(context),
                      fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.start,
                  textDirection: AppTextDirection.defaultDirection,
                )),
                onTap: () {},
               ),
              ],
            )),

        ])


    );
  }

  Widget _createHeader(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.only(top: 60),
        padding: EdgeInsets.only(left: 24,right: 24),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(bottom: 3),
                      child:Text(
                        'Hi, Suhani Shah',
                        style: AppTextStyle.h3TitleTextStyle(
                            color: AppColor.textColor(context),
                            fontWeight: FontWeight.w500
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      )),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.drawerEditProfileRoute,
                        //arguments: category,
                      );
                    },
                  child:Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(bottom: 3),
                      child:Text(
                        'Edit',
                        style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.accentColor,
                            fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.start,
                        textDirection: AppTextDirection.defaultDirection,
                      ))),
                )
              ],
            ),
            Container(
                alignment: Alignment.topLeft,
                //padding: EdgeInsets.only(bottom: 12),
                child:Text(
                  'Welcome to OM Jewellers',
                  style: AppTextStyle.h4TitleTextStyle(
                      color: AppColor.hintTextColor(context),
                      fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.start,
                  textDirection: AppTextDirection.defaultDirection,
                )),
          ],
        )
    );
  }


  Widget _createDrawerItem({BuildContext context,int position,String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          SvgPicture.asset(
            drawerIcon[position],
            width: 17,
          ),
          Padding(
            padding: EdgeInsets.only(left: 19),
            child:Text(
              text,
              style: AppTextStyle.h4TitleTextStyle(
                  color: AppColor.textColor(context),
                  fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.start,
              textDirection: AppTextDirection.defaultDirection,
            )
          )
        ],
      ),
      onTap: onTap,
    );
  }
}