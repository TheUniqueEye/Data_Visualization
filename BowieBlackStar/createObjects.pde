// &&&&&&&&&&&&&&&&&&   create object   &&&&&&&&&&&&&&&&&&&&

// To speed up the program, I split the draw data process.
// I setup a 2D model of all objects on the same X-Y-layer only once, 
// and display them 60 times/second.

PShape[] createObjects() {
  meshes = new PShape[events.size()];

  for (int i=0; i<events.size(); i++) {

    // set length(squareLength) and height(tailLength) of each object
    // squarelength: map checkout times to 1-20
    // tailLength: map checkout duration to riverWidth
    float squareLength = map(events.get(i).coutTimes, minCoutTimes, maxCoutTimes, 2, 20 );
    float tailLength = events.get(i).coutDuration * riverWidth/numDays;
    
    strokeWeight(0.8);
    // set color 
    colorCreature = new int[3];
    colorCreature[0] = 255;
    colorCreature[1] = 255;
    colorCreature[2] = 255;
    
    // setup model
    meshes[i] = drawCreature(squareLength, tailLength, colorCreature);
  }
  return meshes;
}