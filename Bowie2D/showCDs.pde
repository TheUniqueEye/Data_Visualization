// &&&&&&&&&&&&& For CDs &&&&&&&&&&&&&&&&&&&&&&
void showCDs() {
  for (int i=0; i<numRows; i++) {
    for (int j=numBooks; j<numColumns; j++) {

      // cellWidth is a constant related to number of months
      cellWidth = (width-2*horizontalMargin)/(numRows-1);

      // cellHeight is related to the number of CDs
      cellHeight = (height-2*verticalMargin)/(numCDs-1);

      // the size of each pixel-like-square is mapping to the checkout times
      float squareLength = map(dataMatrix[i][j], minValue, maxValue, 1, 20);

      // the (x,y) position of each pixel-like-square
      positionX = i * cellWidth + horizontalMargin;
      positionY = (j-numBooks) * cellHeight + verticalMargin;

      // some layout settings
      noStroke();
      fill(0, 245, 255, 150); // cyan transparency 95% 
      //fill(151,255,255,150); // darkSlateGray1
      //fill(0,0,255,150); // blue
      rectMode(CENTER);
      rect(positionX, positionY, squareLength, squareLength);


      // ### data showing for CD-checkout-times ### 
      boolean mouseXIn = mouseX<(positionX+cellWidth/2) && mouseX>(positionX-cellWidth/2);
      boolean mouseYIn = mouseY<(positionY+cellHeight/2) && mouseY>(positionY-cellHeight/2);

      if (mouseXIn && mouseYIn) {
        int mouseData = int(dataMatrix[i][j]);
        textAlign(RIGHT, TOP);
        textFont(labelFont2, 8);
        fill(255);
        text("Checkout", width-75, height-12);
        textFont(labelFont1, 10);
        text(mouseData+" CD", width-45, height-12);
      }
    }
  }
}