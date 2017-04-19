// turn a string of date into the index of day
int dateParser(String rawDate, String startDate) {
  //println("D = "+rawDate);
  String[] dates = split(rawDate, '/');
  String[] startDates = split(startDate, '/');
  int year = int(dates[0]);
  int month = int(dates[1]); // out of bounds
  int day = int(dates[2]);
  int startYear = int(startDates[0]);
  int startMonth = int(startDates[1]);
  int startDay = int(startDates[2]);
  int monthIndex = (year-startYear-1)*12+month+12-startMonth; // imagine we start from 2015-12-01 (till 2016-04-01)
  int dayIndex = monthIndex * 30+day-startDay+1;
  return dayIndex;
}

int totalDays(String startDate, String endDate){
  String[] startDates = split(startDate, '/');
  String[] endDates = split(endDate, '/');
  int startYear = int(startDates[0]);
  int startMonth = int(startDates[1]);
  int startDay = int(startDates[2]);
  int endYear = int(endDates[0]);
  int endMonth = int(endDates[1]);
  int endDay = int(endDates[2]);
  int numMonths = (endYear-startYear-1)*12+endMonth+12-startMonth;
  int numDays = numMonths *30+endDay-startDay+1;
  return numDays;
}