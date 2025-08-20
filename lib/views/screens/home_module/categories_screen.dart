import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_app_project/models/category_model.dart';
import 'package:news_app_project/services/categories_service.dart';
import 'package:news_app_project/views/screens/home_module/categories_details_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<NewCategory> category = [];
  int selectedIndex = 0;
  bool isLoading = false;

  List<String> categories = [
    "General",
    "Business",
    "Entertainment",
    "Health",
    "Sports",
    "Technology"
  ];

  @override
  void initState() {
    super.initState();
    fetchData(categories[selectedIndex]); // fetch first category by default
  }

  void fetchData(String categoryName) async {
    final fetch = await CategoriesService().CategoriesGet(categoryName);
    setState(() {
      category = fetch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("News Categories",style: GoogleFonts.poppins(fontSize: 18.sp,fontWeight: FontWeight.w500),),
      centerTitle: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) {
                bool isActive = selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        isLoading = true;
                      });
                      fetchData(categories[index]);
                      setState(() {
                        isLoading = false;
                      });// fetch selected category news
                    },
                    child: Container(
                      width: 120.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: isActive ? Colors.blue : Colors.grey.shade300,
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: isActive ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // 🔹 News List
          if (category.isEmpty) SpinKitChasingDots(color: Colors.blue,size: 25,) else Expanded(
            child: isLoading ? Center(child: SpinKitChasingDots(color: Colors.blue,size: 25,)) :
            ListView.builder(
                itemCount: category.length,
                itemBuilder: (context,index){
                  final article = category[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>
                              CategoriesDetailsScreen(item: category[index])));
                        },
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

                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: SpinKitChasingDots(
                                          color: Colors.blue,
                                          size: 25,
                                        )
                                      ),
                                    );
                                  },

                                  // ✅ show error if image fails
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.error, size: 80, color: Colors.red),
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
                                            DateFormat('dd MMM yyyy, hh:mm a')
                                                .format(DateTime.parse(article.publishedAt)), // convert String → DateTime
                                            style: GoogleFonts.poppins(
                                              fontSize: 10.sp,
                                            ),
                                          )

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )

                  );

                }),
          ),
        ],
      ),
    );
  }
}
