import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/papular_components.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hesabdar/controller/home_page_controller.dart';
import 'package:hesabdar/view/test.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddPaymentPage extends StatelessWidget {
  AddPaymentPage({super.key});
  @override
  Widget build(BuildContext context) {
//! عنوان تب ها
    final List<Tab> myTabs = <Tab>[
      Tab(
        child: Text(
          'بودجه',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      Tab(
        child: Text(
          'درآمد',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      Tab(
        child: Text(
          'هزینه',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    ];
//! محتوای تب ها
    final List<Widget> tabContents = <Widget>[
      MyWidgetGet(),
      MyWidgetGet(),
      MyWidgetGet(),
    ];

    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: SpeedDial(
              children: [
                SpeedDialChild(
                    backgroundColor: Colors.green,
                    label: 'درآمد',
                    child: Icon(Icons.add_card),
                    labelStyle: Theme.of(context).textTheme.bodySmall),
                SpeedDialChild(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.payment_rounded),
                    label: 'خرج',
                    labelStyle: Theme.of(context).textTheme.bodySmall),
                SpeedDialChild(
                    backgroundColor: Color.fromARGB(136, 182, 182, 182),
                    child: Icon(Icons.attach_money),
                    label: 'بودجه',
                    labelStyle: Theme.of(context).textTheme.bodySmall)
              ],
              animatedIcon: AnimatedIcons.event_add,
              backgroundColor: Color.fromARGB(255, 45, 201, 201),
              overlayColor: Colors.grey,
              spacing: 12,
              spaceBetweenChildren: 12,
              closeManually: true,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //! header part
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                      Row(
                        children: [
                          Icon(
                            Icons.edit_calendar_outlined,
                            size: 22,
                            color: Color.fromARGB(255, 45, 201, 201),
                          ),
                          widthOf(10),
                          Container(
                            child: Text(
                              'چهارشنبه ــ ۲۲خرداد ۱۴۰۲',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),

                //! total part
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 192, 192, 192),
                            style: BorderStyle.solid),
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'درآمد روز :',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '۲۵.۱۷۳.۰۰۰',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 3, 202, 9)),
                          ),
                          Text(
                            'هزینه روز :',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '۳۴۳.۰۰۰',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //! nav
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 212, 212, 212), // رنگ border
                        width: 1.0, // ضخامت border
                      ),
                    ),
                  ),
                  child: TabBar(
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 45, 201, 201),
                        width: 4,
                      ),
                      insets: EdgeInsets.fromLTRB(5, 0, 5, 0), // پدینگ گوشه‌ها
                    ),
                    tabs: myTabs,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 45,
                    child: TabBarView(
                      children: tabContents,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
