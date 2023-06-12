// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.detail,
  });

  List<Detail> detail;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
  };
}


class Detail {
  Detail({
    required this.loc,
    required this.msg,
    required this.type,
  });

  List<String> loc;
  String msg;
  String type;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    loc: List<String>.from(json["loc"].map((x) => x)),
    msg: json["msg"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "loc": List<dynamic>.from(loc.map((x) => x)),
    "msg": msg,
    "type": type,
  };
}
