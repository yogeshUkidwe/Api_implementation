import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/model/user.dart';

part 'single_user_response.g.dart';
@JsonSerializable()
class SingleUserResponse{
SingleUserResponse();
@JsonKey(name :'data')
  User user;
factory SingleUserResponse.fromJson(Map<String, dynamic> json) => _$SingleUserResponseFromJson(json);
Map<String, dynamic> toJson() => _$SingleUserResponseToJson(this);
}