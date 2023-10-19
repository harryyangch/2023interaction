void setup(){
  size(400,600);
  textSize(20);
}
String Q="hello",A="";
float x=100,y=100;
void draw(){
  background(0);
  text(Q,x,y);
  ellipse(200,550,20,20);
  float dx=(200-x),dy=(550-y),d=sqrt(dx*dx+dy*dy)*3;
  x+=dx/d;
  y+=dy/d;
  if(keyPressed){
    stroke(255,0,0);
    line(220,550,x,y);
  }
}
