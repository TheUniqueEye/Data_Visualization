// &&&&&&&&&&&&&&&&&&   show Data   &&&&&&&&&&&&&&&&&&&&

void drawData(PShape[] meshes) {
  int distanceOfSwitch = 3000;
  boolean tooFarAway = cam.getDistance()>distanceOfSwitch;

  int divider = 300; 
  int dividerFollower = 1;
  double MaxPortion2Draw = 0.1; // display portion

  // count total draw numbers
  int totalDraw = 0;

  // zoom in when mouse on
  mouseOnScale = 5; 

  // object motion
  translateScale = 0;
  rotateScale = 0;

  // To speed up the program, less data is displayed when the camera is far away
  // I divider the data into 300 groups, and load more data when zoom in.
  dividerFollower = (int)((divider)*(1-cam.getDistance()/(4000))*MaxPortion2Draw)+5;

  // each checkout event per day per title
  for (int i=0; i<events.size(); i++) {

    if (i%divider<dividerFollower||tooFarAway) { // How much to display

      // set the x,y positions of each object
      positionX = cellWidth * dateParser(events.get(i).date);
      positionY = cellHeight * events.get(i).index;
      positionZ = 0;

      // whether mouse in data area
      if (presentationMode == false) { // presentationMode
        mouseYIn = mouseY<(positionY+cellHeight/2) && mouseY>(positionY-cellHeight/2);
      } else { // no presentationMode
        fakeMouseY = cellHeight*frameIndex;
        mouseYIn = fakeMouseY<(positionY+cellHeight/2) && fakeMouseY>(positionY-cellHeight/2);
      }
      mouseXIn = mouseX<(positionX+cellWidth/2) && mouseX>(positionX-cellWidth/2);

      // mouse stay in Y axis
      boolean mouseYStay = frameMarks[0]<= int(0.75 * cellHeight + positionY) && frameMarks[0]>=int(-0.75 * cellHeight + positionY);

      // display checkout times 
      for (int j=0; j<events.get(i).coutTimes; j++) {

        // z-axis
        cellDepth = riverDepth/(events.get(i).coutTimes);
        positionZ = cellDepth*(2*j+1)/2;

        // draw each object at the right position
        pushMatrix();
        translate(-riverWidth/2, -riverHeight/2, -riverDepth/2);
        translate(positionX, positionY, positionZ);

        // &&&&&&&&&&&&&&&&&&   mouse pick   &&&&&&&&&&&&&&&&&&&&
        // picking object data by mouse
        // map the 3D positions onto 2D screen 

        meshes[i].setStroke(color(255)); // reset color of picking


        if (presentationMode == true) { // presentationMode
          mouseObjectDistance = sq(fakeMouseX-screenX(0, 0, 0))+sq(fakeMouseY-screenY(0, 0, 0));
        } else  mouseObjectDistance = sq(mouseX-screenX(0, 0, 0))+sq(mouseY-screenY(0, 0, 0)); // no presentationMode
        if (mouseObjectDistance < 50) { 
          mouseDate = events.get(i).date;
          mouseTitle = events.get(i).title;
          mouseCoutTimes = events.get(i).coutTimes;
          mouseCoutDuration = events.get(i).coutDuration;
          textAlign(LEFT, TOP);
          textFont(labelFont2, 15);
          pushMatrix();
          translate(0, 0, -positionZ);
          float textDistanceY = 15;
          text("Item title = " + mouseTitle, 10, 10);
          text("Picked date = " + mouseDate, 10, 10+textDistanceY);
          text("Checkout Times = " + mouseCoutTimes, 10, 10+textDistanceY*2);
          text("Checkout Duration /Day = " + mouseCoutDuration, 10, 10+textDistanceY*3);
          popMatrix();

          if (showLabel == false) meshes[i].setStroke(color(255, 0, 0)); // change color when picked
        }

        // &&&&&&&&&&&&&&&&&&   creature motion   &&&&&&&&&&&&&&&&&&&&
        // add a little dance to each event creature
        // map the coutTimes and coutDuration to movement

        if (ifMotion) { // ### regular motion

          float defaultTranslate = 2*sin(((frameCount+i)/20.0)*PI);  // magic 
          float defaultRotate = 0.1*sin(((frameCount+i)/20.0)*PI);
          translateScale = map(log(events.get(i).coutTimes+1), log(minCoutTimes+1), log(maxCoutTimes), 0, defaultTranslate*2);
          rotateScale = map(log(events.get(i).coutDuration+1), log(minCoutDuration+1), log(maxCoutDuration), 0, defaultRotate*2);
          translate(0, translateScale, 0);  //adjust total dancing rate
          rotateY(rotateScale);
        }

        totalDraw++;  // cout total draw numbers

        if (mouseYIn && showLabel) { // ### select motion with label on

          scale(mouseOnScale); // zoom in

          if (ifMotion) {
            float selectTranslate = 3*sin(((frameCount+i)/10.0)*PI);
            float selectRotate = 0.1*sin(((frameCount+i)/10.0)*PI);
            translateScale = map(log(events.get(i).coutTimes+1), log(minCoutTimes+1), log(maxCoutTimes), 0, selectTranslate*5);
            rotateScale = map(log(events.get(i).coutDuration+1), log(minCoutDuration+1), log(maxCoutDuration), 0, selectRotate*5);
            translate(0, translateScale, 0);  //adjust selected group dancing rate
            rotateY(rotateScale);
          }

          // &&&&&&&&&&&&&&&&&&   count frame for song   &&&&&&&&&&&&&&&&&&&&
          // play related songs from the album when the mouse stay for amount of time

          //boolean mouseYStay = frameMarks[0]<= int(0.75 * cellHeight + positionY) && frameMarks[0]>=int(-0.75 * cellHeight + positionY);
          //println("mouseYStay = "+mouseYStay+"  positionY = "+positionY+"  frameMarks[1] = "+frameMarks[1]);
          if (presentationMode == false) {
            if (mouseYStay) {
              frameMarks[1]++; // count frame
              if (frameMarks[1] == 1000) thread("playSong"); // use thread to speed up
            } else {
              frameMarks[0] = int(positionY);
              frameMarks[1] = 0;
              minim.stop();
            }
          }
        }

        // &&&&&&&&&&&&&&&&&&   objects and points   &&&&&&&&&&&&&&&&&&&&
        // when the camera is too far away, points
        // else objects

        if (tooFarAway) drawPoint();
        else {
          shape(meshes[i]);
        }
        popMatrix();
      }
    }
  }

  // ### used for test, cout how many objects are drawed
  totalDraw = 0;
}

// &&&&&&&&&&&&&&&&&&   song display   &&&&&&&&&&&&&&&&&&&&

void playSong() {
  println("playSong");
  player = minim.loadFile("SpaceOddity.mp3");
  player.play();
}