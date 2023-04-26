import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map/Models/event.dart';

import '../Models/notif.dart';
import '../controller/config.dart';
import '../Models/cart.dart';
import '../widget/product_item.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/notif.dart';
import '../Models/cart_service.dart';
import '../Models/product.dart';

class APIService {
  static var client = http.Client();
  static Future<List<Product>?> getProduct() async {
    Map<String, String> requestheader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.productURL);
    var response = await client.get(url, headers: requestheader);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return productsFromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future<List<Notificationf>?> getnotification() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.notifUrl);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return notificationFromJson(data['data']);
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  // static Future<List<Notificationf>> getnotification() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   var url = Uri.http(Config.apiURL, Config.notifUrl);
  //   try {
  //     var response = await client.get(url, headers: requestHeaders);

  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       return notificationFromJson(data);
  //     } else {
  //       throw Exception('Failed to load notifications');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception('Failed to connect to the server');
  //   }
  // }

  static Future<List<Event>?> getevent(String name) async {
    Map<String, String> requestheader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.eventUrl + name);
    print(url);
    // "10.0.2.2:5000/api/calendar/get-events-flutter?title=$name"
    var response = await client.get(
      url,
      headers: requestheader,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(response.body);
      return eventFromJson(data["data"]);
    } else {
      return null;
    }
  }

  // static Future<List<Event>> getEvents(String name) async {
  //   final String apiUrl =
  //       'http://10.0.2.2:5000/api/calendar/get-events-flutter';
  //   final Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   final String url = '$apiUrl?title=$name';

  //   final response = await http.get(Uri.parse(url), headers: headers);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);

  //     print(data);
  //     return data;
  //   } else {
  //     throw Exception('Failed to fetch events');
  //   }
  // }
  static Future<List<Event>> getEvents(String name) async {
    final String apiurl =
        'http://10.0.2.2:5000/api/calendar/get-events-flutter';
    final String url = '$apiurl?title=$name';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      print(data);
      final events = data.map((eventData) {
        return Event(
          title: eventData['title'],
          from: DateTime.parse(eventData['start']),
          to: DateTime.parse(eventData['end']),
        );
      }).toList();

      return events;
    } else {
      throw Exception('Failed to fetch events');
    }
  }

  // ignore: avoid_types_as_parameter_names
  static Future<bool?> savecart(d, l, listdate, numero, total) async {
    print(d);
    Map<String, String> requestheader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.cartUrl);
    var response = await client.post(url,
        headers: requestheader,
        body: jsonEncode({
          "client_id": "63b0aab1a97e288c85b1d91b",
          "produits": d,
          "localisation": l,
          "DatePeriod": listdate,
          "NumberTel": numero,
          "total": total
        }));

    if (response.statusCode == 200) {
      var data = jsonEncode(response.body);
      print(data);
      return true;
    } else {
      return null;
    }
  }

  static Future<bool?> saveevent(z, d) async {
    print(d);
    Map<String, String> requestheader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.eventUrl);
    var response = await client.post(url,
        headers: requestheader, body: jsonEncode({"start": z, "end": d}));

    if (response.statusCode == 200) {
      var data = jsonEncode(response.body);
      print(data);
      return true;
    } else {
      return null;
    }
  }
}
