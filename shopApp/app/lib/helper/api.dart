import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api{

  Future<List<dynamic>> get({required String url,@required String? token})async
  {
    Map<String,String> headers = {};
    if(token!=null)
    {
        headers.addAll({
          "Authorization" : "Bearer $token"
        });
      }
    else
    {
      headers.addAll({
        'Accept' : 'application/json',
        //'Authorization' : "Bearer $token",
      });
    }
    print("Url = $url\nbody = body\ntoken $token");
    http.Response response = await http.get(Uri.parse(url),headers: headers);
      if(response.statusCode ==200)
        {
          print("data =\n ${response.body}");
          return jsonDecode(response.body);
        }
      else
      {
        throw Exception('There is a problem status code ${response.statusCode}');
      }
  }


  Future<Map<String, dynamic>> post({required String url, required dynamic body,required String? token})async
  {
    Map<String,String> headers = {};
    if(token!=null)
      {

        headers.addAll({
          'Accept' : 'application/json',
          'Content-Type' : 'multipart/form-data',
          'Authorization' : "Bearer $token",
        });
      }
    else{
      headers.addAll({
        'Accept' : 'application/json',
        //'Authorization' : "Bearer $token",
      });
    }
    print("Url = $url\nbody = body\ntoken $token");
    http.Response response = await http.post(Uri.parse(url),
    body: body,
    headers: headers,

    );
    if(response.statusCode ==200)
    {
      Map<String,dynamic> data = jsonDecode(response.body);
      print("data =\n $data");
      return data;
    }
    else
    {
      throw Exception('There is a problem status code ${response.statusCode}');
    }
  }


  Future<Map<String, dynamic>> put({required String url, required dynamic body,required String? token})async
  {
    Map<String,String> headers = {};
    if(token!=null)
    {

      headers.addAll({
        'Accept' : 'application/json',
        'Content-Type' : 'multipart/form-data',
        'Authorization' : "Bearer $token",
      });
    }
    else{
      headers.addAll({
        'Accept' : 'application/json',
        //'Authorization' : "Bearer $token",
      });
    }
    print("Url = $url\nbody = body\ntoken $token");
    http.Response response = await http.put(Uri.parse(url),
      body: body,
      headers: headers,

    );
    if(response.statusCode ==200)
    {
      Map<String,dynamic> data = jsonDecode(response.body);
      print("data =\n $data");
      return data;
    }
    else
    {
      throw Exception('There is a problem status code ${response.statusCode}');
    }
  }
}

