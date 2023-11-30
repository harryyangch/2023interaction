import java.util.ArrayList;
import java.util.Arrays;

int cols = 30;
int rows = 30;
int w, h;
int[] maze;
int playerIndex;
int goalIndex;
int[] enemyIndices;
int[] weaponIndices;
int bulletsLeft = 5;
int startTime;
int gameDuration = 60000;
ArrayList<PVector> bullets;
boolean gameStarted = false;
boolean gameFinished = false;
boolean gameFailed = false;

float[] enemyMoveIntervals = {400, 300, 200, 100, 50};
float[] lastEnemyMoveTimes;

void setup() {
  size(700, 700);  // 設置視窗大小
  w = 20;  // 遊戲格子大小
  h = 20;
  initializeMaze();
  initializeEnemies();
  initializeWeapons();
  bullets = new ArrayList<PVector>();
}

void draw() {
  background(255);

  // 顯示遊戲畫面
  if (gameStarted) {
    drawGame();
    drawInfoPanel();
  } else if (gameFinished) {
    drawWinScreen();
  } else {
    drawStartScreen();
  }
}

void drawGame() {
  for (int i = 0; i < enemyIndices.length; i++) {
    if (millis() - lastEnemyMoveTimes[i] > enemyMoveIntervals[i]) {
      moveEnemy(i);
      lastEnemyMoveTimes[i] = millis();
    }
  }

  drawMaze();
  drawPlayer();
  drawEnemies();
  drawWeapons();
  updateBullets();
  checkCollisions();
  checkWin();
}

void drawInfoPanel() {
  // 顯示時間在右上角
  fill(0);
  textSize(16);
  textAlign(RIGHT, TOP);
  text("Time: " + nf((gameDuration - (millis() - startTime)) / 1000, 0, 1) + "s", width - 10, 10);
  text("Bullets: " + bulletsLeft, width - 10, 30);
}

void drawMaze() {
  for (int i = 0; i < maze.length; i++) {
    if (maze[i] == 1) {
      fill(0);
      rect((i % cols) * w, floor(i / cols) * h, w, h);
    }
  }
  fill(255, 0, 0);
  rect((goalIndex % cols) * w, floor(goalIndex / cols) * h, w, h);
}

void drawPlayer() {
  fill(0, 0, 255);
  rect((playerIndex % cols) * w, floor(playerIndex / cols) * h, w, h);
}

void drawEnemies() {
  for (int i = 0; i < enemyIndices.length; i++) {
    fill(255, 0, 0);
    rect((enemyIndices[i] % cols) * w, floor(enemyIndices[i] / cols) * h, w, h);
  }
}

void drawWeapons() {
  fill(255, 255, 0);
  for (int i = 0; i < weaponIndices.length; i++) {
    ellipse((weaponIndices[i] % cols + 0.5) * w, (floor(weaponIndices[i] / cols) + 0.5) * h, w * 0.8, h * 0.8);
  }
}

void updateBullets() {
  fill(0);
  for (int i = bullets.size() - 1; i >= 0; i--) {
    PVector bullet = bullets.get(i);
    ellipse(bullet.x, bullet.y, w * 0.5, h * 0.5);

    // 更新子彈位置
    float speed = 5.0;  // 調整子彈速度
    switch (int(bullet.z)) {
      case UP:
        bullet.y -= speed; // 子彈朝上移動
        break;
      case DOWN:
        bullet.y += speed; // 子彈朝下移動
        break;
      case LEFT:
        bullet.x -= speed; // 子彈朝左移動
        break;
      case RIGHT:
        bullet.x += speed; // 子彈朝右移動
        break;
    }

    // 檢查子彈是否超出畫面，如果是則移除
    if (bullet.y < 0 || bullet.y > height || bullet.x < 0 || bullet.x > width) {
      bullets.remove(i);
    }
  }
}

void moveEnemy(int index) {
  int direction = floor(random(4));
  int newEnemyIndex = enemyIndices[index];

  if (direction == 0 && enemyIndices[index] >= cols) {
    newEnemyIndex -= cols;
  } else if (direction == 1 && enemyIndices[index] < maze.length - cols) {
    newEnemyIndex += cols;
  } else if (direction == 2 && enemyIndices[index] % cols != 0) {
    newEnemyIndex--;
  } else if (direction == 3 && (enemyIndices[index] + 1) % cols != 0) {
    newEnemyIndex++;
  }

  if (maze[newEnemyIndex] == 0) {
    enemyIndices[index] = newEnemyIndex;
  }
}

