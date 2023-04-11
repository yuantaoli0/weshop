import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/xView.dart';
import 'package:weco_admin/departments/department/controller.dart';

import '../../system_menu/menu_view.dart';
import '../../theme.dart';

class DepartmentView extends XView<DepartmentController> {
  DepartmentView(args, DepartmentController controller)
      : super(args, controller);


// String targetId = '642ed9fab0d2c9d3320cbc7c'; // 这是你要查找的部门ID

// try {
//   Department targetDepartment = departments.firstWhere((department) => department.id == targetId);
//   String targetName = targetDepartment.name;
//   print('Department name: $targetName'); // 输出部门名称
// } catch (e) {
//   print('Department not found'); // 如果没有找到具有给定ID的部门，输出错误信息
// }

  @override
  Widget build(BuildContext context) {

    // if (args.containsKey('department') && args['department'] is Map) {
    //   Map<String, dynamic> department = args['department'];
    //   String? departmentName = department['name'];

    //   if (departmentName != null) {
    //     print('Department name: $departmentName');
    //   } else {
    //     print('Name not found in department');
    //   }
    // } else {
    //   print('Department not found in args');
    // }
    // print('++++++++++++++++++++++++++++++$args');
    // print('-------------------------------$args.name');

    return Scaffold(
      body: SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ignore: prefer_const_constructors
          Expanded(child: SideMenu()),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSearchFile(context),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  //添加员工信息
                  _bulidAddJob(),
                  _buildCountField(),

                  Container(
                    height: 760,
                    width: 1350,
                    color: bgColor,
                    child: obx(
                      () => GridView.builder(
                        shrinkWrap: true,
                        itemCount: ctl.rxEmployes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: defaultPadding,
                                mainAxisSpacing: defaultPadding),
                        itemBuilder: (context, index) =>
                            _buildFileInfoCard(ep: ctl.rxEmployes[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _buildSearchFile(BuildContext context) {
    return Container(
        color: Color(0xFF252525),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            children: [
              Text(
                "岗位管理",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              Spacer(
                flex: 2,
              ),
              //搜索条
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.white)),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: "Search",
                      // ignore: prefer_const_constructors
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      // fillColor: Color.fromARGB(153, 184, 184, 219),
                      filled: true,
                      // ignore: prefer_const_constructors
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      suffixIcon: InkWell(
                        onTap: () {},
                        child: Container(
                          // ignore: prefer_const_constructors
                          padding: EdgeInsets.all(defaultPadding * 0.25),
                          margin: EdgeInsets.symmetric(
                              horizontal: defaultPadding / 10),
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //用户头像
              Container(
                margin: EdgeInsets.only(left: defaultPadding),
                // ignore: prefer_const_constructors
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12)),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/user.png",
                      height: 38,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultPadding / 10),
                      child: Text("Yuantao Li"),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _buildCountField() {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultPadding,
          bottom: defaultPadding * 2,
          left: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: buildJobCount(),
          ),
          Expanded(
            child: buildSwitchDepartment(),
          ),
        ],
      ),
    );
  }

  buildJobCount() {
    return Row(
      children: [
        _buildJobStatistics(
          job: "所有部门岗位",
          count: "20",
        ),
        _buildJobStatistics(
          job: "技术",
          count: "20",
        ),
        _buildJobStatistics(
          job: "前台",
          count: "20",
        ),
        _buildJobStatistics(
          job: "金融",
          count: "20",
        ),
      ],
    );
  }

  _buildJobStatistics({required String job, required String count}) {
    return Row(
      children: [
        Text(job),
        Padding(
          padding:
              EdgeInsets.only(left: defaultPadding / 2, right: defaultPadding),
          child: Container(
            padding: EdgeInsets.all(defaultPadding / 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0),
            ),
            // ignore: prefer_const_constructors
            child: Center(
              // ignore: prefer_const_constructors
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 4),
                child: Text(
                  count,
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildSwitchDepartment() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/more.svg",
              color: Colors.black,
            ),
            label: const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding / 4, vertical: defaultPadding / 4),
              child: Text(
                "更多",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.white),
          ),
        ),
      ],
    );
  }

  Column _bulidAddJob() {
    String targetId = '642ebf18b0d2c9d3320cbc1e'; // 这是你要查找的部门 ID

    TextEditingController nameController = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding, right: defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: prefer_const_constructors
              Expanded(
                child: TextFormField(
                  controller: controller.nameController,
                  focusNode: controller.nameNode,
                  textInputAction: TextInputAction.done,
                  // validator: Validator().notEmpty,
                  decoration: InputDecoration(
                    hintText: args['department']['name'].toString().tr,
                  ),
                  onFieldSubmitted: (String value) {
                    controller.setDepartmentValue(
                        'name', value, ctl.department);
                  },
                ),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Get.defaultDialog(
                        barrierDismissible: false,
                        title: '添加岗位信息',
                        titleStyle: TextStyle(color: Colors.red),
                        content: Column(
                          children: [
                            Text('这是数据'),
                            Text('这是数据'),
                            Text('这是数据'),
                            Text('这是数据'),
                          ],
                        ),
                        cancel: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("取消",
                                style: TextStyle(color: Colors.black))),
                        confirm: ElevatedButton(
                          onPressed: () {
                            ctl.newEmploye(['job']);
                            Get.back();
                          },
                          child:
                              Text("确认", style: TextStyle(color: Colors.black)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                        ));
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding)),
                  icon: const Icon(Icons.add),
                  label: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: defaultPadding / 5),
                    child: Text("Add New"),
                  )),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: defaultPadding),
          child: Container(
            height: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(112, 114, 118, 0.250),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white)),
      child: TextField(
        style: TextStyle(color: Colors.white),
        // ignore: prefer_const_constructors
        decoration: InputDecoration(
          hintText: "Search",
          // ignore: prefer_const_constructors
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          // fillColor: Color.fromARGB(153, 184, 184, 219),
          filled: true,
          // ignore: prefer_const_constructors
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.all(defaultPadding * 0.25),
              margin: EdgeInsets.symmetric(horizontal: defaultPadding / 10),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPrfileCard() {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      // ignore: prefer_const_constructors
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black12)),
      child: Row(
        children: [
          Image.asset(
            "assets/images/user.png",
            height: 38,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 10),
            child: Text("Yuantao Li"),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  _buildFileInfoCard({ep}) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
          color: Color(0xFFB9B9B9),
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultPadding))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(defaultPadding * 0.3),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: SvgPicture.asset(
                    (ep['svgSrc'] ?? 'assets/icons/job_analysts.svg')
                        .toString(),
                    color: Colors.white,
                  ),
                ),
                // ignore: prefer_const_constructors
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ep['name'].toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: defaultPadding * 1.2,
                      fontWeight: FontWeight.w900),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.group,
                      color: Colors.white70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: Text(
                        ep['department'].toString(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later,
                      color: Colors.white70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: Text(
                        ep['createdAt'].toString(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 2.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: defaultPadding * 0.1),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(112, 114, 118, 0.250),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("在职人员"), Text("人数")],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/user.png",
                          height: 30,
                        ),
                        Image.asset(
                          "assets/images/user.png",
                          height: 30,
                        ),
                        Image.asset(
                          "assets/images/user.png",
                          height: 30,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add_circle_outline)),
                          ),
                        ),
                      ],
                    ),
                    Text(ep.count_pepo.toString()),
                  ],
                ),
              ],
            ),
          ]),
    );
  }
}