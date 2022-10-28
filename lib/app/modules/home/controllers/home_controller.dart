import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mentomindtask/app/modules/home/model/concept_data_model.dart';
import 'package:mentomindtask/app/modules/home/model/custom_data_model.dart';
import 'package:mentomindtask/app/routes/app_pages.dart';
import 'package:mentomindtask/core/data/network/dio_client.dart';

import '../../../../core/data/local/db_helper.dart';
import '../../../../core/data/local/db_model.dart';
import '../model/topic_data_model.dart';

abstract class _HomeImplements{
  toggleParent(bool val, index) ;

  toggleChild(bool val, parentIndex, childIndex) ;

  checkIfAllSelected(bool val, index);

  getApiData();

  saveDataToDb();
}

class HomeController extends GetxController implements _HomeImplements{
  List<TopicDataModel> dataList = [];
  RxBool isLoading = RxBool(true);
  TextEditingController textEditingController=TextEditingController();
  List<CustomDataModel> createdList = [];

  @override
  void onInit() async {
    await getApiData();
    createdList = List.generate(dataList.length, (index) {
      return CustomDataModel(
          topicName: dataList[index].topicName,
          isParentSelected: false,
          conceptClass: List.generate(
              dataList[index].concepts!.length,
              (index2) => ConceptModelClass(
                  isChildSelected: false,
                  subtitle: dataList[index].concepts![index2])));
    });
    isLoading(false);
    super.onInit();
  }


  @override
  toggleParent(bool val, index) {
    createdList[index].isParentSelected = val;
    createdList[index].conceptClass!.forEach((element) {
      element.isChildSelected = val;
    });
    update();
  }

  @override
  toggleChild(bool val, parentIndex, childIndex) {
    createdList[parentIndex].conceptClass![childIndex].isChildSelected = val;
    checkIfAllSelected(val, parentIndex);
    update();
  }

  @override
  checkIfAllSelected(bool val, index) {
    if (createdList[index]
        .conceptClass!
        .every((element) => element.isChildSelected == true)) {
      toggleParent(true, index);
    } else {
      createdList[index].isParentSelected = false;
    }
    update();
  }

  @override
  getApiData() async {
    await ApiRepository().getData().then((List<TopicDataModel> value) {
      dataList = value;
    });
  }

  @override
  saveDataToDb(){
    if(textEditingController.text.isEmpty){
      BotToast.showText(text: "Please add test name");
      return ;
    }
    Random random =  Random();
    int randomId = random.nextInt(10000);
    DatabaseHelper.instance.saveDataToDb(DbModel(id:randomId ,dateTimeCreated:DateTime.now().toString() ,title:textEditingController.text.trim() ));
    Get.offAllNamed(Routes.FIRST_SCREEN);
    BotToast.showText(text: "Test created successfully");
  }
}
