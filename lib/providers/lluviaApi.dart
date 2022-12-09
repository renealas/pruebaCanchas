import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class PredictionService {
  Future<int> getLluvia(DateTime fecha) async {
    String date = DateFormat('yyyy-MM-dd').format(fecha);
    Map<String, String> requestHeaders = {
      'X-RapidAPI-Key': 'daa91e6b3dmsha25f055d32e9978p11f771jsn478219c8b24b',
      'X-RapidAPI-Host': 'forecast9.p.rapidapi.com'
    };
    var url = Uri.parse(
        'https://forecast9.p.rapidapi.com/rapidapi/forecast/Santa%20Tecla/summary/');

    var response = await http.get(url, headers: requestHeaders);
    var json = convert.jsonDecode(response.body);

    var jsonResult = json['forecast']['items'][0]['prec']['probability'];

    return jsonResult;
  }
}
