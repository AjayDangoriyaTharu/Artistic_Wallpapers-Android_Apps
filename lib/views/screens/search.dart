import 'package:artistic_wallpapers/controller/apiOper.dart';
import 'package:artistic_wallpapers/model/photosModel.dart';
import 'package:artistic_wallpapers/views/screens/fullScreen.dart';
import 'package:flutter/material.dart';
import 'package:artistic_wallpapers/views/widgets/CostomAppBar.dart';
import 'package:artistic_wallpapers/views/widgets/SearchBar1.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchResults;
  bool isLoading = true;

  GetSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetSearchResults();
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
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: SearchBar1()),
                    SizedBox(
                      height: 10,
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
                          itemCount: searchResults.length,
                          itemBuilder: ((context, index) => GridTile(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FullScreen(
                                                imgUrl: searchResults[index]
                                                    .imgSrc)));
                                  },
                                  child: Hero(
                                    tag: searchResults[index].imgSrc,
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
                                            searchResults[index].imgSrc),
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
