import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_sizes.dart';
import 'package:flutter_om_jeweller/data/models/category.dart';
import 'package:flutter_om_jeweller/data/models/loading_state.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/data/repositories/product.repository.dart';
import 'package:flutter_om_jeweller/data/viewmodels/base.viewmodel.dart';
import 'package:flutter_om_jeweller/data/models/subcategory.dart';
import 'package:flutter_om_jeweller/data/models/collection.dart';
import 'package:flutter_om_jeweller/data/models/gold_rate.dart';
import 'package:flutter_om_jeweller/data/repositories/home.repository.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';


class ProductPageViewModel extends MyBaseViewModel {
  //scroll page details
  ScrollController vendorPageStrollController = new ScrollController();
  //show the empty space between the appbar and the tab with its reach top
  bool makeAppBarTransparent = true;

  LoadingState productByCategoryLoadingState = LoadingState.Loading;
  LoadingState productBySubCategoryLoadingState = LoadingState.Loading;
  LoadingState productByWishlistLoadingState = LoadingState.Loading;
  LoadingState productByIDLoadingState = LoadingState.Loading;

  //Product repository
  ProductRepository _productRepository = ProductRepository();

  HomePageRepository _bannerRepository = HomePageRepository();


  List<GoldRate> goldRate=[];

  List<Product> productbyCategoryList=[];

  List<Product> productbyWishList=[];

  Product product=Product();


  double platiniumRate=0.0;
  //menus of the vendor
  //List<Menu> menus = [];

  //Vendor model
 // Vendor vendor;

  ProductPageViewModel(){
    getGoldRate();
  }

  initialise() {
    vendorPageStrollController.addListener(updateAppBarBackgroundColor);
    getDetails();
  }

  //
  getDetails() async {
    setBusy(true);
    /*try {
      vendor = await _vendorRepository.getVendorDetails(vendorId: vendor.id);
      menus = vendor.menus;
      vendorPageStrollController.notifyListeners();
    } catch (error) {
      setError(error);
    }*/
    setBusy(false);
  }

  //listen to when user scroll to the level when the vendor feature image isn't visible
  //then add background to the appbar else make it transparent
  void updateAppBarBackgroundColor() {
    if (vendorPageStrollController.offset >= AppSizes.vendorPageHeaderCollapseHeight) {
      if (makeAppBarTransparent) {
        makeAppBarTransparent = !makeAppBarTransparent;
      }
    } else {
      if (!makeAppBarTransparent) {
        makeAppBarTransparent = !makeAppBarTransparent;
      }
    }

    notifyListeners();
  }


  void getProductsByCategory({Category category,int categoryId}) async {
    //add null data so listener can show shimmer widget to indicate loading
    productByCategoryLoadingState = LoadingState.Loading;
    notifyListeners();
    final int userId=AuthBloc.getUserID();
    try {
      productbyCategoryList = await _productRepository.getProductByCategories(userID: userId,categoryId: category!=null?category.categoryID:categoryId);
      productByCategoryLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      productByCategoryLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  void getProductsBySubCategory({Subcategory subcategory}) async {
    //add null data so listener can show shimmer widget to indicate loading
    productByCategoryLoadingState = LoadingState.Loading;
    notifyListeners();
    final int userId=AuthBloc.getUserID();
    try {
      productbyCategoryList = await _productRepository.getProductBySubCategories(userID: userId,subCategoryId: subcategory.subcategoryID);
      productByCategoryLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      productByCategoryLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  void getProductsByCollection({Collection collection}) async {
    //add null data so listener can show shimmer widget to indicate loading
    productByCategoryLoadingState = LoadingState.Loading;
    notifyListeners();
    final int userId=AuthBloc.getUserID();
    try {
      productbyCategoryList = await _productRepository.getProductByCollection(userID: userId,collectionId: collection.collectionID);
      productByCategoryLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      productByCategoryLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }

  void getProductsByID({int productID}) async {
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);
    productByIDLoadingState = LoadingState.Loading;
    notifyListeners();
    final int userId=AuthBloc.getUserID();
    try {
      product = await _productRepository.getProductByID(userID: userId,productID:productID);
      product.platinumRate=platiniumRate;
      productByIDLoadingState = LoadingState.Done;
      notifyListeners();
      setBusy(false);
    } catch (error) {
      productByIDLoadingState = LoadingState.Failed;
      notifyListeners();
      setBusy(false);
    }
  }


  @override
  void dispose() {
    super.dispose();
    vendorPageStrollController.dispose();
  }

  void getGoldRate() async{
    //add null data so listener can show shimmer widget to indicate loading
    setBusy(true);

    try {

      goldRate = await _bannerRepository.getGoldRate();

      for(GoldRate goldone in goldRate){
        if(goldone.purityName=="Platinium"){
          platiniumRate=(double.parse(goldone.purityPrice));
        }
      }

    } catch (error) {
      setError(error);
      print("Error getting banners ==> $error");
    }
    setBusy(false);

  }


  void getWishListProducts() async {
    //add null data so listener can show shimmer widget to indicate loading
    productByWishlistLoadingState = LoadingState.Loading;
    notifyListeners();

    final int userId=AuthBloc.getUserID();
    try {
      productbyWishList = await _productRepository.getWishListProduct(userID: userId);
      productByWishlistLoadingState = LoadingState.Done;
      notifyListeners();
    } catch (error) {
      productByWishlistLoadingState = LoadingState.Failed;
      notifyListeners();
    }
  }


}
