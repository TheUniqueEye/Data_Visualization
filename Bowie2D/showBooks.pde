// &&&&&&&&&&&&& For books &&&&&&&&&&&&&&&&&&&&&& //<>//
void showBooks() {
  for (int i=0; i<numRows; i++) {
    for (int j=0; j<numBooks; j++) {

      // cellWidth is a constant related to number of months
      cellWidth = (width-2*horizontalMargin)/(numRows-1);

      // cellHeight is related to the number of Books
      cellHeight = (height-2*verticalMargin)/(numBooks-1);

      // the size of each pixel-like-square is mapping to the checkout times
      float squareLength = map(dataMatrix[i][j], minValue, maxValueBook, 2, 20);

      // the (x,y) position of each pixel-like-square
      positionX = i * cellWidth + horizontalMargin;
      positionY = j * cellHeight + verticalMargin;

      // some layout settings
      noStroke();
      fill(220, 20, 60, 150); // red transparency 95% 
      //fill(255, 255, 0, 150); // yellow
      //fill(255, 0, 0, 150); // red 
      rectMode(CENTER);
      rect(positionX, positionY, squareLength, squareLength);
      
      
      // ### data showing for book-checkout-times ### 
      
      boolean mouseXIn = mouseX<(positionX+cellWidth/2) && mouseX>(positionX-cellWidth/2);
      boolean mouseYIn = mouseY<(positionY+cellHeight/2) && mouseY>(positionY-cellHeight/2);

      if (mouseXIn && mouseYIn) {
        int mouseData = int(dataMatrix[i][j]);
        textAlign(RIGHT, TOP);
        textFont(labelFont2, 8);
        fill(255);
        text("Checkout", width-75, height-12);
        textFont(labelFont1, 10);
        text(mouseData+" Book", width-6, height-12);
      }
    }
  }
}