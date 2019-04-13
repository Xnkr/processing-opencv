import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.serial.*;

Serial myPort;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.buffer(1);
  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
 int fw=0;
 int sms=0;
 int count=1;
  image(video, 0, 0 );

  noFill();
  //Left Segment
  stroke(255, 0, 0);
  strokeWeight(1);
  line(opencv.width/3,0,opencv.width/3,opencv.height);
  //Center Segment
  stroke(255, 0, 0);
  strokeWeight(1);
  line(2*opencv.width/3,0,2*opencv.width/3,opencv.height);
  //Face
  stroke(0, 255, 0);
  strokeWeight(2);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    fw= faces[i].x;    
    if(fw+faces[i].width < opencv.width/3) 
    {
       myPort.write('l');
    }
    if(fw > opencv.width/3 && fw < 2*opencv.width/3) 
    {
       myPort.write('c');
    }
    if(fw > 2*opencv.width/3)
    {
       myPort.write('r');
    }
    if((sms==1)&&(count>0))
    {
      myPort.write('s');
      count--;
    }
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  
}

void captureEvent(Capture c) {
  c.read();
}

  
