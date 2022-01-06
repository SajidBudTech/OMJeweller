import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_om_jeweller/data/models/product.dart';
import 'package:flutter_om_jeweller/data/repositories/product.repository.dart';
import 'package:flutter_om_jeweller/data/repositories/home.repository.dart';
import 'package:flutter_om_jeweller/bloc/auth.bloc.dart';
import 'package:flutter_om_jeweller/data/models/gold_rate.dart';

class ProductSearchBloc extends BaseBloc {
  //
  int queryCategoryId;
  //VendorRepository instance
  ProductRepository _productRepository = ProductRepository();
  HomePageRepository _bannerRepository = HomePageRepository();
  List<GoldRate> goldRate=[];
  double platiniumRate=0.0;
  //BehaviorSubjects
  BehaviorSubject<List<Product>> _searchProducts =
      BehaviorSubject<List<Product>>();

  //BehaviorSubject stream getters
  Stream<List<Product>> get searchProducts => _searchProducts.stream;


  BehaviorSubject<List<String>> _searchVendors =
  BehaviorSubject<List<String>>();

  //BehaviorSubject stream getters
  Stream<List<String>> get searchVendors => _searchVendors.stream;


  @override
  void initBloc() {
    super.initBloc();
     getGoldRate();
    _searchProducts.addError("");
  }

  void initSearch(String value) async {
    //making sure user entered something before doing an api call
    if (value.isNotEmpty) {
      //add null data so listener can show shimmer widget to indicate loading
      _searchProducts.add(null);
      final int userID = AuthBloc.getUserID();
      try {
        final products = await _productRepository.getSerachProduct(
            userID: userID, keyword: value);
        if (products.length > 0) {
          _searchProducts.add(products);
        } else {
          _searchProducts.addError(SearchStrings.emptyTitle);
        }
      } catch (error) {
        _searchProducts.addError(error);
      }
    }
  }

  void noVendorProcess() {
    _searchProducts.addError(SearchStrings.emptyTitle);
  }

  void getGoldRate() async{
    //add null data so listener can show shimmer widget to indicate loading
    try {

      goldRate = await _bannerRepository.getGoldRate();
      for(GoldRate goldone in goldRate){
        if(goldone.purityName=="Platinium"){
          platiniumRate=(double.parse(goldone.purityPrice));
        }
      }

    } catch (error) {
      goldRate.add(error);
      print("Error getting banners ==> $error");
    }


  }
}
