import 'package:artistic_wallpapers/controller/apiOper.dart';
import 'package:artistic_wallpapers/model/photosModel.dart';
import 'package:artistic_wallpapers/views/screens/fullScreen.dart';
import 'package:flutter/material.dart';
import 'package:artistic_wallpapers/views/widgets/CostomAppBar.dart';
import 'package:artistic_wallpapers/views/widgets/SearchBar1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<PhotosModel> trendingWallList;
  bool isLoading = true;

  GetTrendingWallpapers() async {
    trendingWallList = await ApiOperations.getTrendingWallpaers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetTrendingWallpapers();
  }

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
        body: isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SearchBar1()),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                height: 900,
                child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 400,
                      crossAxisCount: 2,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: trendingWallList.length,
                    itemBuilder: ((context, index) => GridTile(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                          imgUrl:
                                              trendingWallList[index].imgSrc)));
                            },
                            child: Hero(
                              tag: trendingWallList[index].imgSrc,
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
                                      trendingWallList[index].imgSrc),
                                ),
                              ),
                            ),
                          ),
                        ))),
              )
            ],
          ),
        ));
  }
}
