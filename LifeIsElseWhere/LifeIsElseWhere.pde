/* 2016-3-9  //<>//
 Data Visualization Final (Processing 3)
 
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::: L I F E  I S  E L S E W H E R E ::::::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::: code: Jing Yan :::::::
 ::::::::::::::::::: theuniqueeye@gmail.com :::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::: [Part3: Visualization] ::::::::::::::::::::::::::::::::::*/


import peasy.*;
PeasyCam cam;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import controlP5.*;
ControlP5 cp5;
CheckBox checkbox;

String startDate = "2015/12/01";
String endDate = "2016/03/14";
int totalDays;

// Data
Table socialData;
int numSocials, count_user, count_media;
ArrayList<Social> socials = new ArrayList<Social>();
String user_id, user_name, media_id, date, social_id, social_name;
float location_long, location_lat, heat;
int count_comment, count_like, date_index, comment_date_index;
int comment_length, maximum_length=565;
String comment_date, comment_text;
IntList media_comments = new IntList(); 
IntList numUsers = new IntList(); 
IntList user_medias= new IntList();

// Draw
PImage map;
PShape test, title;
float cubeWidth, cubeHeight, cubeDepth;
FloatList location_x = new FloatList(); 
FloatList location_y = new FloatList(); 
FloatList location_z = new FloatList(); 
FloatList radius = new FloatList();
FloatList velocity = new FloatList();
IntList heatColor = new IntList();
float positionX, positionY;

// Interaction
float mouseObjectDistance;
String mouseDate, mousePlace, mouseUser_id="", mouseUser_name;
int lineColor;
boolean selectMode=true, showMap=false, rotateY=false, showTitle=true, colorMode=false,save;

