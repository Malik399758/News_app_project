import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/models/news_model.dart';
import 'package:news_app_project/services/headline_service.dart';
import 'package:intl/intl.dart';
import 'package:news_app_project/views/screens/home_module/categories_screen.dart';
import 'package:news_app_project/views/screens/home_module/news_details_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedSource = 'bbc-news';
  List<Article> list = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final headline = await HeadlineService().getHeadlines(selectedSource);
    setState(() {
      list = headline;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
            CategoriesScreen()));
          }, icon: Icon(Icons.category)),
          title: Text('News App',style: GoogleFonts.poppins(fontSize: 18.sp,fontWeight:FontWeight.w500),),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    selectedSource = value;
                    _fetchData();
                  });
                },
                itemBuilder: (context) => [
                      PopupMenuItem(value: 'bbc-news', child: Text('BBC News',style : GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w500))),
                      PopupMenuItem(value: 'ary-news', child: Text('ARY News',style : GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w500))),
                      PopupMenuItem(value: 'cnn', child: Text('Cnn',style : GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w500))),
                      PopupMenuItem(
                          value: 'al-jazeera-english',
                          child: Text('Al-Jazeera-English',style : GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w500))),
                    ])
          ],
        ),
        body: list.isEmpty
            ? Center(child: SpinKitThreeBounce(color: Colors.blue,size: 25,))
            : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final article = list[index];
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      NewsDetailsScreens(item: list[index])));
                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            article.urlToImage ?? '',
                                            height: 260,
                                            width: 300,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return SizedBox(
                                                height: 260,
                                                width: 300,
                                                child: Center(
                                                  child: SpinKitChasingDots(
                                                    color: Colors.blue,
                                                    size: 30,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, error, stackTrace) => SizedBox(
                                              height: 260,
                                              width: 300,
                                              child: Icon(Icons.error, size: 40, color: Colors.red),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -60,
                                          child: Card(
                                            child: Container(
                                              width: 290,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      article.title.toString(),
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 13.sp,
                                                          fontWeight: FontWeight.w500),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(article.author ?? '',
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 10.sp,
                                                                  color: Colors.blue),overflow: TextOverflow.ellipsis,),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Text(
                                                            DateFormat(
                                                                    'dd MMM yyyy, hh:mm a')
                                                                .format(
                                                                    article.publishedAt),
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 10.sp,
                                                            ))
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
                                ),
                  
                              ],
                            ),
                          ],
                        );
                      }),
                ),

                // second list
                if (list.isEmpty) SpinKitChasingDots(color: Colors.blue,size: 25,) else Expanded(
                      child: ListView.builder(
                         itemCount: list.length,
                          itemBuilder: (context,index){
                        final article = list[index];
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) =>
                              NewsDetailsScreens(item: list[index])));
                            },
                            child: Card(
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  article.urlToImage.toString(),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  // Loading Spinner
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        height: 80.h,
                                        width: 80.w,
                                        child: SpinKitCircle(
                                          color: Colors.blue,  // Change color if needed
                                          size: 30,
                                        ),
                                      ),
                                    );
                                  },
                                  // Error Image
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error, size: 80),
                                ),
                              ),

                              SizedBox(width: 8),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article.title.toString(),
                                              style: GoogleFonts.poppins(fontSize: 10),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(article.author.toString(),style: GoogleFonts.poppins(fontSize: 10.sp,fontWeight: FontWeight.w400,
                                                      color: Colors.blue),overflow: TextOverflow.ellipsis,),
                                                ),
                                                SizedBox(width: 5,),
                                                Text(
                                                    DateFormat(
                                                        'dd MMM yyyy, hh:mm a')
                                                        .format(
                                                        article.publishedAt),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10.sp,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )

                        );
                      
                      }),
                    )
              ],
            ));
  }
}
