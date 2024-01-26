import 'dart:convert';

import 'package:inventory_app/model/response_login.dart';
import 'package:http/http.dart' as http;

const host = "192.168.110.238";

class AuthServices {
  Future<ResponseLogin> Login(String email, String password) async {
    final uri = Uri.http(host, "/server_inventory/index.php/api/login");
    final response = await http.post(
      uri,
      body: {
        "email": email,
        "password": password,
      },
    );
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      ResponseLogin responseLogin = ResponseLogin.fromJson(decode);
      return responseLogin;
    } else {
      return ResponseLogin(pesan: "gagal login", sukses: false);
    }
  }
}
