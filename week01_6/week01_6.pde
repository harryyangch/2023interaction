//互動模式
void setup(){//設定
  size(500,500);
  background(255);//改白色背景(255)
}

void draw(){//畫圖 每秒畫60次
  if(mousePressed){//如果滑鼠有按下去的話
    line(mouseX,mouseY,pmouseX,pmouseY);
  }//畫線(滑鼠座標mouseX,mouseY,到之前滑鼠座標pmouseX,pmouseY)
}

int w=1;
void keyPressed(){
  if(key=='1') stroke(255,0,0);//如果按下數字1 筆觸為紅色
  if(key=='2') stroke(0,255,0);//如果按下數字2 筆觸為綠色
  if(key=='3') stroke(0,0,255);//如果按下數字3 筆觸為藍色
  if(key=='s'||key=='S') save("output.png");//按下s鍵可以存檔為output.jpg
  if(key=='+') strokeWeight(++w); 
  if(key=='-') strokeWeight(--w); 
  println(w);
}
