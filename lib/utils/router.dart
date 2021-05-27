import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/views/appbarviews/notification_page.dart';
import 'package:flutter_om_jeweller/views/appbarviews/search_product.dart';
import 'package:flutter_om_jeweller/views/appbarviews/wishlist_page.dart';
import 'package:flutter_om_jeweller/views/auth/login_page.dart';
import 'package:flutter_om_jeweller/views/auth/otp_verify.dart';
import 'package:flutter_om_jeweller/views/auth/register_page.dart';
import 'package:flutter_om_jeweller/views/bookappointment/confirmed_booking_page.dart';
import 'package:flutter_om_jeweller/views/bookappointment/date_time_page.dart';
import 'package:flutter_om_jeweller/views/home_page.dart';
import 'package:flutter_om_jeweller/views/products/product_detail_page.dart';
import 'package:flutter_om_jeweller/views/products/product_page.dart';
import 'package:flutter_om_jeweller/views/drawer/myappointment.dart';
import 'package:flutter_om_jeweller/views/drawer/faq.dart';
import 'package:flutter_om_jeweller/views/drawer/feedback.dart';
import 'package:flutter_om_jeweller/views/drawer/visit_our_store.dart';
import 'package:flutter_om_jeweller/views/drawer/dra_edit_profile.dart';
import 'package:flutter_om_jeweller/views/drawer/about_brand.dart';
import 'package:flutter_om_jeweller/views/bookappointment/fill_detail_page.dart';
import 'package:flutter_om_jeweller/data/models/page_arguments.dart';
import 'package:flutter_om_jeweller/data/models/datetime.arguments.dart';
import 'package:flutter_om_jeweller/data/models/product_arguments.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
  /*  case AppRoutes.welcomeRoute:
      return MaterialPageRoute(builder: (context) => OnboardingPage());*/

    case AppRoutes.loginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case AppRoutes.verifyOTPRoute:
      return MaterialPageRoute(
        builder: (context) => VerifyOTPPage(
         user: settings.arguments,
        ),
      );
    case AppRoutes.registerRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage(
             user: settings.arguments,
      ));

    case AppRoutes.homeRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.homeRoute, arguments: Map()),
        builder: (context) => HomePage(),
      );

    case AppRoutes.searchProductPage:
      return MaterialPageRoute(builder: (context) => SearchProductsPage());

    case AppRoutes.wishListPage:
      return MaterialPageRoute(builder: (context) => WishlistPage());

    case AppRoutes.productListPageRoute:
      final PageArguments pageArguments = settings.arguments;
      return MaterialPageRoute(builder: (context) => ProductPage(
          category: pageArguments.category,
          subcategory: pageArguments.subCategory,
          collection: pageArguments.collection,

      ));

    case AppRoutes.productDetailRoute:
      final ProductArguments productArguments = settings.arguments;
      return MaterialPageRoute(builder: (context) => ProductDetailPage(
        product: productArguments.product,
        status: productArguments.status,
      ));

    case AppRoutes.notificationsRoute:
      return MaterialPageRoute(builder: (context) => NotificationPage());
    case AppRoutes.dateTimeRoute:
      final DateTimeArguments dateTimeArguments = settings.arguments;
      return MaterialPageRoute(builder: (context) => SelectDateTimePage(
        DETAILS_PAGE: dateTimeArguments.status,
        appointment: dateTimeArguments.appointment,
      ));

    case AppRoutes.confirmedBokkingRoute:
      return MaterialPageRoute(builder: (context) => ConfirmedBookingPage(
        appointment: settings.arguments,
      ));

    case AppRoutes.fillDetailsRoute:
      return MaterialPageRoute(builder: (context) => FillDetailsPage());
    case AppRoutes.myAppointmentlistRoute:
      return MaterialPageRoute(builder: (context) => MyAppointmentListPage());
    case AppRoutes.visitOurStoreRoute:
      return MaterialPageRoute(builder: (context) => VisitOurStorePage());
    case AppRoutes.faqRoute:
      return MaterialPageRoute(builder: (context) => FAQPage());
    case AppRoutes.feedbackRoute:
      return MaterialPageRoute(builder: (context) => FeedBackPage());
    case AppRoutes.drawerEditProfileRoute:
      return MaterialPageRoute(builder: (context) => DrawerEditProfilePage());
    case AppRoutes.aboutusRoute:
      return MaterialPageRoute(builder: (context) => AboutBrandPage());

  /*  case AppRoutes.forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPasswordPage());

    case AppRoutes.homeRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.homeRoute, arguments: Map()),
        builder: (context) => HomePage(),
      );

    case AppRoutes.searchVendorsPage:
      return MaterialPageRoute(builder: (context) => SearchVendorsPage());

    case AppRoutes.productRoute:
      final PageArguments pageArguments = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => ProductPage(
          product: pageArguments.product,
          vendor: pageArguments.vendor,
        ),
      );

    case AppRoutes.vendorRoute:
      return MaterialPageRoute(
        builder: (context) => VendorPage(
          vendor: settings.arguments,
        ),
      );

    case AppRoutes.doctorRoute:
      return MaterialPageRoute(
        builder: (context) => DoctorPage(
          vendor: settings.arguments,
        ),
      );

    case AppRoutes.categoryVendorsRoute:
      return MaterialPageRoute(
        builder: (context) => CategoryVendorsPage(
          category: settings.arguments,
        ),
      );

    case AppRoutes.categoryDoctorRoute:
      return MaterialPageRoute(
        builder: (context) => CategoryDoctorsPage(
          doctorCategory: settings.arguments,
        ),
      );
    case AppRoutes.bookAppointmentRoute:
      return MaterialPageRoute(
        builder: (context) => BookAppointmentPage(
          vendor: settings.arguments,
        ),
      );

    case AppRoutes.newDeliveryAddressRoute:
      return MaterialPageRoute(builder: (context) => NewDeliveryAddressPage());

    case AppRoutes.editDeliveryAddressRoute:
      return MaterialPageRoute(
        builder: (context) => EditDeliveryAddressPage(
          deliveryAddress: settings.arguments,
        ),
      );

    case AppRoutes.deliveryAddressesRoute:
      return MaterialPageRoute(builder: (context) => DeliveryAddressesPage());

    case AppRoutes.myAppointmentRoute:
      return MaterialPageRoute(builder: (context) => MyAppointmentPage());

    case AppRoutes.trackOrderRoute:
      return MaterialPageRoute(
        builder: (context) => TrackOrderPage(
          order: settings.arguments,
        ),
      );

    case AppRoutes.checkOutRoute:
      return MaterialPageRoute(
        builder: (context) => CheckoutPage(
          order: settings.arguments,
        ),
      );

    case AppRoutes.editProfileRoute:
      return MaterialPageRoute(builder: (context) => EditProfilePage());

    case AppRoutes.changePasswordRoute:
      return MaterialPageRoute(builder: (context) => ChangePasswordPage());

    case AppRoutes.notificationsRoute:
      return MaterialPageRoute(builder: (context) => NotificationsPage());

    case AppRoutes.faqsRoute:
      return MaterialPageRoute(builder: (context) => FAQPage());

    case AppRoutes.firstprofileRoute:
      return MaterialPageRoute(builder: (context) => FirstProfilePage());

    case AppRoutes.webViewRoute:
      return MaterialPageRoute(
        builder: (context) => WebView(
          url: settings.arguments,
        ),
      );
    case AppRoutes.enterPhoneRoute:
      return MaterialPageRoute(
        builder: (context) => EnterPhonePage(
          user: settings.arguments,
         // url: settings.arguments,
        ),
      );
    case AppRoutes.verifyOTPRoute:
      return MaterialPageRoute(
        builder: (context) => VerifyOTPPage(
          user: settings.arguments,
          // url: settings.arguments,
        ),
      );
  //
    case AppRoutes.chatRoute:
      return MaterialPageRoute(
        builder: (context) => ChatPage(
          order: (settings.arguments as List)[0],
          vendor: (settings.arguments as List)[1],
        ),
      );
    case AppRoutes.blogsRoute:
      return MaterialPageRoute(
        builder: (context) => BlogsPage(
          //order: (settings.arguments as List)[0],
          //vendor: (settings.arguments as List)[1],
        ),
      );
    case AppRoutes.chatAdminRoute:
      return MaterialPageRoute(
        builder: (context) => ChatAdminPage(
          //order: (settings.arguments as List)[0],
          //vendor: (settings.arguments as List)[1],
        ),
      );
    case AppRoutes.walletRoute:
      return MaterialPageRoute(
        builder: (context) => WalletPage(),
      );*/


   /* default:
      return MaterialPageRoute(builder: (context) => OnboardingPage());*/
  }
}
