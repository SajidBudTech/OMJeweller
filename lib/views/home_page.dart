import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_om_jeweller/bloc/home.bloc.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/constants/globle_variable.dart';
import 'package:flutter_om_jeweller/views/bookappointment/book_appointment_page.dart';
import 'package:flutter_om_jeweller/views/home/main_home_page.dart';
import 'package:flutter_om_jeweller/views/loyalty/loyalty_page.dart';
import 'package:flutter_om_jeweller/views/products/product_page_bottombar.dart';
import 'package:flutter_om_jeweller/views/profile/profile_page.dart';
import 'package:flutter_om_jeweller/widgets/appbars/empty_appbar.dart';
import 'package:flutter_om_jeweller/widgets/custom_bottom_navigation_appbar.dart';
import 'package:flutter_om_jeweller/widgets/custome_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_om_jeweller/constants/string/app.string.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_om_jeweller/data/viewmodels/count.viewmodel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //current bottom navigation bar index
  int currentPageIndex = 0;
  final PageController _pageController = PageController();
  String buildNumber;
  List<String> actionIcons = [
    "assets/images/search_icon.svg",
    "assets/images/wishlist_icon.svg",
    "assets/images/call_icon.svg",
    "assets/images/whatsapp_icon.svg",
    "assets/images/notification_appbar_icon.svg"
  ];
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
    return /*ViewModelBuilder<CountViewModel>.reactive(
    viewModelBuilder: () => CountViewModel(context),
    onModelReady: (model) => model.init(),
    builder: (context, model, child) =>*/

      Scaffold(
      backgroundColor: AppColor.appBackground(context),
      appBar: AppBar(
        backgroundColor: AppColor.newprimaryColor,
        //automaticallyImplyLeading: true,
        elevation: 0,
        brightness: MediaQuery.of(context).platformBrightness,
        iconTheme: IconThemeData(color: Color(0xFF646464)),
        titleSpacing: 0,
        title: Padding(
            padding: EdgeInsets.only(),
            child: Image.asset(
              "assets/images/appbar_logo.png",
              width: 48,
              height: 35,
            )),
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
          getWishlistAction(),
          getActionButton(2),
          getActionButton(3),
          getNotificationAction(),
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
          ProductCategoryPage(),
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

  Widget getActionButton(int position) {
    return InkWell(
      child: Padding(
          padding: EdgeInsets.only(left: 8, right: position == 4 ? 18 : 8),
          child: SvgPicture.asset(
            actionIcons[position],
            width: 20,
          )),
      onTap: () {
        switch (position) {
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
            launchCaller();
            break;
          case 3:
            launchWhatsapp();
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

  launchWhatsapp() async {
    const url =
        "https://wa.me/${AppStrings.defaultWhatsappNumber}?text=Welcome to OM Jewellers, How can we assist you?";
    var encoded = Uri.encodeFull(url);
    await launch(encoded);
    /*if (await canLaunch(encoded)) {
      await launch(encoded);
    } else {
      throw 'Could not launch $encoded';
    }*/
  }

  launchCaller() async {
    const url = "tel:${AppStrings.defaultAdminNumber}";
    await launch(url);

  }

  Widget getNotificationAction() {
    return Stack(
      children: <Widget>[
        new InkWell(
            onTap: (){
              Navigator.pushNamed(
                context,
                AppRoutes.notificationsRoute,
              );
            },
            child:Padding(
            padding: EdgeInsets.only(left: 8, right:18,top: 16),
            child: SvgPicture.asset(
              actionIcons[4],
              width: 20,
            ))),
           GlobleVariable.NOTIFICATION_COUNT != 0
            ? new Positioned(
                right: 14,
                top: 14,
                child: new Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '${GlobleVariable.NOTIFICATION_COUNT}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : new Container()
      ],
    );
  }
  Widget getWishlistAction() {
    return Stack(
      children: <Widget>[
        new InkWell(
            onTap: (){
              Navigator.pushNamed(
                context,
                AppRoutes.wishListPage,
              );
            },
            child:Padding(
                padding: EdgeInsets.only(left: 8, right: 8,top: 20),
                child: SvgPicture.asset(
                  actionIcons[1],
                  width: 20,
                ))),
        GlobleVariable.WISHLIST_COUNT != 0
            ? new Positioned(
          right: 14,
          top: 14,
          child: new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            decoration: new BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              '${GlobleVariable.WISHLIST_COUNT}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
            : new Container()
      ],
    );
  }
}
