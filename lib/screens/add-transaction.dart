import 'package:cipherx/back-end/save-data.dart';
import 'package:cipherx/consts/consts.dart';
import 'package:cipherx/models/Expence.dart';
import 'package:cipherx/provider/catagory-dropdown-provider.dart';
import 'package:cipherx/provider/type-provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final moneyController = TextEditingController();
  final descriptionController = TextEditingController();
  RxBool expense = true.obs;
  var usr = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryDropDownProvider>(context);
    final typeProvider = Provider.of<TypeDropDownProvider>(context);

    return Obx(() => Scaffold(
          backgroundColor: expense.value
              ? Colors.blue
              : const Color.fromARGB(255, 115, 74, 237).withOpacity(0.9),
          appBar: AppBar(
              backgroundColor: expense.value
                  ? Colors.blue
                  : const Color.fromARGB(255, 115, 74, 237).withOpacity(0.9),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  )),
              centerTitle: true,
              title: GestureDetector(
                onTap: () {
                  expense.toggle();
                },
                child: Text(
                  expense.value ? "Expence" : "Income",
                  style: textStyle(Colors.white, 18),
                ),
              )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                dPadding(
                  Container(
                    color: Colors.transparent,
                    height: size.height * 0.38,
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 10),
                          child: Text(
                            "How much?",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: moneyController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            cursorHeight: 40,
                            // showCursor: false,
                            style: const TextStyle(
                                color: Colors.white, height: 1, fontSize: 50),
                            decoration: InputDecoration(
                                // fillColor: Colors.white,
                                // filled: true,
                                isDense: true,
                                isCollapsed: true,
                                hintText: "0",
                                hintStyle: textStyle(Colors.white, 50),
                                prefixIcon: const Icon(
                                  Icons.currency_rupee_outlined,
                                  size: 55,
                                  color: Colors.white,
                                ),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    height: size.height * 0.5,
                    width: size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        containerWithRadius(
                            DropdownButton(
                                underline: Container(),
                                isExpanded: true,
                                value: categoryProvider.selectedItem,
                                items: CategoryDropDownProvider.items
                                    .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            e,
                                            style: textStyle(
                                                Colors.black.withOpacity(0.5),
                                                16),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (String? value) {
                                  categoryProvider.setSelectedItem(value!);
                                }),
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                            50,
                            size.width * 0.9),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        containerWithRadius(
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextField(
                                controller: descriptionController,
                                decoration: InputDecoration(
                                    hintText: "Description",
                                    hintStyle: textStyle(
                                        Colors.black.withOpacity(0.5), 16),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                              ),
                            ),
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                            50,
                            size.width * 0.9),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        containerWithRadius(
                            DropdownButton(
                                underline: Container(),
                                isExpanded: true,
                                value: typeProvider.selectedItem,
                                items: TypeDropDownProvider.items
                                    .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            e,
                                            style: textStyle(
                                                Colors.black.withOpacity(0.5),
                                                16),
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (String? value) {
                                  typeProvider.setSelectedItem(value!);
                                }),
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                            50,
                            size.width * 0.9),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        TextButton(
                            onPressed: () {
                              Service()
                                  .saveExpence(
                                      Expence(
                                          category:
                                              categoryProvider.selectedItem,
                                          description:
                                              descriptionController.text,
                                          type: typeProvider.selectedItem,
                                          money: expense.value
                                              ? "E${moneyController.text}"
                                              : "I${moneyController.text}",
                                          dateTime: DateTime.now().toString()),
                                      usr!)
                                  .whenComplete(() {
                                Get.showSnackbar(const GetSnackBar(
                                  duration: Duration(seconds: 2),
                                  title: "Seuccess",
                                  message: "Data Stored Successfully",
                                ));
                                moneyController.clear();
                                descriptionController.clear();
                                typeProvider.setSelectedItem("Wallet");
                                categoryProvider.setSelectedItem("Category");
                              });
                            },
                            child: containerWithRadius(
                                const Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Color.fromARGB(255, 115, 74, 237)
                                    .withOpacity(0.9),
                                Colors.transparent,
                                50,
                                size.width * 0.9))
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
