import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/services/auth_services.dart';

class ItemServices {
  // GET DATA
  Future<List<Barang>> getListBarang() async {
    final uri = Uri.http(host, "/server_inventory/index.php/api/getBarang");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      ResponseBarang responseBarang = ResponseBarang.fromJson(decode);
      return responseBarang.barang ?? [];
    } else {
      throw Exception('failed to load barang');
    }
  }

  // UPDATE BARANG
  Future<ResponseBarang> updateBarang(
      String id, String name, String amount, String image) async {
    final uri = Uri.http(host, "/server_inventory/index.php/api/updateBarang");
    final response = await http.post(uri, body: {
      'id': id,
      'nama': name,
      'jumlah': amount,
      'gambar': image,
    });
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      ResponseBarang responseBarang = ResponseBarang.fromJson(decode);
      return responseBarang;
    } else {
      throw Exception('failed to update barang');
    }
  }

  // INSERT BARANG
  Future<ResponseBarang> insertBarang(
      String name, String amount, String image) async {
    final uri = Uri.http(host, "/server_inventory/index.php/api/insertBarang");
    final response = await http.post(uri, body: {
      'nama': name,
      'jumlah': amount,
      'gambar': image,
    });
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      ResponseBarang responseBarang = ResponseBarang.fromJson(decode);
      return responseBarang;
    } else {
      throw Exception('failed to add barang');
    }
  }

  // DELETE BARANG
  Future<ResponseBarang> deleteBarang(String id) async {
    final uri = Uri.http(host, "/server_inventory/index.php/api/deleteBarang");
    final response = await http.post(uri, body: {
      'id': id,
    });
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      ResponseBarang responseBarang = ResponseBarang.fromJson(decode);
      return responseBarang;
    } else {
      throw Exception('failed to delete barang');
    }
  }
}
