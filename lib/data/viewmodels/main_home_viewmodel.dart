// ViewModel
import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_routes.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/new_category.dart';
import 'package:flutter_om_jeweller/data/models/wishlist_data.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/repositories/home.repository.dart';
import 'package:flutter_om_jeweller/data/viewmodels/base.viewmodel.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/data/models/omlive.dart';

class MainHomeViewModel extends MyBaseViewModel {

  HomePageRepository _homePageRepository= HomePageRepository();

  //
  LoadingState categoriesLoadingState = LoadingState.Loading;
  LoadingState collectionLoadingState = LoadingState.Loading;
  LoadingState newArrivalLoadingState = LoadingState.Loading;
  LoadingState omLiveLoadingState = LoadingState.Loading;
  LoadingState FaqLoadingState = LoadingState.Loading;


  LoadingState nearbyLoadingState = LoadingState.Loading;
  LoadingState popularsLoadingState = LoadingState.Loading;
  int listingStyle = 2;

  List<Category> categories = [];

  List<NewCategory> newCategories = [];

  List<Collection> collections = [];
  List<Product> newArrivalList = [];


  List<String> categoriesbottomone = [];
  List<String> categoriesbottomtwo = [];
  List<String> categoriesnewArrival = [];
  List<String> productList = [];
  List<String> CompanyNameList = [];
  List<String> CompanyPostList = [];
  List<String> shopByCategoryList = [];
  List<OMLive> OMLiveList = [];

  List<String> storeCallList = [];
  List<String> storeVisitList = [];
  List<String> storeVisitType = [];
  List<String> storeVisitTypeImage = [];


  List<String> faqQuestionList = [];
  List<String> faqAnswerList = [];
  


  List<Wishlist> wishlistList = [];
  List<String> availableslotList = [];
 /* List<Category> categories = [];
  List<Vendor> nearbyVendors = [];
  List<Vendor> popularVendors = [];
  DeliveryAddress selectedDeliveryAddress;*/
  //
 // bool isLocationAvailable = false;
  /*Location location = new Location();
  LocationData currentLocationData;*/

  MainHomeViewModel(BuildContext context) {
    this.viewContext = context;
  }




  void getCategories() async {
    //add null data so listener can show shimmer widget to indicate loading
    categoriesLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      final allcategories = await _homePageRepository.getCategories();
      allcategories.forEach((element) {
        if(int.parse(element.productCount??"0") > 0 && element.subcategory.length>0){
          categories.add(element);
        }
      });
      categoriesLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      categoriesLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }


  void getNewCategories() async {
    //add null data so listener can show shimmer widget to indicate loading
    categoriesLoadingState = LoadingState.Loading;
    notifyListeners();

    try {

      newCategories = await _homePageRepository.getNewCategories();
      /*allcategories.forEach((element) {
        if(int.parse(element.productCount??"0") > 0 && element.subcategory.length>0){
          categories.add(element);
        }
      });*/
      categoriesLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      categoriesLoadingState = LoadingState.Failed;
      notifyListeners();
    }

  }

