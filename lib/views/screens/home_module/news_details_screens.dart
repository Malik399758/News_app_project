
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_project/models/news_model.dart';

class NewsDetailsScreens extends StatefulWidget {
  final Article item;
  NewsDetailsScreens({super.key,required this.item});

  @override
  State<NewsDetailsScreens> createState() => _NewsDetailsScreensState();
}

class _NewsDetailsScreensState extends State<NewsDetailsScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title.toString(),style: GoogleFonts.poppins(fontSize: 16.sp),),
      ),
      body: Column(
        children: [
          Image.network(widget.item.urlToImage.toString(),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(widget.item.author.toString(),style: GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w400,
                  color: Colors.blue),),
                ),
                SizedBox(width: 5,),
                Text(
                    DateFormat(
                        'dd MMM yyyy, hh:mm a')
                        .format(
                        widget.item.publishedAt),
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.item.description.toString(),style: GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w400),),
          )
        ],
      ),
    );
  }
}
