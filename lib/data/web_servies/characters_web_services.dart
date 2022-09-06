// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_api/constants/string.dart';
class CharactersWebServices{
  late Dio dio;
  CharactersWebServices(){
    BaseOptions baseOptions=BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20*1000,//20 sce
      receiveTimeout: 20*1000,
    );
    dio=Dio(baseOptions);
  }
  Future<List<dynamic>> getAllCharacters()async{
    try{
      Response response=await dio.get('characters');
      print(response.data.toString());
      return response.data;
    }catch(e){
      print(e.toString());
      return [];
    }
  }
  Future<List<dynamic>> getCharactersQuotes(String charName)async{
    try{
      Response response=await dio.get('quote',queryParameters: {'author':charName});
      //print(response.data.toString());
      return response.data;
    }catch(e){
      print(e.toString());
      return [];
    }
  }
}