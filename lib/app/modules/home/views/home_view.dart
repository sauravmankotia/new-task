import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Obx(() => !controller.isLoading.value
            ? FloatingActionButton.extended(
                label: Container(
                  width: Get.width * 0.8,
                  child: Center(
                    child: Text("Create",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 18, color: Colors.white)),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  controller.saveDataToDb();
                },
                isExtended: true,
              )
            : Container()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.lightBlue),
          title: Text(
            'Create New Test',
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 24),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  height: Get.height,
                  child: Center(child: CircularProgressIndicator()))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.lightBlue, width: 1.5),
                                  borderRadius: BorderRadius.circular(12)),
                              width: Get.width * 0.9,
                              height: 70,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.lightBlue,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          controller.textEditingController,
                                      decoration: InputDecoration(
                                          hintText: "Test Name",
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "Topics",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Colors.lightBlue),
                              )),
                          GetBuilder<HomeController>(builder: (controller) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.dataList.length,
                                itemBuilder: (context, parentIndex) {
                                  return Theme(
                                    data: ThemeData(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      childrenPadding:
                                          EdgeInsets.only(left: 30),
                                      backgroundColor: Colors.transparent,
                                      leading: Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor:
                                                Colors.lightBlue),
                                        child: Checkbox(
                                          value: controller
                                              .createdList[parentIndex]
                                              .isParentSelected,
                                          onChanged: (val) {
                                            controller.toggleParent(
                                                val!, parentIndex);
                                          },
                                        ),
                                      ),
                                      title: Text(
                                        controller
                                            .dataList[parentIndex].topicName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      children: [
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .createdList[parentIndex]
                                                .conceptClass!
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      controller
                                                          .createdList[
                                                              parentIndex]
                                                          .conceptClass![index]
                                                          .subtitle!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    leading: Checkbox(
                                                      value: controller
                                                          .createdList[
                                                              parentIndex]
                                                          .conceptClass![index]
                                                          .isChildSelected,
                                                      onChanged: (val) {
                                                        controller.toggleChild(
                                                            val!,
                                                            parentIndex,
                                                            index);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                  );
                                });
                          }),
                          Container(height: Get.height*0.15,)
                        ],
                      ),
                    ],
                  ),
                ),
        ));
  }
}
