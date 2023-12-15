import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/number/number_separator.dart';
import 'package:hesabdar/controller/financial_controllers/asset_controller.dart';
import 'package:hesabdar/controller/financial_controllers/report_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/view/financial/money_asset_page.dart';
import 'package:url_launcher/url_launcher.dart' as luncher;
import 'package:percent_indicator/percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ReportController reportController = Get.put(ReportController());
  final AssetController assetController = Get.put(AssetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// choose month
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 86, 252, 224)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            reportController.changeResultDateAdd(-1);
                            reportController.allResultTodo();
                            reportController.allPaymentResult();
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                    //
                    Obx(
                      () => Text(
                        "${replaceNumbersToMonth(reportController.chosseDate.value.month.toString())} ${replaseingNumbersEnToFa(reportController.chosseDate.value.year.toString())}",
                        style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(164, 0, 0, 0)),
                      ),
                    ),
                    //
                    IconButton(
                        onPressed: () {
                          setState(() {
                            reportController.changeResultDateAdd(1);
                            reportController.allResultTodo();
                            reportController.allPaymentResult();
                          });
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
//
              SizedBox(
                height: 25,
              ),
              Card(
                elevation: 0,
                color: AllColors.kListItems,
                child: ListTile(
                    title: Text('مدیریت منابع مالی'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Get.to(MoneyAssetPage());
                      assetController.isEditOrSelect = true;
                    }),
              ),
              Card(
                elevation: 0,
                color: AllColors.kListItems,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExpansionTile(
                      title: Text('گزارش کارها'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 0, 15, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'میزان اتمام کارها:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                  height: 120,
                                  child: Obx(
                                    () => CircularPercentIndicator(
                                      radius: 45,
                                      lineWidth: 12,
                                      percent: reportController
                                          .todoMonthlyResultProsess()
                                          .value,
                                      progressColor:
                                          Color.fromARGB(255, 5, 165, 170),
                                      backgroundColor: Get.isDarkMode
                                          ? Colors.white
                                          : Color.fromARGB(255, 201, 245, 253),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      center: Text(
                                          '${reportController.todoMonthlyResult()}%'),
                                      animation: true,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        // emergency Todo's
                        LinerPercent(
                          number: 1,
                          percent: 0.45,
                          percentText: '45%',
                          title: 'کارهای اضطراری',
                        ),
                        // emportant Todo's
                        LinerPercent(
                          number: 2,
                          percent: 0.65,
                          percentText: '65%',
                          title: ' کارهای مهم     ',
                        ),
                        // ordinary Todo's
                        LinerPercent(
                          number: 3,
                          title: 'کارهای معمولی',
                          percent: 0.25,
                          percentText: '25%',
                        ),
                      ],
                    ),

                    //!-----------------------------Financial----------------------------------------

                    ExpansionTile(
                      title: Text('جدول گردش مالی'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0, bottom: 10),
                          child: SizedBox(
                            height: 200,
                            child:
                                // _BarChart(),
                                ReprtBarChart(),
                          ),
                        ),
                        // table Description
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(127, 158, 158, 158)),
                              color: Color.fromARGB(45, 0, 0, 0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text('پس انداز'),
                                CircleContainerColor(
                                  color: Color.fromARGB(171, 0, 255, 234),
                                ),
                                Text('دریافت ماهانه'),
                                CircleContainerColor(
                                  color: Color.fromARGB(255, 8, 230, 0),
                                ),
                                Text('پرداخت ماهانه'),
                                CircleContainerColor(
                                  color: Color.fromARGB(255, 252, 20, 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    // month result Table
                    ExpansionTile(
                      title: Text('گزارش مالی دسته بندی'),
                      children: [
                        // used item's Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(117, 112, 112, 112),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text('لیست پرداخت ها'),
                                Text('لیست دریافت ها'),
                              ],
                            ),
                          ),
                        ),
                        // used item's
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 10, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Obx(() => ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: reportController
                                          .resultPayMapshow.keys.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  52, 255, 137, 137)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 85,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          ' ${reportController.resultPayMapshow.keys.elementAt(index)} :'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  '  ${replaseingNumbersEnToFa(addCommasToNumber((reportController.resultPayMapshow.values.elementAt(index))))} '),
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ),
                              VerticalDivider(
                                width: 0.5,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                              Flexible(
                                child: Obx(() => ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: reportController
                                          .resultGetMapShow.keys.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  29, 72, 255, 102)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 85,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          ' ${reportController.resultGetMapShow.keys.elementAt(index)} :'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  '  ${replaseingNumbersEnToFa(addCommasToNumber((reportController.resultGetMapShow.values.elementAt(index))))}'),
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 0,
                color: AllColors.kListItems,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('حالت تم'),
                          IconButton(
                              onPressed: () {
                                Get.isDarkMode
                                    ? Get.changeThemeMode(ThemeMode.light)
                                    : Get.changeThemeMode(ThemeMode.dark);
                                reportController.toggleTheme(true);
                              },
                              icon: Icon(Get.isDarkMode
                                  ? Icons.light_mode
                                  : Icons.dark_mode)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                  elevation: 0,
                  color: AllColors.kListItems,
                  child: ListTile(
                    title: Text('ارتباط یا گزارش اشکال'),
                    onTap: () async {
                      Uri uri = Uri.parse(
                          'mailto:iran98hossein@gmail.com?subject=&body=');
                      if (!await luncher.launchUrl(uri)) {
                        debugPrint('Coud not launch the url');
                      }
                    },
                  )),
            ]),
      )),
    );
  }
}

