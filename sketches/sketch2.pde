Table data;

void setup () {
  size (1100, 700);
  background(#CFF4FA);
  data = loadTable ("datapts5.csv", "header");
  noLoop();
}

void draw () {
  strokeWeight(1);
  line (60, 640, 1050, 640);
  line (60, 640, 60, 40);
  fill(0);
  strokeWeight(1);
  textAlign(CENTER);
  textSize(18);
  text ("Days into ranked season", (1050-60)/2 + 60, 680);
  pushMatrix();
  translate(30, 640 - (640 - 40)/2);
  rotate(-PI/2);
  text ("Teammate's peak MMR", 0, 0);
  popMatrix();
  for (int i = 0; i <data.getRowCount(); i++) {
    TableRow row = data.getRow(i);
    println("Teammate's peak MMR:", row.getInt(1));
    String gameResult = row.getString(4);
    if (winLoss(gameResult)) {
      println("Match Win");
    } else {
      println("Match Loss");
    }
  }
}

boolean winLoss (String a) {
  return "W".equals(a);
}
