import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:slate/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/apis.dart';

abstract class AuthRemoteDataSource {
  // Future<UserModel> signUp();
  Future<bool> signUp(String idToken, String? nickname, String? profileImageUrl);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final secureStorage = const FlutterSecureStorage();

  @override
  Future<bool> signUp(
      String idToken,
      String? nickname,
      String? profileImageUrl,
  ) async {

    final AT = await secureStorage.read(key: "ACCESS_TOKEN");
    print("at토큰" + AT!);
    try{

      Map bodyData = {
        "idToken": idToken,
        "nickname": nickname,
        "profileImageUrl":profileImageUrl,
      };

      var url = Uri.parse(UserAPI.signupURL());

      var response = await http.post(url,
          headers: { "Authorization": "Bearer $AT"},
          body: json.encode(bodyData)
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        print("idtoken보내서요청"+json.toString());
        // return UserModel.fromJson(
        //   Map<String, dynamic>.from(json['data']),
        // );
      } else {
        print("idtoken보내서요청실패"+json.toString());
        throw HttpException(response.statusCode.toString());
      }
    } catch (e){
      throw SignupException();
    }

    throw UnimplementedError();
  }
}