///////

class ReprtBarChart extends StatelessWidget {
  ReprtBarChart({
    super.key,
  });
  final ReportController reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BarChart(
          BarChartData(
              titlesData: titlesData,
              barTouchData: barTouchDatas,
              maxY: 10,
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(
                      toY: reportController.totalMonthPayPriceInt.value == 0
                          ? 0
                          : reportController.totalMonthPayPriceInt.value <
                                  reportController.totalMonthGetPriceInt.value
                              ? reportController.showMonthMaxPir.value
                              : 10,
                      fromY: 0,
                      width: 8,
                      color: Color.fromARGB(255, 252, 20, 20))
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(
                      toY: reportController.totalMonthPayPriceInt.value == 0
                          ? 0
                          : reportController.totalMonthGetPriceInt.value <
                                  reportController.totalMonthPayPriceInt.value
                              ? reportController.showMonthMaxPir.value
                              : 10,
                      fromY: 0,
                      width: 8,
                      color: Color.fromARGB(255, 8, 230, 0))
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(
                    toY: reportController.monthTurnoverPir.value <= 0
                        ? 0
                        : reportController.monthTurnoverPir.value <= 10
                            ? reportController.monthTurnoverPir.value
                            : 0,
                    fromY: 0,
                    width: 8,
                    color: const Color.fromARGB(255, 5, 165, 170),
                  )
                ]),
              ],
              alignment: BarChartAlignment.spaceAround,
              gridData: FlGridData(
                show: true,
                verticalInterval: 20,
              )),
        ));
    //
  }

  BarTouchData get barTouchDatas => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.amber,
      fontWeight: FontWeight.w700,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Obx(() => Text(
              reportController.totalMonthPayPriceShow.value,
              style: style,
            ));
        break;
      case 2:
        text = Obx(() => Text(
              reportController.totalMonthGetPriceShow.value,
              style: style,
            ));
        break;
      case 3:
        text = Obx(() => Row(
              children: [
                Text(
                  reportController.monthTurnover.value,
                  style: style,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  (reportController.totalMonthGetPriceInt.value -
                              reportController.totalMonthPayPriceInt.value) >
                          0
                      ? Icons.keyboard_double_arrow_up_outlined
                      : Icons.keyboard_double_arrow_down_outlined,
                  color: (reportController.totalMonthGetPriceInt.value -
                              reportController.totalMonthPayPriceInt.value) >
                          0
                      ? Colors.green
                      : Colors.red,
                  size: 14,
                ),
              ],
            ));

        break;
      default:
        text = SizedBox();
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Row(
        children: [
          text,
        ],
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 50,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
}

class CircleContainerColor extends StatelessWidget {
  final Color color;
  const CircleContainerColor({
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: color,
      ),
    );
  }
}

class LinerPercent extends StatelessWidget {
  final ReportController reportController = Get.put(ReportController());

  final int number;
  final String title;
  final double percent;
  final String percentText;
  LinerPercent({
    required this.number,
    required this.percentText,
    required this.percent,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(() => LinearPercentIndicator(
            barRadius: Radius.circular(5),
            lineHeight: 12,
            percent: (number == 1)
                ? reportController.monthlyImportanchEmergencyProsess().value
                : number == 2
                    ? reportController.monthlyImportanchImportantProsess().value
                    : reportController.monthlyImportanchNormalProsess().value,
            progressColor: Color.fromARGB(255, 5, 165, 170),
            backgroundColor: Get.isDarkMode
                ? Colors.white
                : Color.fromARGB(255, 201, 245, 253),
            animation: true,
            trailing: Text(
                '${(number == 1) ? reportController.monthlyImportanchEmergency().value : number == 2 ? reportController.monthlyImportanchImportant().value : reportController.monthlyImportanchNormal().value}%'),
            leading: Text('$title : '),
          )),
    );
  }
}