  void getCollection() async {
    //add null data so listener can show shimmer widget to indicate loading
    collectionLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      collections = await _homePageRepository.getCollection();
      collectionLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      collectionLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  void getNewArrival() async {
    //add null data so listener can show shimmer widget to indicate loading
    newArrivalLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      newArrivalList = await _homePageRepository.getNewArrival();
      newArrivalLoadingState = LoadingState.Done;
      notifyListeners();
     } catch (error) {
      newArrivalLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  void getOMLive() async {
    //add null data so listener can show shimmer widget to indicate loading
    omLiveLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      OMLiveList = await _homePageRepository.getOMLive();
      omLiveLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      omLiveLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  void getStoreVisitData() async{
    categoriesLoadingState = LoadingState.Loading;
    notifyListeners();
    storeCallList.add('Phone Call');
    storeCallList.add('Video Call');

    storeVisitList.add('Borivali');
    storeVisitList.add('Mulund');


    storeVisitType.add("Store Visit");
    storeVisitType.add("Request a Call");

    storeVisitTypeImage.add("assets/images/store_visit.svg");
    storeVisitTypeImage.add("assets/images/request_call.svg");

    
    categoriesLoadingState = LoadingState.Done;
    notifyListeners();
  }

  void initialise() {

      getCategories();
      getCollection();
      getNewArrival();
      getOMLive();
    //categoriesLoadingState=LoadingState.Done;
    //categories.add('assets/images/ugaani.png');
    //categories.add('assets/images/jodha.png');


    //categoriesLoadingState=LoadingState.Done;
    categoriesbottomone.add('assets/images/arc.png');
    categoriesbottomone.add('assets/images/roz.png');
    categoriesbottomone.add('assets/images/forever.png');


    categoriesbottomtwo.add('assets/images/roz.png');
    categoriesbottomtwo.add('assets/images/forever.png');
    categoriesbottomtwo.add('assets/images/arc.png');


    categoriesnewArrival.add('assets/images/new_arrival.png');


    for(int i=0;i<10;i++){
      Wishlist wishlist=Wishlist();
      wishlist.stock=false;
      /*if(i==0){
        wishlist.stock=true;
      }else{
        wishlist.stock=false;
      }*/
      wishlistList.add(wishlist);
    }


    productList.add('assets/images/product_one.png');
    productList.add('assets/images/product_two.png');
    productList.add('assets/images/product_three.png');

    CompanyNameList.add('Narendra Jakhia');
    CompanyNameList.add('Mukesh Jakhia');
    CompanyNameList.add('Bhavin Jakhia');
    CompanyNameList.add('Bhavna Jakhia');
    CompanyNameList.add('Harsha & Mamta Jakhia');
    CompanyNameList.add('Bhavesh Jakhia');


    CompanyPostList.add('Chairman');
    CompanyPostList.add('Managing Director');
    CompanyPostList.add('Chairman');
    CompanyPostList.add('Head – Digital Ventures');
    CompanyPostList.add('Brand Ambassadors');
    CompanyPostList.add('CMO');



    shopByCategoryList.add('assets/images/cate_one.png');
    shopByCategoryList.add('assets/images/cate_two.png');
    shopByCategoryList.add('assets/images/cate_three.png');

  /*  OMLiveList.add('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    OMLiveList.add('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');*/



   /* wishlistList.add('assets/images/product_image.png');
    wishlistList.add('assets/images/product_image.png');
    wishlistList.add('assets/images/product_image.png');
    wishlistList.add('assets/images/product_image.png');
    wishlistList.add('assets/images/product_image.png');
    wishlistList.add('assets/images/product_image.png');*/
    
    storeCallList.add('Phone Call');
    storeCallList.add('Video Call');

    storeVisitList.add('Borivali');
    storeVisitList.add('Mulund');


    availableslotList.add('11:00 AM');
    availableslotList.add('11:30 AM');
    availableslotList.add('12:00 PM');
    availableslotList.add('12:30 PM');
    availableslotList.add('01:00 PM');
    availableslotList.add('01:30 PM');
    availableslotList.add('02:00 PM');
    availableslotList.add('02:30 PM');
    availableslotList.add('03:00 PM');
    availableslotList.add('03:30 PM');
    availableslotList.add('04:00 PM');
    availableslotList.add('04:30 PM');
    availableslotList.add('05:00 PM');
    availableslotList.add('05:30 PM');
    availableslotList.add('06:00 PM');
    availableslotList.add('06:30 PM');
    availableslotList.add('07:00 PM');


    //
   // getCategories();
    //
    //getPopularVendors();
    //
   // getLocationPermissionStatus();

  }
  
  void getFAQ(){
    omLiveLoadingState = LoadingState.Loading;
    notifyListeners();
    
    faqQuestionList.add("Where is Om Jewellers located?");
    faqQuestionList.add("What is Om Jewellers' specialty?");
    faqQuestionList.add("Do I get a discount?");
    faqQuestionList.add("Is your jewellery certified?");
    faqQuestionList.add("How can I get the latest updates about jewellery offers?");

    faqAnswerList.add("You can visit Om jewellers showrooms at Borivali, Mumbai, and Mulund.");
    faqAnswerList.add("Om Jewellers specializes in every type of jewellery. You can explore everything from bridal jewellery, diamond jewellery, office jewellery, and casual jewellery.");
    faqAnswerList.add("Om jewellers regularly offer discounts on jewellery. Please call the store for details.");
    faqAnswerList.add("Our jewellery is of the highest standard, and we have all the requisite hallmarks to testify the same.");
    faqAnswerList.add("You can get first hand information about latest collections, discounts and more by following our social media pages, or by joining our Facebook group.");


    omLiveLoadingState = LoadingState.Done;
    notifyListeners();

  }

 /* //get location permission status
  void getLocationPermissionStatus() async {
    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      isLocationAvailable = true;
      getNearbyVendors();
    }
  }

  //request location permission
  void requestLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        isLocationAvailable = true;
        getNearbyVendors();
      }
    }
  }

  //getting all nearby
  void getNearbyVendors() async {
    //get current location
    currentLocationData = await location.getLocation();

    //add null data so listener can show shimmer widget to indicate loading
    nearbyLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      nearbyVendors = await vendorRepository.getVendors(
        type: VendorListType.nearBy,
        location: currentLocationData,
      );
      nearbyLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      nearbyLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  //getting all popular
  void getPopularVendors() async {
    //add null data so listener can show shimmer widget to indicate loading
    popularsLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      popularVendors = await vendorRepository.getVendors(
        type: VendorListType.popular,
      );
      popularsLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      popularsLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  //get all categories
  void getCategories() async {
    //add null data so listener can show shimmer widget to indicate loading
    categoriesLoadingState = LoadingState.Loading;
    notifyListeners();

    try {
      categories = await categoryRepository.getCategories();
      categoriesLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      categoriesLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  //
  void changeDeliveryAddress() {
    //show bottomsheet with delivery addresses container
    CustomDialog.showCustomBottomSheet(
      viewContext,
      contentPadding: EdgeInsets.all(20),
      content: DeliverTo(
        onSubmit: (DeliveryAddress deliveryAddres) {
          //update the selected model
          this.selectedDeliveryAddress = deliveryAddres;
          notifyListeners();
        },
      ),
    );
  }

  //
  void openSearchPage() {
    //navigate to search vendors page
    Navigator.pushNamed(
      viewContext,
      AppRoutes.searchVendorsPage,
    );
  }

  //
  void openCategorySearchPage(dynamic data) {
    //
    var category;
    if (data is CategoryBanner) {
      category = data.category;
    } else {
      category = data;
    }

    //navigate to search vendors page
    Navigator.pushNamed(
      viewContext,
      AppRoutes.categoryVendorsRoute,
      arguments: category,
    );
  }

  void changeListingStyle(int style) {
    listingStyle = style;
    notifyListeners();
  }*/

   void openCategoryProductPage({int index}){
    //
   /* var category;
    if (data is CategoryBanner) {
      category = data.category;
    } else {
      category = data;
    }*/

    //navigate to search vendors page
    Navigator.pushNamed(
      viewContext,
      AppRoutes.productListPageRoute,
      arguments: categories[index],
    );

  }

  void openCategorySearchPage(dynamic category) {
    //
    /* var category;
    if (data is CategoryBanner) {
      category = data.category;
    } else {
      category = data;
    }*/

    //navigate to search vendors page
    /*Navigator.pushNamed(
      viewContext,
      AppRoutes.productListPageRoute,
     // arguments: categories[index],
    );*/
  }



  void goToMyAppointPage(dynamic data) async {
    //add null data so listener can show shimmer widget to indicate loading
    /*Navigator.pushNamed(
      viewContext,
      AppRoutes.myAppointmentlistRoute,
      //arguments: category,
    );*/
  }
}
