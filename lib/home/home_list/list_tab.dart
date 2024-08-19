import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app1/home/home_list/list_view.dart';

class TaskTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.timestamp(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            activeColor: const Color(0xff5D9CEC),
            dayProps: const EasyDayProps(
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              todayHighlightColor: Color(0xffD1E9F6),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskList();
              },
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
