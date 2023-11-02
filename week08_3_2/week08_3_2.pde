//碰撞偵測
void setup(){
  size(400,400);
  background(#9EC7CB);
}
float x=50,y=250,vx=2,vy=-20;
void draw(){
  x+=vx;
  y+=vy;
  vy+=0.98;//重力加速度
  if(y>350){//利用if判斷，看有沒有到地板 y=350位置
    y=350;
    vy=-vy*0.5;//能量耗損，速度變慢
  }
  ellipse(x,y,10,10);
}
