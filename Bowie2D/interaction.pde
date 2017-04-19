// &&&&&&&&&&&&   here are all the switches   &&&&&&&&&&&&&&&&&&&
// C/c for CD; B/b for Book; T/t for title; N/n for normalization
// you press once to switch on and press again to switch off

void keyPressed() {

  // press key for showing and hidding
  if (key == 'C'|| key =='c')
    showCDs = !showCDs;
  if (key == 'B'|| key =='b') 
    showBooks = !showBooks;
  if (key =='T'|| key =='t')
    showTitle = !showTitle;
  if (key =='L'|| key =='l')
    showLabel = !showLabel;

  // press key for normalization of Book patterns
  if (key =='N'|| key=='n') {
    if (maxValueBook == maxValue)
      maxValueBook = 17;
    else maxValueBook = maxValue;
  }
}