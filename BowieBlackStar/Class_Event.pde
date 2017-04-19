// &&&&&&&&&&&&&&&&&&   Event class   &&&&&&&&&&&&&&&&&&&&
// Each single checkout event per day, per title

class Event {
  String type;
  String title;
  String date;
  int coutTimes;
  int coutDuration;
  int index; 
  // To make the drawing process easier,
  // I give an index to each checkout event according to the title.
  // That means different checkout events with the same book will have the same index.

  Event(String type, String title, String date, int coutTimes, int coutDuration, int index) {
    this.type = type;
    this.title = title;
    this.date = date;
    this.coutTimes = coutTimes;
    this.coutDuration = coutDuration;
    this.index = index;
  }
}