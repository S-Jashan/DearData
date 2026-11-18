Table data;

void setup () {
  size (1100, 700);
  data = loadTable ("datapts5.csv", "header");
  noLoop();
}

void draw () {
  background(#B8FAF2);
  strokeWeight(1);
  stroke(120);
  line (60, 640, 1050, 640);
  line (60, 640, 60, 40);
  fill(60);
  strokeWeight(1);
  textAlign(CENTER);
  textSize(18);
  text ("Days into ranked season", (1050-60)/2 + 60, 680);
  pushMatrix();
  translate(30, 640 - (640 - 40)/2);
  rotate(-PI/2);
  text ("Teammate's peak MMR", 0, 0);
  popMatrix();
  float sum = 0;
  int totalData = data.getRowCount();
  for (int i = 0; i <totalData; i++) {
    TableRow row = data.getRow(i);
    float teamMmr = row.getInt(1);
    sum += teamMmr;
    println("Teammate's peak MMR:", teamMmr);
    String gameResult = row.getString(4);
    if (winLoss(gameResult)) {
      println("Match Win");
    } else {
      println("Match Loss");
    }
    int daysSeason = row.getInt(6);
    println("Days into the season:", daysSeason);
    //circle (daysSeason ^ 5, teamMmr - 1600, 20);
    float mapMmr = map(teamMmr, 1600, 2200, 640, 40);
    float mapDays = map(i, 0, data.getRowCount()-1, 90, 1030);
    strokeWeight(1);
    stroke(#F59CEF);
    fill (50);
    circle(mapDays, mapMmr, 10);
  }
  float averageVal = sum/totalData;
  float avgY = map(averageVal, 1600, 2200, 640, 40);
  stroke (#FA9092);
  strokeWeight(2);
  line(60, avgY, 1050, avgY);
  textSize(12);
  textAlign(LEFT, CENTER);
  float stepSize = 100;
  for (float v = 1600; v <= 2200; v += stepSize) {
    float yPos = map(v, 1600, 2200, 640, 40);
    stroke(194, 194, 194, 100);
    line(60, yPos, 1050, yPos);
    fill(70);
    strokeWeight(2);
    text(int(v), 30, yPos);
  }
  textSize(12);
  fill(70);
  textAlign(CENTER, TOP);
  int totalDays = data.getColumnCount();
  int stepSize
}

boolean winLoss (String a) {
  return "W".equals(a);
}
