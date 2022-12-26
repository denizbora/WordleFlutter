extension DateOnlyCompare on DateTime {
  bool isSame(DateTime other) => year == other.year && month == other.month
        && day == other.day;
}