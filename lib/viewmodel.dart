import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:super_hero_app/api.dart';
import 'package:super_hero_app/model.dart';
import 'package:super_hero_app/status.dart';

class HeroViewModel with ChangeNotifier{

  Status _status;
  String errorMessage =" ";
  var _api = API();
 List <HeroItem>  _heroItem;
  List<HeroItem> getHeoresList() => _heroItem;

  Status getStatus(){
    return _status;
  }


  void getHeroes(){
    _status = Status.LOADING;
    notifyListeners();
    _api.getSuperHeroes().then((response){
      print(response.statusCode);
      if(response.statusCode == 200){
        _status = Status.SUCCESSFUL;
        notifyListeners();
        List<HeroItem> Hero = HeroList.fromJson(json.decode(response.body)).hero;
        _heroItem = Hero;
        print(response.body);
      }else {
        _status = Status.FAILED;
        notifyListeners();
      }
    }).catchError((onError){
      _status =Status.FAILED;
      notifyListeners();
      print(onError);
    });
  }
}