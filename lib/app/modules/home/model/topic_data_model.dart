
class TopicDataModel {
  String? topicName;
  List<String>? concepts;

  TopicDataModel({this.topicName, this.concepts});

  TopicDataModel.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
    concepts = json['concepts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicName'] = this.topicName;
    data['concepts'] = this.concepts;
    return data;
  }
}




