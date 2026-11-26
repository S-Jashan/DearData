Table data;

void setup () {
  size (1100, 700);
  data = loadTable ("datapts5.csv", "header");
}

void draw () {
  color gcHover = (#D38A2B);
  background(#EBF2FA);
  drawAxes();
  drawKey();
  float sum = 0;
  int totalData = data.getRowCount();
  float stepSize = 100;
  for (float v = 1600; v <= 2200; v += stepSize) {
    float yPos = map(v, 1600, 2200, 640, 40);
    drawGridY(yPos, v);
  }
  int gameInterval = 10;
  for (int i = 0; i < totalData; i +=gameInterval) {
    drawGridX (i, totalData);
  }
  for (int i = 0; i <totalData; i++) {
    TableRow row = data.getRow(i);
    float teamMmr = row.getInt(1);
    sum += teamMmr;
    float mapMmr = map(teamMmr, 1600, 2200, 640, 40);
    float mapGames = map(i, 0, data.getRowCount()-1, 90, 1030);
    boolean isInside = false;
    if (dist(mouseX, mouseY, mapGames, mapMmr) <= 5) {
      fill(gcHover);
      isInside = true;
    }
    plotPoints(mapGames, mapMmr, isInside);
  }
  float averageMmr = sum/totalData;
  float avgY = map(averageMmr, 1600, 2200, 640, 40);
  drawAverage(avgY);
  for (int i = 0; i <totalData; i++) {
    TableRow row = data.getRow(i);
    float teamMmr = row.getInt(1);
    float mapMmr = map(teamMmr, 1600, 2200, 640, 40);
    float mapGames = map(i, 0, data.getRowCount()-1, 90, 1030);
    color gcRect = color(220, 20, 40, 170);
    color gcStroke = color(247, 220, 216, 100);
    color gcText = color(247, 220, 216);
    color sslRect = color(230, 30, 80, 170);
    color sslStroke = color(227, 200, 224, 100);
    color sslText = color(227, 200, 224);
    if (dist(mouseX, mouseY, mapGames, mapMmr) <= 5) {
      if (teamMmr < 1875) {
        fill(gcRect);
      } else {
        fill (sslRect);
      }
      if (teamMmr < 1875) {
        stroke(gcStroke);
      } else {
        stroke(sslStroke);
      }
      int rectY = mouseY + 17;
      if (rectY >= 550) {
        rectY = 500;
      }
      int rectX = mouseX - 125;
      if (rectX < 5) {
        rectX = 5;
      }
      if (rectX > width - 255) {
        rectX = width - 255;
      }
      rect(rectX, rectY, 250, 150);
      if (teamMmr < 1875) {
        fill(gcText);
      } else {
        fill (sslText);
      }
      textSize(14);
      textAlign(CENTER);
      text(row.getString(0), rectX + 125, rectY + 10);
      text("S23 Peak: " + int(teamMmr), rectX + 125, rectY + 30);
      if (row.getString(4).equals("W")) {
        text("Win", rectX + 125, rectY + 50);
      } else {
        text("Loss", rectX + 125, rectY + 50);
      }
      text("Points: " + row.getInt(3), rectX + 125, rectY + 70);
      fill(gcHover);
    }
  }
}
