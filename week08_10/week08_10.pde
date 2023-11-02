void setup(){
  size(400,400);
}
float marioX=50,marioY=250,vx=0,vy=0;
void draw(){
  background(108,137,255);
  marioX+=vx;
  if(flying){//如果在飛行中
    marioY+=vy;//上下位置會改變
    vy+=0.98;//重力加速度往下
    if(marioY>=250){//碰到地板
      marioY=250;//站在地板上
      flying=false;//不再飛行
    }
  }
  fill(255,0,0); ellipse(marioX,marioY,15,20);
  fill(229,119,42); rect(0,260,400,150);
  drawAndTestBox(100,150,20,20);
  drawAndTestBox(200,150,20,20);
  drawAndTestBox(300,150,20,20);
}
void drawAndTestBox(int x,int y,int w,int h){
  fill(299,119,42); rect(x,y,w,h);
  if(hitBox(x,y,w,h)){
    if(vy>0){
      marioY=y-10;
      flying=false;
      stand_box=true;
    }else{
      vy=0;
      marioY=y+h+10;
    }
  }
  if(stand_box==true&&flying==false&&leaveBox(x,y,w,h)){
    stand_box=false;
    flying=true;
    vy=0;
  }
}
boolean leaveBox(int x,int y,int w,int h){
  if(x-7<marioX||marioX>x+w+7) return true;
  else return false;
}
boolean hitBox(int x,int y,int w,int h){
  if(x-7<marioX&&marioX<x+w+7&&y-10<marioY&&marioY<y+h+10) return true;
  else return false;
}
boolean flying=false,stand_box=false;//一開始沒有在飛
void keyPressed(){
  if(keyCode==RIGHT) vx=2;
  if(keyCode==LEFT) vx=-2;
  if(keyCode==UP&&flying==false){//如果沒有在飛的話才能飛
  vy=-20;
  flying=true;//開始飛行
  stand_box=false;
  }
}
void keyReleased(){
   if(keyCode==RIGHT||keyCode==LEFT) vx=0;
}
