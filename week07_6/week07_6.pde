ArrayList<PVector>pt= new ArrayList<PVector>();
void setup(){
  size(400,400);
  background(#9EC7CB);
}
float ghostX=400,ghostY=20;
void mouseDragged(){
  pt.add(new PVector(mouseX,mouseY));
}
void draw(){
  background(#9EC7CB);
  strokeWeight(1);
  stroke(0);ellipse(200,200,15,15);
  stroke(0);ellipse(ghostX,ghostY,15,15);
  strokeWeight(4);
  float dpx=0,dpy=0;
  for(int i=0;i<pt.size()-1;i++){
    PVector p=pt.get(i),p2=pt.get(i+1);
    dpx+=abs(p2.x-p.x);
    dpy+=abs(p2.y-p.y);
  }
  if(dpx>100&&dpy<40) stroke(255,0,0);
  else if(dpx<40&&dpy>100) stroke(0,0,255);
  else stroke(0);
  for(int i=0;i<pt.size()-1;i++){
    PVector p=pt.get(i),p2=pt.get(i+1);
    line(p.x,p.y,p2.x,p2.y);//ellipse(p.x,p.y,3,3);
  }

  float dx=200-ghostX,dy=200-ghostY,len=sqrt(dx*dx+dy*dy);
  ghostX+=dx/len/3;
  ghostY+=dy/len/3;
}
void mouseReleased(){
  //background(#9EC7CB);
  for(int i=pt.size()-1;i>=0;i--){//倒過來的for迴圈
    pt.remove(i);
  }
}
