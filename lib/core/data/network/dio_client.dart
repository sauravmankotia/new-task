import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mentomindtask/app/modules/question_screen/model/question_model.dart';
import 'package:mentomindtask/core/data/network/api_constants.dart';

import '../../../app/modules/home/model/topic_data_model.dart';

class ApiRepository {
  Future<List<TopicDataModel>> getData() async {
    try {
      Response response = await Dio().get(ApiConstants.BASE_URL,
          options: Options(headers: {
            "userid": ApiConstants.USER_ID,
            "token": ApiConstants.TOKEN,
            "Content-Type": ApiConstants.CONTENT_TYPE
          }));
      return (response.data as List)
          .map((e) => TopicDataModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<QuestionModel>> getQuestionList() async {
    try {
      Response response = await Dio().get(ApiConstants.QUESTION_URL,
          options:
              Options(headers: {"Content-Type": ApiConstants.CONTENT_TYPE}));
      return (response.data as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
