import 'package:get/get.dart';
import 'package:mentomindtask/core/data/local/db_helper.dart';

import '../../../../core/data/local/db_model.dart';

class FirstScreenController extends GetxController {
  RxList<DbModel> notesList=RxList();
  RxBool isLoading=RxBool(true);

  @override
  void onInit() {
    getListFromDb();
    super.onInit();
  }

  getListFromDb()async{
    var list =await DatabaseHelper.instance.getDataList();
    list.sort((a,b) => a.dateTimeCreated!.compareTo(b.dateTimeCreated!));
    notesList(list.reversed.toList());
    isLoading(false);
  }

}
