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
import 'package:flutter_om_jeweller/data/viewmodels/count.viewmodel.dart';


class ProductPageViewModel extends MyBaseViewModel {
  //scroll page details
  ScrollController vendorPageStrollController = new ScrollController();
  //show the empty space between the appbar and the tab with its reach top
  bool makeAppBarTransparent = true;

  LoadingState productByCategoryLoadingState = LoadingState.Loading;
  LoadingState productBySubCategoryLoadingState = LoadingState.Loading;
  LoadingState productByWishlistLoadingState = LoadingState.Loading;
  LoadingState productByIDLoadingState = LoadingState.Loading;


  Map<String,bool> availableCategoryMap;
  Map<String,bool> availableSubCategoryMap;
  Map<String,bool> availableCollectionMap;
  Map<String,bool> availableGoldPurityMap;

  //Product repository
  ProductRepository _productRepository = ProductRepository();

  HomePageRepository _bannerRepository = HomePageRepository();


  List<GoldRate> goldRate=[];

  List<Product> productbyCategoryList=[];
  List<Product> productFilterList=[];

  List<Product> productbyWishList=[];

  Product product=Product();


  double platiniumRate=0.0;
  //menus of the vendor
  //List<Menu> menus = [];

  //Vendor model
 // Vendor vendor;

