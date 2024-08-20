import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/home/home_list/list_view.dart';
import 'package:to_do_app1/providers/list_proivder.dart';

class TaskTab extends StatefulWidget {
  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    var listproivder = Provider.of<ListProvider>(context);
    if (listproivder.taskslist.isEmpty) {
      listproivder.getAllTasksFromFireStore();
    }

    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.timestamp(),
            onDateChange: (selectedDate) {
              listproivder.changeSelectDate(selectedDate);
            },
            activeColor: const Color(0xff5D9CEC),
            dayProps: const EasyDayProps(
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              todayHighlightColor: Color(0xffD1E9F6),
            ),
          ),
          Expanded(
            child: listproivder.taskslist.isEmpty
                ? Text("NO TASKS ADDED")
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return TaskList(
                        task: listproivder.taskslist[index],
                      );
                    },
                    itemCount: listproivder.taskslist.length,
                  ),
          ),
        ],
      ),
    );
  }
}
