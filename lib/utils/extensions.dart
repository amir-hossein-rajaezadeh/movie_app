
extension SplitDate on String {
  String splitDate() {
    return split(' ')[0].toString();
  }

  String splitDateToYear() {
    return split('-')[0].toString();
  }

  String splitDateToMonth() {
    return split('-')[1].toString();
  }

  String splitDateToDay() {
    return split('-')[2].toString();
  }
}