
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_project/models/news_model.dart';
class HeadlineService{



  var url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=cc03415c9718497bbd184cdf98b057bd';

  Future<List<Article>> getHeadlines()async{
    try{
      final response = await http.get(Uri.parse(url));
      print('json Response ------------> ${response.body}');

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print('data -----------> ${data.toString()}');

        final news = NewsModel.fromJson(data);
        return news.articles;
      }else{
        print('Failed status code ---------> ${response.statusCode}');
      }
    }catch(e){
      print('Error ------------> ${e.toString()}');
    }
    return [];
  }

}