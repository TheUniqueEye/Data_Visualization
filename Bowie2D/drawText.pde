// Let's add some titles and labels! 
// Switch on and off with key T for title; L for label.

void showTitle() {
  textAlign(CENTER, TOP);
  textFont(titleFont, 14);
  fill(255, 255, 255);
  text("H O W  D O E S  D E A D  R O C K  S T A R  S T A Y  A L I V E", width/2, height/2-10);
  fill(255, 255, 255, 100);
  text("|DAVID BOWIE's CD and Book Checkout Times per Month|", width/2, height/2+10);
  textFont(labelFont1, 8);
  fill(255, 255, 255);
  text("J I N G   Y A N", width/2+172, height/2+30);
  textFont(titleFont, 54);
  text(":", width/2-200, height/2-40);
}

void showLabel() {
  for (int i=0; i<numBooks; i++) {
    textAlign(RIGHT, TOP);
    textFont(labelFont2, 8);
    fill(220, 20, 60, 120);
    cellHeight = (height-2*verticalMargin)/(numBooks-1);
    positionY = i * cellHeight + verticalMargin;
    text(titlePool[i], width-6, positionY+5);
  }
  for (int i=numBooks; i<numColumns; i++) {
    textAlign(LEFT, TOP);
    textFont(labelFont2, 8);
    fill(0, 245, 255, 95);
    cellHeight = (height-2*verticalMargin)/(numCDs-1);    
    positionY = (i-numBooks) * cellHeight + verticalMargin;
    text(titlePool[i], 6, positionY+3);
  }
}