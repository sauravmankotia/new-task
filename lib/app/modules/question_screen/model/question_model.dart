class QuestionModel {
  String? questionId;
  String? questionText;
  int? qNumber;

  QuestionModel({this.questionId, this.questionText, this.qNumber});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionText = json['questionText'];
    qNumber = json['qNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['questionText'] = this.questionText;
    data['qNumber'] = this.qNumber;
    return data;
  }
}
