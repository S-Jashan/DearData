Table data;

void setup () {
  size (1100, 700);
  data = loadTable ("datapts5.csv", "header");
  noLoop();
  color hoverColour = (#D38A2B);
}

void draw () {
  background(#EBF2FA);
  strokeWeight(1);
  stroke(120);
  line (60, 640, 1050, 640);
  line (60, 640, 60, 40);
  fill(60);
  strokeWeight(1);
  textAlign(CENTER);
  textSize(18);
  text ("Games played of solo queue 2v2", (1050-60)/2 + 60, 680);
  pushMatrix();
  translate(30, 640 - (640 - 40)/2);
  rotate(-PI/2);
  text ("Teammate's peak MMR", 0, 0);
  popMatrix();
  fill (130, 130, 130, 40);
  stroke(180, 180, 180, 20);
  strokeWeight(4.5);
  rect (950, 50, 140, 70);
  strokeWeight(1);
  stroke(#F59CEF);
  fill (50);
  circle(967, 72, 10);
  fill (0);
  noStroke();
  textAlign(CENTER);
  textSize(12);
  text("Teammate MMR", 1015, 75);
  fill(#FA9092);
  strokeWeight(2);
  stroke(#FA9092);
  line(960, 95, 974, 95);
  fill(0);
  textSize(10);
  text("Average teammate MMR", 1030, 97);
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
  float averageMmr = sum/totalData;
  float avgY = map(averageMmr, 1600, 2200, 640, 40);
  stroke (#FA9092);
  strokeWeight(2);
  line(60, avgY, 1050, avgY);
  textSize(12);
  textAlign(LEFT, CENTER);
  float stepSize = 100;
  for (float v = 1600; v <= 2200; v += stepSize) {
    float yPos = map(v, 1600, 2200, 640, 40);
    stroke(224, 224, 224, 70);
    line(60, yPos, 1050, yPos);
    fill(70);
    strokeWeight(2);
    text(int(v), 30, yPos);
  }
  textSize(12);
  fill (50);
  textAlign(CENTER, TOP);
  int gameInterval = 10;

  for (int i = 0; i < totalData; i +=gameInterval) {

    float xPos = map(i, 0, totalData, 60, 1050);

    stroke(224, 224, 224, 70);
    line(xPos, 40, xPos, 640);

    text("Game " + i, xPos, 650);
  }
}

boolean winLoss (String a) {
  return "W".equals(a);
}
