
import 'package:flutter/material.dart';
import 'package:news_app_project/models/news_model.dart';
import 'package:news_app_project/services/headline_service.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<Article> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData()async{
    final headline =  await HeadlineService().getHeadlines();
    setState(() {
      list = headline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home screen'),
      ),
      body: list.isEmpty ? Center(child: CircularProgressIndicator()) :
          ListView.builder(
            scrollDirection: Axis.horizontal,
             itemCount: list.length,
              itemBuilder: (context,index){
                final article = list[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                     ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(article.urlToImage,height: 300,width: 300,fit: BoxFit.cover,)),
                     Positioned(
                       bottom: -80,
                       child: Card(
                         child: Container(
                           width: 290,
                           height: 160,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                              color: Colors.white
                           ),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(article.title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),maxLines: 2,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(article.author.name,style: TextStyle(fontSize: 12,color: Colors.blue),),
                                     Text(DateFormat('dd MMM yyyy, hh:mm a').format(article.publishedAt),style: TextStyle(fontSize: 10),)
                                   ],
                                 )
                               ],
                             ),
                           ),
                         ),
                       ),
                     )
                    ],

                  ),
                ),
              ],
            );
          })
    );
  }
}
