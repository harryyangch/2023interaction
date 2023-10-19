void setup(){
  size(400,600);
  textSize(20);
}
String Q="hello",A="";
float x=100,y=100;
void draw(){
  background(0);
  fill(#FFFFFF);text(Q,x,y);
  fill(#FF0000);text(A,x,y);
  ellipse(200,550,20,20);
  float dx=(200-x),dy=(550-y),d=sqrt(dx*dx+dy*dy)*3;
  x+=dx/d;
  y+=dy/d;
  if(keyPressed){
    stroke(255,0,0);
    line(220,550,x,y);
  }
}
void keyPressed(){
  int i=A.length();
  if(key==Q.charAt(i)){
    A+=key;
  }
}
