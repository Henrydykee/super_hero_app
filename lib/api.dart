import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';


class API {
  HttpClientWithInterceptor client;

  Future<http.Response> getSuperHeroes() async {
    var url = "https://akabab.github.io/superhero-api/api/all.json";
    Map<String, String> headers = {'Content-Type': 'application/json'};
   // headers['Authorization'] = 'Bearer $token';
    return await http.get(url, headers: headers);
  }
}
