import 'package:gd_api_0298/entity/Barang.dart';

import 'dart:convert';
import 'package:http/http.dart';

class BarangClient {
  //sesuaikan url dan endpoint dengan device yang kalian gunakan untuk uji coba sesuai langkah 7

  // untuk emulator
  static final String url = '10.0.2.2:8000'; //base_url
  static final String endpoint = '/api/barang'; //base endpoint

  // untuk hp
  // static final String url = '192.168.1.14';
  // static final String endpoint = '/GD_API_XXXX/public/api/barang";

  //mengambil semua data barang dari API
  static Future<List<Barang>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // mengambil bagian data dari response body
      Iterable list = json.decode(response.body)['data'];

      // list.map untuk membuat list objek Barang berdasarkan tiap elemen dari list
      return list.map((e) => Barang.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengambil data barang dari API sesuai id
  static Future find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id')); //request ke api

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // membuat objek Barang berdasarkan bagian data dari response body
      return Barang.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //membuat data barang baru
  static Future<Response> create(Barang barang) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: barang.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengubah data barang sesuai ID
  static Future<Response> update(Barang barang) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${barang.id}'),
          headers: {"Content-Type": "application/json"},
          body: barang.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(Barang barang) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${barang.id}'),
          headers: {"Content-Type": "application/json"},
          body: barang.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
