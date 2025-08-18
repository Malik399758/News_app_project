import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_project/models/news_model.dart';
import 'package:news_app_project/services/headline_service.dart';
import 'package:intl/intl.dart';

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
          title: Text('News App'),
          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    selectedSource = value;
                    _fetchData();
                  });
                },
                itemBuilder: (context) => [
                      PopupMenuItem(value: 'bbc-news', child: Text('BBC News')),
                      PopupMenuItem(value: 'ary-news', child: Text('ARY News')),
                      PopupMenuItem(value: 'cnn', child: Text('Cnn')),
                      PopupMenuItem(
                          value: 'al-jazeera-english',
                          child: Text('Al-Jazeera-English')),
                    ])
          ],
        ),
        body: list.isEmpty
            ? Center(child: SpinKitThreeBounce(color: Colors.orange,size: 25,))
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
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
                                        color: Colors.orange,
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
                    ],
                  );
                }));
  }
}
