void setup(){
  size(500,500);
  for(int i=0;i<N;i++){
    x[i]=random(500);
    y[i]=random(500);
    dx[i]=random(-1,+1);//dx=random(-1,+1);//亂數往哪裡跑
    dy[i]=random(-1,+1);//dy=random(-1,+1);//亂數往哪裡跑
  }
}
int N=40;
float[]x=new float[N];//float x=250,y=250;
float[]y=new float[N];
float []dx=new float[N];//float dx=1,dy=1;
float []dy=new float[N];
void draw(){
  background(0);
  for(int i=0;i<N;i++){
  ellipse(x[i],y[i],5,5);
  for(int k=0;k<N;k++){
    float d=dist(x[i],y[i],x[k],y[k]);
    stroke(2.55*(100-d));
    if(d<100)
      line(x[i],y[i],x[k],y[k]);
  }
  x[i]+=dx[i];
  y[i]+=dy[i];
  if(x[i]<0||x[i]>500)dx[i]=-dx[i];
  if(y[i]<0||y[i]>500)dy[i]=-dy[i];
  }
}
