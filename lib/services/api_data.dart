import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/cryptocurrency.dart';

class ApiData {
  static Future<List<dynamic>> getApiData() async {
    try {
      Uri url = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body) as List<dynamic>;

      return jsonData;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Cryptocurrency>> getApiData1({bool isINR = true}) async {
    try {
      List<Cryptocurrency> coins = [];
      Uri url = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=${isINR ? "inr" : "usd"}&order=market_cap_desc&per_page=40&page=1&sparkline=false");
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body) as List<dynamic>;
      for (var market in jsonData) {
        Cryptocurrency token = Cryptocurrency.fromJSON(market);
        print(token);
        coins.add(token);
      }
      return coins;
    } catch (e) {
      return [];
    }
  }
}
