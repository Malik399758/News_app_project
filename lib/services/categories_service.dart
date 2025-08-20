
import 'dart:convert';

import 'package:news_app_project/models/category_model.dart';
import 'package:news_app_project/models/source_model.dart';
import 'package:http/http.dart' as http;

class CategoriesService{


  Future<List<NewCategory>> CategoriesGet(String category)async{
    var url = 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=cc03415c9718497bbd184cdf98b057bd';

    try{

      final response = await http.get(Uri.parse(url));
      print('Json Response ---------> ${response.body}');

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print('Response data ------------> ${data.toString()}');

        List<NewCategory> source = [];
        final categoryModel = data["articles"];
        for(var i in categoryModel){
          source.add(NewCategory.fromJson(i));
        }
        return source;
      }else{
        print('Failed status code ----------> ${response.statusCode}');
      }
    }catch(e){
      print('Error ---------> ${e.toString()}');
    }
    return [];
  }

}