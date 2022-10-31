import 'package:get/get.dart';
import 'package:mentomindtask/app/modules/question_screen/model/question_model.dart';
import 'package:mentomindtask/core/data/network/dio_client.dart';

class QuestionScreenController extends GetxController {
  List<QuestionModel> dataList = [];
  RxBool isLoading = RxBool(true);
  RxInt _itemCount = RxInt(10);

  int get itemCount => _itemCount.value;

  Future<void> loadMoreData() async {
    await Future.delayed(Duration(seconds: 1));
    _itemCount = _itemCount + 10;
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    await ApiRepository().getQuestionList().then((value) => dataList = value);
    print(dataList.length.toString());
    isLoading(false);
  }
}
