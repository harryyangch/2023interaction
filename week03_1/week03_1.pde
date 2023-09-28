void setup(){
  size(500,500);
}
float x=250,y=250;
float dx=1,dy=1;
void draw(){
  ellipse(x,y,5,5);
  x+=dx;
  y+=dy;
}
