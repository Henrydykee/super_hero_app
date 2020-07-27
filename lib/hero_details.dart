import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:super_hero_app/model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HeroDetails extends StatefulWidget {
  final HeroItem heroItem;

  HeroDetails({this.heroItem});

  @override
  _HeroDetailsState createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails> {
  String Image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Image = widget.heroItem.images.lg;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Hero(
          tag: widget.heroItem.name,
          child: Text(widget.heroItem.name,style: TextStyle(
            color: Colors.white
          ),),
        ),
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 25,right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: widget.heroItem.images.lg,
                      child: CachedNetworkImage(
                        imageUrl: Image,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  SizedBox(height: 7,),
                  Text(widget.heroItem.biography.fullName,style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                  ),),
                  SizedBox(height: 7,),
                  Text(widget.heroItem.biography.publisher,style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                  ),)
                ],
              ),
              SizedBox(height: 30,),
              Text("PowerStats",style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              Text("Intelligence".toUpperCase()+ "-${widget.heroItem.powerstats.intelligence}%" ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
              ),),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 6000,
                percent: widget.heroItem.powerstats.intelligence.toDouble() / 100.0,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.red,
              ),
              SizedBox(height: 20,),
              Text("strength".toUpperCase()+ "-${widget.heroItem.powerstats.strength}%" ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
              ),),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 6000,
                percent: widget.heroItem.powerstats.strength.toDouble() / 100.0,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.green,
              ),
              SizedBox(height: 20,),
              Text("speed".toUpperCase()+ "-${widget.heroItem.powerstats.speed}%" ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
              ),),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 6000,
                percent: widget.heroItem.powerstats.speed.toDouble() / 100.0,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.yellow,
              ),
              SizedBox(height: 20,),
              Text("durability".toUpperCase()+ "-${widget.heroItem.powerstats.durability}%" ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
              ),),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 6000,
                percent: widget.heroItem.powerstats.durability.toDouble() / 100.0,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.blue,
              ),
              SizedBox(height: 20,),
              Text("power".toUpperCase()+ "-${widget.heroItem.powerstats.power}%" ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
              ),),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 6000,
                percent: widget.heroItem.powerstats.power.toDouble() / 100.0,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.purple,
              ),
              SizedBox(height: 20,),
              Text("combat".toUpperCase()+ "-${widget.heroItem.powerstats.combat}%" ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
              ),),
              SizedBox(height: 10,),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 15.0,
                animationDuration: 6000,
                percent: widget.heroItem.powerstats.combat.toDouble() / 100.0,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.deepPurpleAccent,
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}





