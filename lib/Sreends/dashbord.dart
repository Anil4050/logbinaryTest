import 'package:ecom_list/Controller/ListScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Dashbord extends StatelessWidget {
  const Dashbord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListScreenController controller = Get.put(ListScreenController());

    bool isPrime(N) {
      for (var i = 2; i <= N / i; ++i) {
        if (N % i == 0) {
          return false;
        }
      }
      return true;
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            controller.deleteAll();
          },
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.blueGrey,
                size: 30,
              )),
        ),
        body: Obx(() => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.orange,
              ))
            : Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount:
                            controller.response.data!.orderInfo!.orders!.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool checkPrime = isPrime(controller.response.data!
                              .orderInfo!.orders![index].sequenceNo);
                          return InkWell(
                            onTap: (() {
                              controller.insert(
                                controller.response.data!.orderInfo!
                                    .orders![index].orderId
                                    .toString(),
                                controller.response.data!.orderInfo!
                                    .orders![index].sequenceNo
                                    .toString(),
                                controller.response.data!.orderInfo!
                                    .orders![index].orderType
                                    .toString(),
                                controller.response.data!.orderInfo!
                                    .orders![index].expectedDate
                                    .toString(),
                              );
                            }),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: EdgeInsets.all(15.0),
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 12,
                                      color: Color.fromRGBO(0, 0, 0, 0.16),
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Column(
                                children: [
                                  Text(
                                    controller.response.data!.orderInfo!
                                        .orders![index].orderId
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    !checkPrime
                                        ? controller.response.data!.orderInfo!
                                            .orders![index].sequenceNo
                                            .toString()
                                        : '${controller.response.data!.orderInfo!.orders![index].sequenceNo.toString()}   Its Prime',
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    controller.response.data!.orderInfo!
                                        .orders![index].orderType
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    DateFormat("dd - MM - yyyy").format(
                                        DateTime.parse(controller
                                            .response
                                            .data!
                                            .orderInfo!
                                            .orders![index]
                                            .expectedDate
                                            .toString())),
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )),
      ),
    );
  }
}
