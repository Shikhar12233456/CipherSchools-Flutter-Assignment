import 'package:cipherx/back-end/box.dart';
import 'package:cipherx/back-end/save-data.dart';
import 'package:cipherx/consts/consts.dart';
import 'package:cipherx/models/Expence.dart';
import 'package:cipherx/provider/expence-data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxInt currentIndex = 0.obs;
  final List<String> type = const <String>["Today", "Week", "Month", "Year"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var data = Provider.of<ExpenceDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.withOpacity(0.08),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(25)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("October"),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Service().clear();
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.purple,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.25,
              decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Account Balance",
                      style: textStyle(Colors.grey, 16),
                    ),
                    ValueListenableBuilder(
                        valueListenable: expenceBox.listenable(),
                        builder: (context, value, child) {
                          return Text(
                            "₹ ${Service().getAccountBalance().toString()}",
                            style: textStyle(Colors.black, 38),
                          );
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        containerWithRadius(
                            Column(
                              children: [
                                Text(
                                  "Income",
                                  style: textStyle(
                                      Colors.white.withOpacity(0.7), 14),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: expenceBox.listenable(),
                                    builder: (context, value, child) {
                                      return Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: size.width * 0.40,
                                        child: Text(
                                          "₹ ${Service().getIncome().toString()}",
                                          style: textStyle(Colors.white, 30),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Colors.green,
                            Colors.green,
                            75,
                            size.width * 0.43),
                        containerWithRadius(
                            Column(
                              children: [
                                Text(
                                  "Expanses",
                                  style: textStyle(
                                      Colors.white.withOpacity(0.7), 14),
                                ),
                                ValueListenableBuilder(
                                    valueListenable: expenceBox.listenable(),
                                    builder: (context, value, child) {
                                      return Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: size.width * 0.40,
                                        child: Text(
                                          "₹ ${Service().getExpance().toString()}",
                                          style: textStyle(Colors.white, 30),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Colors.red,
                            Colors.red,
                            75,
                            size.width * 0.43),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: 40,
              child: dPadding(ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          currentIndex.value = index;
                        },
                        child: containerWithRadius(
                            Text(type[index]),
                            currentIndex.value == index
                                ? Colors.amber
                                : Colors.transparent,
                            Colors.transparent,
                            30,
                            70),
                      ),
                    );
                  })),
            ),
            dPadding(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Transaction",
                    style: textStyle(Colors.black, 20),
                  ),
                  containerWithRadius(
                      Text(
                        "See All",
                        style: textStyle(Colors.purple, 14),
                      ),
                      Colors.purple.withOpacity(0.2),
                      Colors.purple.withOpacity(0.1),
                      30,
                      70)
                ],
              ),
            ),
            dPadding(ValueListenableBuilder(
                valueListenable: expenceBox.listenable(),
                builder: (context, dynamic value, Widget? child) {
                  return SizedBox(
                      width: size.width,
                      height: size.height * 0.6,
                      child: ListView.builder(
                          itemCount: data.data.length,
                          itemBuilder: (context, index) {
                            Expence exp = expenceBox.getAt(index);
                            return expanceWidget(exp, size.width * 0.9);
                          }));
                })),
          ],
        ),
      ),
    );
  }

  Widget tabBarViewWithfilter(int filter) {
    return Text(filter.toString());
  }

  Widget expanceWidget(Expence exp, double width) {
    return containerWithRadius(
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 14, bottom: 8, right: 8),
          child: Row(
            children: [
              getIcon(exp.category),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: width * 0.6,
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      exp.category,
                      style: textStyle(Colors.black, 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 26,
                      child: Text(
                        exp.description,
                        style: textStyle(Colors.black.withOpacity(0.5), 16),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "${exp.money[0] == 'E' ? "-" : "+"} ₹${exp.money.substring(1)}",
                    style: TextStyle(
                        color: exp.money[0] == 'E' ? Colors.red : Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(getTime(exp.dateTime))
                ],
              )
            ],
          ),
        ),
        Colors.grey.withOpacity(0.051),
        Colors.transparent,
        100,
        width);
  }
}
