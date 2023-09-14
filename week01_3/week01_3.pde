void setup(){//設定
  size(500,500);
  background(255);//改白色背景(255)
}

void draw(){//畫圖 每秒畫60次
  if(mousePressed){//如果滑鼠有按下去的話
    line(mouseX,mouseY,pmouseX,pmouseY);
  }//畫線(滑鼠座標mouseX,mouseY,到之前滑鼠座標pmouseX,pmouseY)
}