  ProductPageViewModel(BuildContext context){
    this.viewContext=context;
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


  void getProductsByCategory({Category category,var categoryId}) async {
    //add null data so listener can show shimmer widget to indicate loading

    //CountViewModel countViewModel=CountViewModel(viewContext);
    //countViewModel.setWishListCount();

    productByCategoryLoadingState = LoadingState.Loading;
    notifyListeners();
    final int userId=AuthBloc.getUserID();
    try {
      productbyCategoryList = await _productRepository.getProductByCategories(userID: userId,categoryId: category!=null?category.categoryID:categoryId);
      productByCategoryLoadingState = LoadingState.Done;
      productFilterList=productbyCategoryList;
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
      productFilterList=productbyCategoryList;
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
      productbyCategoryList = await _productRepository.getProductByCollection(userID: userId,collectionId: collection.addCollectionId);
      productByCategoryLoadingState = LoadingState.Done;
      productFilterList=productbyCategoryList;
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

  sortProductList(String sortType) async{

    if(sortType=="Price - Low to High") {
      productbyCategoryList.sort((a,b){
        var adate = getProductPrice(a); //before -> var adate = a.expiry;
        var bdate = getProductPrice(b); //before -> var bdate = b.expiry;
        return (adate??0).compareTo(bdate??0);
      });
    }else if(sortType=="Price - High to Low"){
      productbyCategoryList.sort((a,b){
        var adate = getProductPrice(a); //before -> var adate = a.expiry;
        var bdate = getProductPrice(b); //before -> var bdate = b.expiry;
        return (bdate??0).compareTo(adate??0);
      });
    }

  //  print(productbyCategoryList);


    notifyListeners();

  }

  int getProductPrice(Product product) {
    double totalAmount=0;

    double calculatedTotalAmount=0;
    double calculatedTotalWieght=0;


    for(Productattributes productattributes in product.productattributes){
      calculatedTotalAmount=calculatedTotalAmount+double.parse(productattributes.diamondamount??"0");
    }
    for(Productattributes productattributes in product.productattributes){
      calculatedTotalWieght=calculatedTotalWieght+double.parse(productattributes.diamondweight??"0");
    }

    if(int.tryParse(product.productType??"0")==1){
      double makingCharges=double.parse(product.purityPrice??"0")*(double.parse(product.makingwastage??"0")/100);
      double price=((makingCharges+double.parse(product.purityPrice??"0"))*(double.parse(product.netweight)))+double.parse(product.stonecharges??"0");
      double tax=price*((double.parse(product.taxValue??"0"))/100);
      totalAmount=price+tax;
    }else if(int.tryParse(product.productType??"0")==2){

      double price=(((double.parse(product.makingcost??"0")+double.parse(product.purityPrice??"0"))*(double.parse(product.netweight))))+(double.parse(product.stonecharges??"0"))+calculatedTotalAmount;
      double tax=price*((double.parse(product.taxValue??"0"))/100);

      totalAmount=price+tax;

    }else if(int.tryParse(product.productType??"0")==3){
      double platinumAmount=(double.parse(product.platiniummaking??"0")+platiniumRate)*(double.parse(product.platiniumweight??"0"));

      double price=((double.parse(product.makingcost??"0")+double.parse(product.purityPrice??"0"))*(double.parse(product.netweight)))+platinumAmount+(double.parse(product.stonecharges??"0"))+calculatedTotalAmount;
      double tax=price*((double.parse(product.taxValue??"0"))/100);

      totalAmount=price+tax;

    }else if(int.tryParse(product.productType??"0")==4){
      double polkiAmount =(double.parse(product.polkiamount??"0"))*(double.parse(product.polkiweight??"0"));

      double price=((double.parse(product.makingcost??"0")+double.parse(product.purityPrice??"0"))*(double.parse(product.netweight)))+polkiAmount+(double.parse(product.stonecharges??"0"))+calculatedTotalAmount;
      double tax=price*((double.parse(product.taxValue??"0"))/100);

      totalAmount=price+tax;

    }

   // widget.product.productPrice=totalAmount.toInt();


    return totalAmount.toInt();

  }

  filterProductList() async{
    //productFilterList=productbyCategoryList;
    List<Product> newFilterList=[];
    newFilterList.addAll(productFilterList);
    List<Product> filterResult=[];

    /*availableCategoryMap.forEach((key, value) {
      if(value){
         //newFilterList.removeWhere((element) => (element.categoryName??"")!=key);
         final list=newFilterList.where((element) => (element.categoryName??"")==key).toList();
         filterResult.addAll(list.where((element) => !filterResult.contains(element)));
      }
    });

    if(filterResult.length>0) {
      newFilterList.clear();
      newFilterList.addAll(filterResult.where((element) => !newFilterList.contains(element)));
      filterResult.clear();
    }
    availableSubCategoryMap.forEach((key, value) {
      if(value){
         //newFilterList.removeWhere((element) => (element.subcategoryName??"")!=key);
         final list=newFilterList.where((element) => (element.subcategoryName??"")==key).toList();
         filterResult.addAll(list.where((element) => !filterResult.contains(element)));
      }
    });

    if(filterResult.length>0) {
      newFilterList.clear();
      newFilterList.addAll(filterResult.where((element) => !newFilterList.contains(element)));
      filterResult.clear();
    }*/

    availableCollectionMap.forEach((key, value) {
      if(value){
        // newFilterList.removeWhere((element) => (element.collectionName??"")!=key);
         final list=newFilterList.where((element) => (element.collection_Name??"")==key).toList();
         filterResult.addAll(list.where((element) => !filterResult.contains(element)));
      }
    });

    if(filterResult.length>0) {
      newFilterList.clear();
      newFilterList.addAll(filterResult.where((element) => !newFilterList.contains(element)));
      filterResult.clear();
    }

    availableGoldPurityMap.forEach((key, value) {
      if(value){
        //newFilterList.removeWhere((element) => (element.purityName??"")!=key);
         final list =newFilterList.where((element) => (element.purityName??"")==key).toList();
         filterResult.addAll(list.where((element) => !filterResult.contains(element)));
      }
    });

    if(filterResult.length>0) {
      newFilterList.clear();
      newFilterList.addAll(filterResult.where((element) => !newFilterList.contains(element)));
      filterResult.clear();
    }

    /*newFilterList.clear();
    filterResult.forEach((element) {
       if(!newFilterList.contains(element)){
          newFilterList.add(element);
       }
    });*/

    productbyCategoryList=newFilterList;
    notifyListeners();

  }

   clearAll()async{

     availableCategoryMap=null;
     availableSubCategoryMap= null;
     availableCollectionMap= null;
     availableGoldPurityMap= null;

     productbyCategoryList=productFilterList;
     notifyListeners();

  }

  @override
  void dispose() {
    super.dispose();

    availableCategoryMap=null;
    availableSubCategoryMap=null;
    availableCollectionMap=null;
    availableGoldPurityMap=null;

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

   // CountViewModel countViewModel=CountViewModel(viewContext);
    //countViewModel.setWishListCount();

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