void checkCollisions() {
  for (int i = 0; i < enemyIndices.length; i++) {
    if (playerIndex == enemyIndices[i]) {
      gameStarted = false;
      gameFailed = true;
      return;  // 在遊戲失敗時立即返回，避免後續的操作
    }
  }

  for (int i = 0; i < weaponIndices.length; i++) {
    if (playerIndex == weaponIndices[i]) {
      weaponIndices[i] = -1;
      bulletsLeft += 5;
    }
  }

  for (int i = bullets.size() - 1; i >= 0; i--) {
    PVector bullet = bullets.get(i);
    for (int j = 0; j < enemyIndices.length; j++) {
      if (dist(bullet.x, bullet.y, (enemyIndices[j] % cols + 0.5) * w, (floor(enemyIndices[j] / cols) + 0.5) * h) < w * 0.5) {
        enemyIndices[j] = -1;
        bullets.remove(i);
        break;
      }
    }
  }

  // 移除敵人（-1 表示已被消除）
  enemyIndices = Arrays.stream(enemyIndices).filter(index -> index != -1).toArray();
}

void checkWin() {
  if (playerIndex == goalIndex) {
    gameStarted = false;
    gameFinished = true;
  }
}

void drawStartScreen() {
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("start", width / 2, height / 2);
}

void drawWinScreen() {
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("congratulations!", width / 2, height / 2);
}

void drawFailScreen() {
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("game over", width / 2, height / 2);
  textSize(20);
  text("retry", width / 2, height / 2 + 40);
}

void initializeMaze() {
  maze = new int[cols * rows];
  for (int i = 0; i < maze.length; i++) {
    maze[i] = random(1) > 0.8 ? 1 : 0;
  }
  goalIndex = maze.length - 1;
}

void initializeEnemies() {
  int numEnemies = 5;
  enemyIndices = new int[numEnemies];
  lastEnemyMoveTimes = new float[numEnemies];

  for (int i = 0; i < numEnemies; i++) {
    enemyIndices[i] = floor(random(cols * rows));
    lastEnemyMoveTimes[i] = millis();
  }
}

void initializeWeapons() {
  int numWeapons = min(3, cols * rows);
  weaponIndices = new int[numWeapons];

  for (int i = 0; i < numWeapons; i++) {
    int candidateIndex = floor(random(cols * rows));
    while (maze[candidateIndex] == 1 || candidateIndex == goalIndex || candidateIndex == playerIndex) {
      candidateIndex = floor(random(cols * rows));
    }
    weaponIndices[i] = candidateIndex;
  }
}

void mousePressed() {
  if (!gameStarted && !gameFinished && !gameFailed) {
    gameStarted = true;
    playerIndex = 0;
    bulletsLeft = 5;
    // 記錄遊戲開始時間
    startTime = millis();
  } else if (gameFinished) {
    gameFinished = false;
  } else if (gameFailed) {
    if (mouseX > width / 4 && mouseX < width * 3 / 4 && mouseY > height / 2 && mouseY < height / 2 + 40) {
      gameFailed = false;
      gameStarted = true;
      playerIndex = 0;
      bulletsLeft = 5;
      // 記錄遊戲開始時間
      startTime = millis();
    }
  }
}

int lastKeyCode = RIGHT; // 初始方向設為右方

void keyPressed() {
  if (gameStarted) {
    int newPlayerIndex = playerIndex;

    if (keyCode == UP && playerIndex >= cols) {
      newPlayerIndex -= cols;
      lastKeyCode = UP;
    } else if (keyCode == DOWN && playerIndex < maze.length - cols) {
      newPlayerIndex += cols;
      lastKeyCode = DOWN;
    } else if (keyCode == LEFT && playerIndex % cols != 0) {
      newPlayerIndex--;
      lastKeyCode = LEFT;
    } else if (keyCode == RIGHT && (playerIndex + 1) % cols != 0) {
      newPlayerIndex++;
      lastKeyCode = RIGHT;
    }

    if (key == ' ' && bulletsLeft > 0) {
      bulletsLeft--;
      bullets.add(new PVector((playerIndex % cols + 0.5) * w, (floor(playerIndex / cols) + 0.5) * h, lastKeyCode));
    }

    if (maze[newPlayerIndex] == 0) {
      playerIndex = newPlayerIndex;
    }
  }
}