// Font
PFont titleFont, titleFont2, labelFont, labelFont2, footnoteFont;

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void setup() {
  //fullScreen(P3D, SPAN);
  size(1080, 720, P3D);
  cam = new PeasyCam(this, 780); // 780 // 1130

  /* try to rotate the camera a little bit
   float cameraPositionX = -cubeDepth;
   CameraState state;
   Vector3D axisY = new Vector3D(0, 1, 0);
   Vector3D axisX = new Vector3D(0, 0, 1);
   Vector3D npos = new Vector3D(0, 0, 0);
   Rotation rotn = new Rotation(axisY, radians(-5));
   rotn = rotn.applyTo(new Rotation(axisX, radians(5)));
   state = new CameraState(rotn, npos, 0);
   cam.setState(state, 8000);*/


  socialData = loadTable("dataCollect_comment.csv", "header"); // text cannot be load ###
  numSocials = socialData.getRowCount();
  println("[number of rows: " + numSocials +"]" );

  //println("socialData.getInt(81, 10) "+socialData.getInt(81, 10));

  // add variables into the socials object
  for (int i=0; i<numSocials; i++) {
    user_id = socialData.getString(i, 0);
    user_name = socialData.getString(i, 1);
    media_id = socialData.getString(i, 2);
    date = socialData.getString(i, 3);
    location_long = socialData.getFloat(i, 5);
    location_lat = socialData.getFloat(i, 4);
    social_id = socialData.getString(i, 6);
    social_name = socialData.getString(i, 7);
    comment_date = socialData.getString(i, 8);
    comment_text = socialData.getString(i, 10);
    comment_length = socialData.getInt(i, 9);
    //if(i<=100)
    //println("socialData.getInt(i, 10) "+(i+2)+" "+socialData.getInt(i, 10));
    count_comment = 0;

    socials.add(new Social(user_id, user_name, media_id, date, location_long, location_lat, 
      social_id, social_name, count_comment, comment_date, comment_text, comment_length));
  }
  println("[number of socials: " + socials.size() +"]");

  // calculate total days
  totalDays = totalDays(startDate, endDate); 

  // load map as ground
  map = loadImage("map.png");
  println("[map.width: " + map.width +"]" );
  println("[map.height: " + map.height +"]" );
  test = loadShape("test.svg"); // the same image size, svg for transparent
  //title = loadShape("title.svg"); 

  // set cube size
  cubeWidth = map.width;
  cubeDepth = map.height;
  cubeHeight = 1000;

  // get the location of each point in the space-time cube, store them in the floatlist
  for (int i=0; i<numSocials; i++) {
    location_long = socials.get(i).location_long;
    location_lat = socials.get(i).location_lat;
    date_index = dateParser(socials.get(i).date, startDate); 
    comment_date_index = dateParser(socials.get(i).comment_date, startDate);
    comment_length = socials.get(i).comment_length; 
    heat = comment_date_index * comment_length;


    velocity.append(map(log(comment_length), log(1), log(maximum_length), 20.f, 300.f));
    radius.append(map(log(comment_date_index-date_index), log(1), log(totalDays), 5, 20.f));
    heatColor.append(int(map(log(heat), log(1), log(totalDays*maximum_length), 1.f, 255.f)));

    location_x.append(map(location_long, -124.7, -66.94, -map.width/2.f, map.width/2.f));
    location_y.append(map(date_index, 1, totalDays, 0, -cubeHeight));
    location_z.append(map(location_lat, 49, 25.1, - map.height/2.f, map.height/2.f));
  }
  //println("location_x: "+location_x);
  //println("location_y: "+location_y);
  //println("location_z: "+location_z);

  count_comment =0;
  user_id = socials.get(0).user_id;
  media_id = socials.get(0).media_id;

  for (int i=0; i<numSocials; i++) {
    String temp = socials.get(i).media_id;
    String[] tempSlit = temp.split("_");

    // count user
    temp = socials.get(i).user_id;
    if (!user_id.equals(temp)) {
      //println("count_user = "+ count_user);
      user_medias.append(count_media);
      count_media=0;
      user_id = socials.get(i).user_id;
      count_user++;
    }

    // count comment
    temp = socials.get(i).media_id;
    if (media_id.equals(temp)) {
      count_comment++;
    } else {
      media_comments.append(count_comment);
      count_comment=1;

      // count media
      media_id = socials.get(i).media_id;
      count_media++;
      //println(count_media);
    }
  }

  // load font
  titleFont = loadFont("AnonymousPro-Bold-50.vlw");
  titleFont2 = loadFont("AndaleMono-30.vlw");
  labelFont = loadFont("KohinoorDevanagari-Light-48.vlw");
  labelFont2 = loadFont("KohinoorDevanagari-Medium-10.vlw");
  footnoteFont = createFont("stan0758.ttf", 15);
  //println(user_medias);


  // &&&&&&&&&&&&&&&&&&   ControlP5   &&&&&&&&&&&&&&&&&&&&

  //buttonClickCount = 0;
  cp5 = new ControlP5(this);

  // check box
  checkbox = cp5.addCheckBox("checkBox")
    .setPosition(10, 350) //350 //10
    .setColorForeground(color(150))
    .setColorBackground(color(230))
    .setColorActive(color(0))
    .setColorLabel(color(0))
    .setSize(10, 10)
    .setItemsPerRow(1)
    .setSpacingColumn(20)
    .setSpacingRow(15)
    .addItem("Rotate", 0)
    .addItem("Label", 50)
    .addItem("Color", 100)
    ;

  /*
   // button
   cp5.addButton("Change View")
   .setPosition(10, 85)
   .setSize(55, 10)
   .setColorForeground(color(180))
   .setColorBackground(color(80))
   .setColorActive(color(255))
   ;
   */

  // display with PeasyCam
  cp5.setAutoDraw(false);  // prevent auto draw
}

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void draw() {
  background(255);

  gui(); // cP5 with Peasy

  //&&&&&&&&&&&&&&&&&&   [space-time cube]   &&&&&&&&&&&&&&&&&&&&
  strokeWeight(0.5);
  cube(cubeWidth, cubeHeight, cubeDepth);

  //&&&&&&&&&&&&&&&&&&   [map-plane as ground]   &&&&&&&&&&&&&&&&&&&&
  if (showMap==true) {
    pushMatrix();
    translate(0, cubeHeight/2, 0);
    rotateX(PI/2);
    translate(-map.width/2, -map.height/2, 0);
    shape(test, 0, 0);  // test to make the map transparent
    //image(map, 0, 0); // try to set initial position at the center of 3D space
    //tint(255, 10);
    popMatrix();

    /*
    // date label
     smooth();
     textAlign(BOTTOM, RIGHT);
     textFont(labelFont, 14);
     fill(0, 0, 0);
     pushMatrix();
     translate(0, cubeHeight/2, 0);
     translate(-map.width/2, 0, 0);
     text(startDate, cubeWidth+50, 0, cubeDepth/2);
     popMatrix();
     pushMatrix();
     translate(0, cubeHeight/2, 0);
     translate(-map.width/2, 0, 0);
     text(endDate, cubeWidth+50, -cubeHeight+10, cubeDepth/2);
     popMatrix();
     */
  }


  //&&&&&&&&&&&&&&&&&&   [text and title]   &&&&&&&&&&&&&&&&&&&&
  if (showTitle==true)showTitle();
  //showFootnote();

  pushMatrix();
  translate(0, cubeHeight/2, 0); // translate the whole things to start growing from the ground

  //&&&&&&&&&&&&&&&&&&   [USER PATH]   &&&&&&&&&&&&&&&&&&&&
  // line up media space time path [USER PATH]
  lineColor = 0;
  noFill();
  strokeWeight(0.8);
  smooth();
  user_id = socials.get(0).user_id;

  beginShape();
  for (int i=1; i<numSocials; i++) { 
    if (selectMode==false ||mouseUser_id.equals(socials.get(i).user_id))
      stroke(20, 150);
    else {
      strokeWeight(1);
      stroke(230, 150);
    }
    if (user_id.equals(socials.get(i).user_id)) {
      vertex(location_x.get(i-1), location_y.get(i-1), location_z.get(i-1));
      vertex(location_x.get(i), location_y.get(i), location_z.get(i));

      // make the line more distinguishable when selected
      if (selectMode==true&&mouseUser_id.equals(socials.get(i).user_id)) {
        vertex(location_x.get(i), location_y.get(i)+2, location_z.get(i)+2);
        vertex(location_x.get(i-1), location_y.get(i-1)+2, location_z.get(i-1)+2);

        vertex(location_x.get(i-1), location_y.get(i-1)-2, location_z.get(i-1)-2);
        vertex(location_x.get(i), location_y.get(i)-2, location_z.get(i)-2);

        //vertex(location_x.get(i), location_y.get(i)+2, location_z.get(i)-2);
        //vertex(location_x.get(i-1), location_y.get(i-1)+2, location_z.get(i-1)-2);

        //vertex(location_x.get(i-1), location_y.get(i-1)-2, location_z.get(i-1)+2);
        //vertex(location_x.get(i), location_y.get(i)-2, location_z.get(i)+2);
      }
    } else {
      endShape();
      //stroke((255/2)-((i*10)%255)/2, 255-(i*10)%255, (i*10)%255); // test colorful mode
      user_id = socials.get(i).user_id;
      beginShape();
    }
  }
  endShape();

  String tempMediaID = socials.get(0).media_id;
  int drawCounter = 0;

  //&&&&&&&&&&&&&&&&&&   [MEDIA BOX]   &&&&&&&&&&&&&&&&&&&&
  // draw [MEDIA BOX] at every joint point
  //println("colorMode: "+colorMode+"  "+"selectMode: "+selectMode+"  "+"pick: "+mouseUser_id.equals(socials.get(0).user_id));
  for (int i=0; i<numSocials; i++) {  
    date_index = dateParser(socials.get(i).date, startDate);

    strokeWeight(1);
    stroke(230);
    if (selectMode==false)
      stroke(color(0, 0, 0), 80);
    else {
      if ( mouseUser_id.equals(socials.get(i).user_id)) {

        if (colorMode==true)
          stroke(color((2*heatColor.get(i)-50)%255, 0, 0), 100);
        else
          stroke(color(0, 0, 0), 80);
      }
    }

    if (user_id.equals(socials.get(i).user_id)) {
      user_id = socials.get(i).user_id;
    } else {
      pushMatrix();
      translate(location_x.get(i), location_y.get(i), location_z.get(i));
      box(10, 10, 10);


      // &&&&&&&&&&&&&&&&&&   [mouse pick]   &&&&&&&&&&&&&&&&&&&&
      // picking object data by mouse
      // map the 3D positions onto 2D screen 

      mouseObjectDistance = sq(mouseX-screenX(0, 0, 0))+sq(mouseY-screenY(0, 0, 0)); 
      if (mouseObjectDistance < 50) { 
        //println("mouseObjectDistance = "+mouseObjectDistance);

        mouseDate = socials.get(i).date;
        mousePlace = "Long "+socials.get(i).location_long +" / "+"Lat "+ socials.get(i).location_lat ;
        mouseUser_id = socials.get(i).user_id;
        mouseUser_name = socials.get(i).user_name;

        if (selectMode==true) {
          textAlign(LEFT, TOP);
          textFont(labelFont, 15);
          pushMatrix();
          //translate(0, 0, -location_z.get(i));
          float textDistanceY = 15;
          fill(0);
          text("User ID / " + mouseUser_id, 10, 10);
          text("Username / " + mouseUser_name, 10, 10+textDistanceY);
          text("Date / " + mouseDate, 10, 10+textDistanceY*2);
          text(mousePlace, 10, 10+textDistanceY*3); //"Location = " +
          noFill();
          popMatrix();
        }

        // show shadow on the gound
        if (showMap==true) {
          noStroke();
          pushMatrix();
          rotateX(-PI/2);
          translate(0, 0, -location_y.get(i)-10);
          fill(color(255, 0, 0), 30);
          //rect(0, 0, 20, 20);
          ellipse(0, 0, 20, 20);

          // draw a timeline to connect the space-time point to specific world coordinate(map + timeline)
          stroke(color(255, 0, 0), 30);
          line(0, 0, 0, 0, 0, location_y.get(i)+10); // long horizontal line

          // short vertical lines as scale

          for (int j=0; j<date_index; j++) {
            strokeWeight(0.4);
            float scaleSizeY;
            scaleSizeY = cubeHeight/(totalDays-1);
            float scalePositionY = scaleSizeY * j;
            line(0, 0, -scalePositionY, 3, 0, -scalePositionY);
          }
          popMatrix();
          noFill();
          stroke(0);
        }
      }


      //&&&&&&&&&&&&&&&&&&   [COMMENT BOX]   &&&&&&&&&&&&&&&&&&&&
      // draw [comment box] around each media box 
      // box numbers = comment numbers
      // rotate around the media with radius (= map to time difference between comment time and media time)
      if (tempMediaID.equals(socials.get(i).media_id)) {
        pushMatrix();

        positionX = radius.get(i)*sin(((frameCount+i*10)/(velocity.get(i))*2)*PI);
        positionY = radius.get(i)*cos(((frameCount+i*10)/(velocity.get(i))*2)*PI);

        if (mouseObjectDistance < 100) { 
          // 
          positionX = 8*radius.get(i)*sin(((frameCount+i*10)/(velocity.get(i))*5)*PI);
          positionY = 8*radius.get(i)*cos(((frameCount+i*10)/(velocity.get(i))*5)*PI);
          rotateX(PI/2);
          line(0, 0, positionX, positionY);
          rotateX(-PI/2);
          if (colorMode==true)stroke(color((2*heatColor.get(i)-50)%255, 0, 0), 100);///
        }
        translate(positionX, 0, positionY);      
        box(3, 3, 3);
        stroke(0);
        drawCounter++;
        popMatrix();
      }
      tempMediaID = socials.get(i).media_id;

      //if(i<=30)
      //println("i = "+i+"  drawCounter = "+drawCounter);
      //drawCounter=0;
      popMatrix();
    }
  }
  popMatrix();

  //&&&&&&&&&&&&&&&&&&   [Interaction/Motion]   &&&&&&&&&&&&&&&&&&&&
  // automatically change the selection mode
  if (cam.getDistance()>1100) {
    selectMode=false;
    showTitle=false;
  } else selectMode=true;

  if (rotateY==true)
    cam.rotateY(radians(1)*0.1);

  if (save) saveFrame("frame/whiteNoise-######.png");
}