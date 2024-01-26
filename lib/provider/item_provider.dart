import 'package:flutter/material.dart';
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/services/item_services.dart';

class ItemProvider extends ChangeNotifier {
  final _itemServices = ItemServices();

  var isFetching = false;
  List<Barang> listBarang = [];
  List<Barang> listSearchBarang = [];
  late ResponseBarang responseBarang;

  // fungsi index
  Future getListBarang() async {
    isFetching = true;
    notifyListeners();
    listBarang = await _itemServices.getListBarang();
    isFetching = false;
    notifyListeners();
  }

  // fungsi add
  Future insertBarang(String name, String amount, String image) async {
    final response = await _itemServices.insertBarang(name, amount, image);
    responseBarang = response;
    getListBarang();
  }

  // fungsi update
  Future updateBarang(
      String id, String name, String amount, String image) async {
    final response = await _itemServices.updateBarang(id, name, amount, image);
    responseBarang = response;
    getListBarang();
  }

  // fungsi delete
  Future deleteBarang(String id) async {
    final response = await _itemServices.deleteBarang(id);
    responseBarang = response;
    getListBarang();
  }

  // PENCARIAN BARANG
  void search(String keywords) {
    List<Barang> listSearch = [];
    if (keywords.isEmpty) {
    } else {
      listSearch.clear();
      listSearchBarang = listSearch;
      for (var itemBarang in listBarang) {
        if (itemBarang.barangNama
            .toLowerCase()
            .contains(keywords.toLowerCase())) {
          // NAMBAH KE LIST PENCARIAN
          listSearch.add(itemBarang);
        }
      }
      listSearchBarang = listSearch;
    }
    notifyListeners();
  }

  // get barang
  ItemProvider() {
    getListBarang();
  }
}
