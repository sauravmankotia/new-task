import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentomindtask/app/routes/app_pages.dart';

import '../../../../core/data/local/db_model.dart';
import '../controllers/first_screen_controller.dart';

class FirstScreenView extends GetView<FirstScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mock Test App',
          style: Theme
              .of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 24),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.3,
              child: Image.asset("assets/test_back.jpg", fit: BoxFit.fill,),),
            Divider(color: Colors.transparent,),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),),
              color: Colors.lightBlue,
              onPressed: () {
                Get.toNamed(Routes.HOME);
              },
              child: Container(
                  width:MediaQuery.of(context).size.width * 0.8,
                  height: kMinInteractiveDimension,

                  child: Center(child: Text("Create New Test", style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold)))),),
            Divider(color: Colors.transparent,),
            Divider(color: Colors.lightBlue, thickness: 3,),
            Divider(color: Colors.transparent,),
            Obx(() =>
            controller.isLoading.value ? Center(
                child: CircularProgressIndicator()) : Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: controller.notesList != null &&
                    controller.notesList.isNotEmpty ? Column(
                    children: controller.notesList.map((element) =>
                        CardWidget(element: element)).toList()):Container(child: Text("No test Available"),))),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.element,
  }) : super(key: key);

  final DbModel element;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.parse(element.dateTimeCreated!);
    var formattedDate = DateFormat('MMM MM, yyy hh:mm aaa').format(date);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(element.title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Created on ", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey.shade700),),
                SizedBox(height: 50,),
                Text(formattedDate, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey)),
              ],),
          )
        ],
      ),
    );
  }
}
