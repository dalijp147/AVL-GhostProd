import 'package:flutter/material.dart';

List<Notificationf> notificationFromJson(dynamic str) =>
    List<Notificationf>.from((str).map((x) => Notificationf.fromJson(x)));

class Notificationf {
  late String? titre, description, id;

  Notificationf({
    this.id,
    this.titre,
    this.description,
  });

  Notificationf.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    titre = json["titre"];
    description = json["description"];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["_id"] = this.id;
    _data["titre"] = this.titre;
    _data["description"] = this.description;

    return _data;
  }
}
