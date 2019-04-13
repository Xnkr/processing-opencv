import processing.serial.*;
    Serial myPort;
    int xPos = 1;
    float oldHeartrateHeight = 0;

    void setup () {
    // set the window size:
    size(1000, 400);
    frameRate(30);

    // List available serial ports.
    println(Serial.list());

    // Setup which serial port to use.
    // This line might change for different computers.
    myPort = new Serial(this, Serial.list()[0], 9600);

    // set inital background:
    background(0);
    }

    void draw () {
    }

    void serialEvent (Serial myPort) {
    // read the string from the serial port.
    String inString = myPort.readStringUntil('\n');

    if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int
    println(inString);
    int currentHeartrate = int(inString);

    // draw the Heartrate BPM Graph.
    float heartrateHeight = map(currentHeartrate, 0, 1023, 0, height);
    stroke(0,255,0);
    line(xPos - 1, height - oldHeartrateHeight, xPos, height - heartrateHeight);
    oldHeartrateHeight = heartrateHeight;
    // at the edge of the screen, go back to the beginning:
    if (xPos >= width) {
    xPos = 0;
    background(0);
    } else {
    // increment the horizontal position:
    xPos++;
    }
    }
    }
