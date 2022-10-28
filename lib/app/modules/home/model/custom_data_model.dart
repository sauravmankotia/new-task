import 'package:mentomindtask/app/modules/home/model/concept_data_model.dart';

class CustomDataModel {
  String? topicName;
  bool? isParentSelected;
  List<ConceptModelClass>? conceptClass;

  CustomDataModel({this.topicName, this.isParentSelected, this.conceptClass});

  CustomDataModel.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
    isParentSelected = json['isParentSelected'];
    if (json['ConceptClass'] != null) {
      conceptClass = <ConceptModelClass>[];
      json['ConceptClass'].forEach((v) {
        conceptClass!.add(ConceptModelClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicName'] = this.topicName;
    data['isParentSelected'] = this.isParentSelected;
    if (this.conceptClass != null) {
      data['ConceptClass'] = this.conceptClass!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}