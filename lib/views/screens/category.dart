import 'package:artistic_wallpapers/controller/apiOper.dart';
import 'package:artistic_wallpapers/model/photosModel.dart';
import 'package:artistic_wallpapers/views/screens/fullScreen.dart';
import 'package:flutter/material.dart';
import 'package:artistic_wallpapers/views/widgets/CostomAppBar.dart';

class CategoryScreen extends StatefulWidget {
  String query;
  CategoryScreen(
      {super.key,
      required this.query,
      required String catImgUrl,
      required String catName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotosModel> categoryResults;
  bool isLoading = true;

  GetTrendingWallpapers() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: CostomAppBar(
            word1: "Artistic",
            word2: "Wallpaper",
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            "https://images.pexels.com/photos/17146202/pexels-photo-17146202/free-photo-of-couple-laughing.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black38,
                        ),
                        Positioned(
                          left: 165,
                          top: 40,
                          child: Column(
                            children: [
                              Text(
                                "Category",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "Mountains",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 400,
                            crossAxisCount: 2,
                            crossAxisSpacing: 13,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: 16,
                          itemBuilder: ((context, index) => GridTile(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullScreen(
                                              imgUrl: categoryResults[index]
                                                  .imgSrc)));
                                },
                                child: Hero(
                                  tag: categoryResults[index].imgSrc,
                                  child: Container(
                                    height: 700,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.amberAccent,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                          height: 700,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          categoryResults[index].imgSrc),
                                    ),
                                  ),
                                ),
                              )))),
                    )
                  ],
                ),
              ));
  }
}
