import 'package:flutter/material.dart';
import 'package:task_management_app/models/app_color.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    // Generate the list of dates for the current week
    List<DateTime> weekDates = List.generate(7, (index) {
      // Calculate dates from Monday to Sunday
      return now.subtract(Duration(days: now.weekday - 1)).add(Duration(days: index));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: weekDates.map((date) {
        // Check if this date is today
        bool isSelected = date.day == now.day && date.month == now.month && date.year == now.year;

        return Column(
          children: [
            Text(
              _getWeekdayAbbreviation(date.weekday),
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            isSelected
                ? Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Text(
                    date.day.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                 ),
          ],
        );
      }).toList(),
    );
  }

  // function to get the abbreviated weekday name
  String _getWeekdayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Mon";
      case DateTime.tuesday:
        return "Tue";
      case DateTime.wednesday:
        return "Wed";
      case DateTime.thursday:
        return "Thu";
      case DateTime.friday:
        return "Fri";
      case DateTime.saturday:
        return "Sat";
      case DateTime.sunday:
        return "Sun";
      default:
        return "";
    }
  }
}
