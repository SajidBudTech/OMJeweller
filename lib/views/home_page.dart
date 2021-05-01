import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/home.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/views/bookappointment/book_appointment_page.dart';
import 'package:flutter_om_jeweller/views/home/main_home_page.dart';
import 'package:flutter_om_jeweller/views/loyalty/loyalty_page.dart';
import 'package:flutter_om_jeweller/views/profile/profile_page.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/custom_bottom_navigation_appbar.dart';
import 'package:flutter_om_jeweller/widgets/custome_drawer.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //current bottom navigation bar index
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  List<String> actionIcons=["assets/images/search_icon.svg","assets/images/wishlist_icon.svg","assets/images/call_icon.svg","assets/images/whatsapp_icon.svg","assets/images/notification_appbar_icon.svg"];
  @override
  void initState() {
    super.initState();
    //switch page from bloc, this allow another page/bloc to determine the page for the home page
    HomeBloc.initiBloc();
    HomeBloc.currentPageIndex.listen((currentPageIndex) {
      _updateCurrentPageIndex(currentPageIndex);
    });
  }

  @override
  void dispose() {
    super.dispose();
    HomeBloc.closeListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground(context),
      appBar: AppBar(
        backgroundColor: AppColor.newprimaryColor,
        //automaticallyImplyLeading: true,
        elevation: 0,
        brightness: MediaQuery.of(context).platformBrightness,
        iconTheme: IconThemeData(color: Color(0xFF646464)),
        titleSpacing: 0,
        title: Padding(
          padding:EdgeInsets.only(),
          child:Image.asset("assets/images/appbar_logo.png",
            width: 48,
            height: 35,
          )
        ),
        /* leading: Row(
           children: [
            // Icon(FlutterIcons.drawer_sli,color: Color(0xFF646464),size: 18,),
             Padding(
             padding: EdgeInsets.only(left: 32),
             child:Image.asset("assets/images/appbar_logo.png",
             width: 48,
             height: 35,
             ))
           ],
         ),*/
        actions: [
          getActionButton(0),
          getActionButton(1),
          getActionButton(2),
          getActionButton(3),
          getActionButton(4),
        ],
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentPageIndex: currentPageIndex,
        onItemTap: _updateCurrentPageIndex,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          //for normal vendors listing
          // VendorsPage(),
          //for switching between vendors and items listing
          //VendorsOrItemsPage(),
          //grid card/elevated categories card listing
          // GridCategoriesPage(),
          //new home page
          MainHomePage(),
          BookAppointmentPage(),
         // LoyaltyPage(),
          ProfilePage(),
        ],
        onPageChanged: _updateCurrentPageIndex,
      ),
    );
  }

  //update the current page index
  void _updateCurrentPageIndex(int pageIndex) {
    setState(() {
      currentPageIndex = pageIndex;
    });
    _pageController.animateToPage(
      pageIndex,
      curve: Curves.ease,
      duration: Duration(
        microseconds: 10,
      ),
    );
  }

  Widget getActionButton(int position){
      return InkWell(
          child:Padding(
            padding: EdgeInsets.only(left: 8,right: position==4?18:8),
             child:
             SvgPicture.asset(
                actionIcons[position],
                width: 20,
             )
          ),
         onTap: (){
            switch(position){
              case 0:
                Navigator.pushNamed(
                  context,
                  AppRoutes.searchProductPage,
                );
                break;
              case 1:
                Navigator.pushNamed(
                  context,
                  AppRoutes.wishListPage,
                );
                break;
              case 2:
               /* Navigator.pushNamed(
                  context,
                  AppRoutes.wishListPage,
                );*/
                break;
              case 3:
              /*  Navigator.pushNamed(
                  context,
                  AppRoutes.wishListPage,
                );*/
                break;
              case 4:
                Navigator.pushNamed(
                  context,
                  AppRoutes.notificationsRoute,
                );
                break;
            }
         },
      );
  }
}
