int[][] maze = new int[50][50];
boolean[][] visited = new boolean[50][50];
boolean[][] isEnd = new boolean[50][50]; // 新增終點標記
import processing.sound.*;
SoundFile file;
int endI, endJ; // 終點的位置
int userI = 0, userJ = 0;
boolean gameFinished = false; // 遊戲是否結束的標記
boolean testVisible(int i, int j) { // true: nothing
  if (i < 0 || j < 0 || i >= 50 || j >= 50) return true;
  return visited[i][j]; // false 要用它 doing something
}
int[][] wallH = new int[50][49];
int[][] wallW = new int[49][50];
void genMaze2(int i, int j, int ii, int jj) {
  if (i == ii) wallH[i][min(j, jj)] = 1;
  if (j == jj) wallW[min(i, ii)][j] = 1;
  genMaze(ii, jj);
}
void genMaze(int i, int j) {
  visited[i][j] = true;
  println(i, j);
  while (true) {
    if (testVisible(i + 1, j) == false && int(random(2)) == 0) {genMaze2(i, j, i + 1, j);}
    if (testVisible(i - 1, j) == false && int(random(2)) == 0) {genMaze2(i, j, i - 1, j);}
    if (testVisible(i, j + 1) == false && int(random(2)) == 0) {genMaze2(i, j, i, j + 1);}
    if (testVisible(i, j - 1) == false && int(random(2)) == 0) {genMaze2(i, j, i, j - 1);}
    if (testVisible(i + 1, j) && testVisible(i - 1, j) && testVisible(i, j + 1) && testVisible(i, j - 1)) break;
  }
}
boolean gameStarted = false; // 新增遊戲是否已經開始的標記
int startTime; // 遊戲開始時間
int elapsedTime; // 已經經過的時間

int buttonX, buttonY, buttonWidth, buttonHeight;

void setup() {
  size(750, 750);
  genMaze(0, 0);
  // 設定終點的位置，這裡設定在右下角
  endI = 49;
  endJ = 49;
  isEnd[endI][endJ] = true;
  PFont myfont = createFont("標楷體", 50);
  textFont(myfont);
  textAlign(CENTER, CENTER);
  textSize(32);
  file = new SoundFile(this, "Mustard - Ballin’ ft. Roddy Ricch.mp3");

  // 設定按鈕的位置和大小
  buttonX = width / 2 - 50;
  buttonY = height / 2 - 25;
  buttonWidth = 100;
  buttonHeight = 50;
}

void draw() {
  background(180, 230, 179);

  // 繪製迷宮牆壁
  for(int i=0; i<50; i++){
    for(int j=0; j<49; j++){
      if(wallH[i][j]==0) line(15+j*15, i*15, 15+j*15, 15+i*15);
    }
  }
  for(int i=0; i<49; i++){
    for(int j=0; j<50; j++){
      if(wallW[i][j]==0) line(j*15, 15+i*15, 15+j*15, 15+i*15);
    }
  }

  // 如果遊戲已經開始，繪製終點和玩家
  if (gameStarted) {
    fill(255, 255, 0);
    ellipse(endJ * 15 + 8, endI * 15 + 8, 14, 14);

    fill(255, 0, 0);
    ellipse(userJ * 15 + 8, userI * 15 + 8, 14, 14);

    // 如果遊戲結束，顯示通關畫面
    if (gameFinished) {
      background(180, 230, 179);
      fill(0);
      textSize(50);
      text("恭喜你啊!", width / 2 , height / 2);
      file.stop();
      textSize(32);
      text("用時: " + nf(elapsedTime / 1000, 0, 2) + " 秒", width / 2, height / 2 + 50);
      fill(0, 100, 200);
      rect(buttonX, buttonY+150, buttonWidth, buttonHeight);
      fill(255);
      textSize(20);
      text("重新開始", width / 2, height / 2 + 150);
    }
  } else {
    // 繪製開始遊戲按鈕
    background(180, 230, 179);
    fill(0, 100, 200);
    rect(buttonX, buttonY, buttonWidth, buttonHeight);
    fill(255);
    textSize(20);
    text("開始遊戲", width / 2, height / 2);
  }
}

void mousePressed() {
  // 如果按鈕被點擊，開始遊戲
  if (!gameStarted && mouseX > buttonX && mouseX < buttonX + buttonWidth &&
    mouseY > buttonY && mouseY < buttonY + buttonHeight) {
      println("first");
    gameStarted = true;
    startTime = millis(); // 記錄遊戲開始的時間
    file.play(); // 開始播放音樂
  }
  if (gameFinished && mouseX > buttonX && mouseX < buttonX + buttonWidth &&
    mouseY > buttonY+150 && mouseY < buttonY + buttonHeight+150) {
      print("second");
    gameStarted = false;
    gameFinished =false;
    startTime = millis(); // 記錄遊戲開始的時間
    file.play(); // 開始播放音樂
  }
}

boolean noCrossWallW(int dI) {
  int nextI = userI + dI;
  if (nextI < 0 || nextI >= 50) return false;
  if (dI == -1 && wallW[nextI][userJ] == 1) return true;
  if (dI == +1 && wallW[userI][userJ] == 1) return true;
  return false;
}

boolean noCrossWallH(int dJ) {
  int nextJ = userJ + dJ;
  if (nextJ < 0 || nextJ >= 50) return false;
  if (dJ == -1 && wallH[userI][nextJ] == 1) return true;
  if (dJ == +1 && wallH[userI][userJ] == 1) return true;
  return false;
}

void keyPressed() {
  // 如果遊戲未開始，不處理按鍵事件
  if (!gameStarted) return;

  // 方向鍵移動玩家
  if (keyCode == UP && noCrossWallW(-1)) userI--;
  if (keyCode == DOWN && noCrossWallW(+1)) userI++;
  if (keyCode == LEFT && noCrossWallH(-1)) userJ--;
  if (keyCode == RIGHT && noCrossWallH(+1)) userJ++;

  // 檢查是否到達終點
  if (userI == endI && userJ == endJ) {
    gameFinished = true;
    elapsedTime = millis() - startTime; // 計算經過的時間
    file.stop(); // 停止播放音樂
  }
}
