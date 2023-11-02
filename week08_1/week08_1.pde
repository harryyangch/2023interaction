//碰撞偵測
void setup(){
  size(400,400);
   background(#9EC7CB);
}
float x=200,y=200,vx=1,vy=1;
void draw(){
  ellipse(x,y,10,10);
  x+=vx;
  y+=vy;
}
