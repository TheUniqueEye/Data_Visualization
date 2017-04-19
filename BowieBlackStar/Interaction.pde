// &&&&&&&&&&&&&&&&&&   KeyPress   &&&&&&&&&&&&&&&&&&&&

void keyPressed() {
  if (key == 'D'|| key =='d')
    drawData = !drawData; // show data
  if (key =='T'|| key =='t')
    showTitle = !showTitle; // show title
  if (key =='L'|| key =='l')
    showLabel = !showLabel; // show label
  if (key =='R'|| key =='r')
    startRotate = !startRotate; // camera rotate
  if (key =='M'|| key =='m')
    ifMotion = !ifMotion; // creature motion
  if (key =='P'|| key =='p')
    presentationMode = !presentationMode; // switch to presentation mode

  // 3 perspectives
  if (key =='1')
    cam.setDistance(500); // close
  if (key =='2')
    cam.setDistance(1600); // middle
  if (key =='3')
    cam.setDistance(3100); // general view
    
    if (key =='x')
    cam.rotateX(radians(1));
    if (key =='y')
    cam.rotateY(radians(1));
    if (key =='z')
    cam.rotateZ(radians(1));
}