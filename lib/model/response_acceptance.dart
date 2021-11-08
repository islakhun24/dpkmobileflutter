// import 'package:admin_operasional/models/project.dart';

import 'package:dpkmobileflutter/model/project.dart';

class Response_acceptance {
  int status;
  Project data;
  Response_acceptance({required this.status, required this.data});
  factory Response_acceptance.fromJson(Map<String, dynamic> json) {
    return Response_acceptance(
        status: json['status'], data: Project.fromJson(json['data']));
  }
}
