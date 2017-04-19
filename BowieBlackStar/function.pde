// &&&&&&&&&&&&&&&&&&   dateParser   &&&&&&&&&&&&&&&&&&&&
// turn a string of date into the index of day
int dateParser(String rawDate) {
  String[] dates = split(rawDate, '/');
  int year = int(dates[0]);
  int month = int(dates[1]);
  int day = int(dates[2]);
  int monthIndex = (year-2006)*12+month+4;
  int dayIndex = monthIndex * 30 + day;
  return dayIndex;
}

// &&&&&&&&&&&&&&&&&&   colorDye   &&&&&&&&&&&&&&&&&&&&
// add color using the dataBase
int[] colorDye(int index) {
  int colorRGB[];
  colorRGB = new int[3];
  switch(index) {
  case 0: 
    colorRGB[0]=255;
    colorRGB[1]=0;
    colorRGB[2]=0;
    break;
  case 1: 
    colorRGB[0]=0;
    colorRGB[1]=245;
    colorRGB[2]=255;
    break;
  default:             
    colorRGB[0]=255;
    colorRGB[1]=255;
    colorRGB[2]=255;
    break;
  }
  return colorRGB;
}