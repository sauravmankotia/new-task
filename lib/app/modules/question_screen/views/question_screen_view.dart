import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mentomindtask/app/modules/question_screen/model/question_model.dart';
import 'package:paginable/paginable.dart';

import '../controllers/question_screen_controller.dart';

class QuestionScreenView extends GetView<QuestionScreenController> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(QuestionScreenController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.lightBlue),
        title: Text(
          'Question Screen',
          style:
          Theme.of(context).textTheme.headline6!.copyWith(fontSize: 24),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: PaginableListView.builder(
                  loadMore: controller.loadMoreData,
                  errorIndicatorWidget: (exception, tryAgain) => Container(
                    color: Colors.redAccent,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          exception.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: tryAgain,
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                  progressIndicatorWidget: const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  itemBuilder: (context, index) => CardWidget(element: controller.dataList[index], isColored: index.isEven),
                  itemCount: controller.itemCount),
            )),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.element,
    required this.isColored,
  }) : super(key: key);

  final QuestionModel element;
  final bool isColored;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            child: Text(element.qNumber.toString()),
            decoration: BoxDecoration(
                color: isColored ? Colors.green.shade500 : Colors.grey,
                borderRadius: BorderRadius.circular(5)),
          ),
          VerticalDivider(
            color: Colors.transparent,
          ),
          Expanded(
            child: HtmlWidget(element.questionText!,
              textStyle: TextStyle(fontSize: 15),
              onLoadingBuilder: (context, element, loadingProgress) => CircularProgressIndicator(),

            ),
          ),
          Icon(Icons.arrow_forward_ios_sharp,color: Colors.grey.shade400,)
        ],
      ),
    );
  }
}
