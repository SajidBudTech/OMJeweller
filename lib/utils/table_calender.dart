import 'package:flutter/material.dart';
import 'package:flutter_om_jeweller/constants/app_color.dart';
import 'package:flutter_om_jeweller/constants/app_text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekCalendarPage extends StatefulWidget {

  WeekCalendarPage({Key key,this.onDaySelected}):super();
  final Function onDaySelected;
  @override
  _WeekCalendarPageState createState() => _WeekCalendarPageState();
}

class _WeekCalendarPageState extends State<WeekCalendarPage> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              startDay: DateTime.now(),
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                todayColor: AppColor.textColor(context),
                selectedColor: AppColor.textColor(context),
                todayStyle: AppTextStyle.h4TitleTextStyle(color: AppColor.textColor(context)),
                weekdayStyle: AppTextStyle.h4TitleTextStyle(color: AppColor.textColor(context)),
                weekendStyle: AppTextStyle.h4TitleTextStyle(color: AppColor.textColor(context)),
              ),
              headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  titleTextStyle: AppTextStyle.h4TitleTextStyle(color: AppColor.accentColor),
                  leftChevronIcon: Icon(Icons.keyboard_arrow_left_sharp,color: AppColor.accentColor,size: 24,),
                  rightChevronIcon: Icon(Icons.keyboard_arrow_right,color: AppColor.accentColor,size: 24,),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                  formatButtonVisible: false),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: widget.onDaySelected,
              builders: CalendarBuilders(
                dowWeekdayBuilder: (context, value) => Container(
                  // margin: const EdgeInsets.only(left: 20.0,right: 20),
                  alignment: Alignment.center,
                  child: Text(
                    value.toString(),
                    style: AppTextStyle.h4TitleTextStyle(
                        color: AppColor.hintTextColor(context)),
                  ),
                ),
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.0),
                        border:
                            Border.all(color: AppColor.accentColor, width: 1)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: AppColor.accentColor),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    /* decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0)),*/
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: AppColor.textColor(context)),
                    )),
              ),
              calendarController: _controller,
            )
          ],
        ),
      ),
    );
  }
}
