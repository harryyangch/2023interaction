
float [] HLE={-1042, -3479.7, 1003.7, -1669, -1639.6, -14219, -3655.1, -4917, 9363.2, -4271.8, -24, 681};
float [] HLN={-17090, -13711, -22888, -19631, -23818, -18573, -19636, -15648, -18256, -15721, -17776, -15581};
int N=12;
void setup(){
  size(500,500);
  frameRate(10);
}
void draw(){
  background(#FFFFF2);
  float dx=HLE[frameCount%N]/100;
  float dy=HLN[frameCount%N]/100;
  rect(200+dx,300+dy,100,100);
}
