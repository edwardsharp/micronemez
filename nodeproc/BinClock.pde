/**
 * A simple binary clock.
 * ...with a weird set of features
 * 
 * author: edward sharp
 * year: 2012
 * license: creative commons
 */

Block blk1, blk2;

PFont font;

String info="";
boolean showTime=false;  
int startingTime;
int seconds;

void setup() {
  size(480,320);
  //size(640, 360);
  
  background(0);
  frameRate(1);
  // cons1ructor, no parameters
  blk1 = new Block();
  //cons1ructor, three parameters
  //blk2 = new Block(width*0.5, height*0.5, 120);
  font = loadFont("SansSerif-100.vlw");
  textFont(font, 100);
}

void draw() {
  blk1.display();
  //blk2.display();
  
}

void keyPressed(){
  if (key=='s')
    showTime=!showTime;
}

void mousePressed(){
  showTime=!showTime;
}
class Block {
  //class varz
  int c_on, c_off;
  int strk = 0;
  int c_bg = 0;
  // #TODO: defaults?
  
  // #TODO: constructor?
  Block() {
  }
  
  // with parameters
  /*Block(float xpos, float ypos, float r) {
    x = xpos;
    y = ypos;
    radius = r;
  }*/
  void display() {
    // mod 10 the current time into 6 columnz
    int s = second();
    int s0 = s % 10;
    int s1 = (s - s0)/10;
    int m = minute();
    int m0 = m % 10;
    int m1 = (m - m0)/10;
    int h = hour();
    int h0 = h % 10;
    int h1 = (h - h0)/10;
    
    // colorz    
    c_on = #ff6600;
    //c_off = #EDEDED;
    c_off = #000000;
    
    int rectSize = 80; 
    int iOffset = 80;
    int yRect = 240;
    int xRect0 = 0;
    //#TODO: increment iterator? could this be more fluid for various resolutions?
    //int xRectOffset = 10;
    int xRect1 = 80;
    int xRect2 = 160;
    int xRect3 = 240;
    int xRect4 = 320;
    int xRect5 = 400;
    
    int yBlock = 80;

    //for each HH, MM, SS turn on the results from last run, recalculate next second.
    for (int i=3; i>=0; i--) {
        on (xRect0, yBlock, i);
        if (h1 >= pow(2,i))
            h1 -= pow(2,i);
        else
            fill(c_off);
            
        rect(xRect0,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect1, yBlock, i);
        if (h0 >= pow(2,i))
            h0 -= pow(2,i);
        else
            fill(c_off);
            
        rect(xRect1,yRect-(i*iOffset),rectSize, rectSize);
  
        on (xRect2, yBlock, i);
        if (m1 >= pow(2,i))
            m1 -= pow(2,i);
        else
            fill(c_off);
            
        rect(xRect2,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect3, yBlock, i);
        if (m0 >= pow(2,i))
            m0 -= pow(2,i);
        else
            fill(c_off);
        rect(xRect3,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect4, yBlock, i);
        if (s1 >= pow(2,i))
            s1 -= pow(2,i);
        else
            fill(c_off);
        rect(xRect4,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect5, yBlock, i);
        if (s0 >= pow(2,i))
            s0 -= pow(2,i);
        else
            fill(c_off);
        rect(xRect5,yRect-(i*iOffset),rectSize, rectSize);
        
        
    }
    
    
    if (showTime) 
    {
      String sep = "  ";
      String thisTime = nf(h, 2)+sep+nf(m, 2)+sep+nf(s, 2);
      
      textAlign(CENTER);           
      fill(255,205,0);
      text(thisTime,240, 312);
    }
  }
  
  void on (int xstart, int ystart, int abit) {
    //#TODO: fix 4th param...
    
    //strokeWeight(strk);
    noFill();
    //stroke(c_on);
    
    rect(xstart,ystart-(abit*50),24,24);
    noStroke();
    fill(c_on);
    
  }

}

