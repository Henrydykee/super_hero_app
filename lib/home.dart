import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_hero_app/hero_details.dart';
import 'package:super_hero_app/status.dart';
import 'package:super_hero_app/viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HeroViewModel _heroViewModel;
  ValueNotifier<String> _searchQueryNotifier;

  @override
  void initState() {
    super.initState();
    _heroViewModel = Provider.of<HeroViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _heroViewModel.getHeroes();
    });
    _searchQueryNotifier = ValueNotifier<String>('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "HEROES",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer<HeroViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.getStatus() == Status.LOADING) {
              return Center(
                child: SpinKitDoubleBounce(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.white : Colors.black,
                      ),
                    );
                  },
                ),
              );
            }
            return ValueListenableBuilder(
              valueListenable: _searchQueryNotifier,
              builder: (context, _query, _){
                List<HeroItem> heros = _getHeroesByQuery(
                  viewModel.getHeoresList(),
                  searchQuery: _query,
                );
                return  Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,),
                  child: Column(
                    children: [
                      SearchBar(
                        title: "Heroes",
                        onQueryChanged: (String query){_searchQueryNotifier.value = query;
                        },
                      ),
                      SizedBox(height: 15,),
                      Expanded(
                        child: ListView.builder(
                            itemCount: heros.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HeroDetails(
                                          heroItem: heros[index],
                                        )),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: Hero(
                                        tag: viewModel.getHeoresList()[index].images.lg,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(13.0)),
                                          child: CachedNetworkImage(
                                            imageUrl: heros[index].images.md,
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context).size.width,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, top: 5, bottom: 1),
                                      child: Hero(
                                        tag: viewModel.getHeoresList()[index].name,
                                        child: Text(
                                          "${heros[index].name}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15, left: 7, top: 3),
                                      child: Text(
                                        "${heros[index].biography.fullName}",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }

  List<HeroItem> _getHeroesByQuery(List<HeroItem> heoresList, {searchQuery}) {
    if (searchQuery == null || searchQuery.isEmpty){
      return heoresList;
    }
    searchQuery = searchQuery.toLowerCase();
    return heoresList.where((hero){
      return hero.name.toLowerCase().contains(searchQuery) || hero.biography.fullName.toLowerCase().contains(searchQuery);
    }).toList();
  }
}

class SearchBar extends StatelessWidget {
  final String title;
  final Function(String) onQueryChanged;

  SearchBar({this.title, this.onQueryChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white)),
      child: TextField(
        cursorColor: Colors.black,
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(left: 10,),
            child: Icon(Icons.search, color: Colors.black,)
          ),
          hintText: 'Search $title',
          hintStyle: TextStyle(
              color: Colors.white
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
