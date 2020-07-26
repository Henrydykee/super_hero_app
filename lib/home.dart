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
  List responseList;

  @override
  void initState() {
    super.initState();
    _heroViewModel = Provider.of<HeroViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _heroViewModel.getHeroes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("HEROES",style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Icon(Icons.search),
            )
          ],
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
            return ListView.builder(
                itemCount: viewModel.getHeoresList()?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HeroDetails(
                            heroItem: viewModel.getHeoresList()[index],
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
                                  imageUrl:
                                      viewModel.getHeoresList()[index].images.md,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 7, top: 5, bottom: 1),
                            child: Hero(
                              tag: viewModel.getHeoresList()[index].name,
                              child: Text(
                                "${viewModel.getHeoresList()[index].name}",
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
                              "${viewModel.getHeoresList()[index].biography.fullName}",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
