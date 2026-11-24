Table data;

void setup () {
  size (1100, 700);
  data = loadTable ("datapts5.csv", "header");
  color hoverColour = (#D38A2B);
}

void draw () {
  background(#EBF2FA);
  drawAxes();
  drawKey();
  float sum = 0;
  int totalData = data.getRowCount();
  for (int i = 0; i <totalData; i++) {
    TableRow row = data.getRow(i);
    float teamMmr = row.getInt(1);
    sum += teamMmr;
    float mapMmr = map(teamMmr, 1600, 2200, 640, 40);
    float mapGames = map(i, 0, data.getRowCount()-1, 90, 1030);
    boolean isInside = false;
    if (dist(mouseX, mouseY, mapGames, mapMmr) <= 5) {
      fill(#D38A2B);
      isInside = true;
    }
    plotPoints(mapGames, mapMmr, isInside);
  }
  float averageMmr = sum/totalData;
  float avgY = map(averageMmr, 1600, 2200, 640, 40);
  drawAverage(avgY);
  float stepSize = 100;
  for (float v = 1600; v <= 2200; v += stepSize) {
    float yPos = map(v, 1600, 2200, 640, 40);
    drawGridY(yPos, v);
  }
  int gameInterval = 10;
  for (int i = 0; i < totalData; i +=gameInterval) {
    drawGridX (i, totalData);
  }
}
