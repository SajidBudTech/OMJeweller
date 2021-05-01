
import 'package:flutter_om_jeweller/bloc/base.bloc.dart';
import 'package:flutter_om_jeweller/constants/string/search.strings.dart';
import 'package:rxdart/rxdart.dart';

class ProductSearchBloc extends BaseBloc {
  //
  int queryCategoryId;
  //VendorRepository instance
 // VendorRepository _vendorRepository = VendorRepository();

  //BehaviorSubjects
  BehaviorSubject<List<String>> _searchVendors = BehaviorSubject<List<String>>();

  //BehaviorSubject stream getters
  Stream<List<String>> get searchVendors => _searchVendors.stream;

  @override
  void initBloc() {
    super.initBloc();
    _searchVendors.addError("");
  }

  void initSearch(String value, {bool forceSearch = false}) async {
    //making sure user entered something before doing an api call
    if (value.isNotEmpty || forceSearch) {
      //add null data so listener can show shimmer widget to indicate loading
      _searchVendors.add(null);

      try {

        /*final vendors = await _vendorRepository.getSearchProduct(
          type: "productSearch",
          keyword: value,
          categoryId: queryCategoryId,
        );*/

        List<String> vendors=[];
        if (vendors.length > 0) {
          _searchVendors.add(vendors);
        } else {
          _searchVendors.addError(SearchStrings.emptyTitle);
        }
      } catch (error) {
        _searchVendors.addError(error);
      }
    }
  }

  void noVendorProcess(){
    _searchVendors.addError(SearchStrings.emptyTitle);
  }
}
