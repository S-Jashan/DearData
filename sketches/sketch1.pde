void drawAxes () {
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
}

void drawKey() {
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
}

void plotPoints(float a, float b, boolean c) {
  strokeWeight(1);
  stroke(#F59CEF);
  if (c == false) {
    fill (50);
  }
  circle(a, b, 10);
}

void drawAverage(float a) {
  stroke (#FA9092);
  strokeWeight(2);
  line(60, a, 1050, a);
}

void drawGridY (float a, float b) {
  textSize(12);
  textAlign(LEFT, CENTER);
  stroke(224, 224, 224, 70);
  line(60, a, 1050, a);
  fill(70);
  strokeWeight(2);
  text(int(b), 30, a);
}

void drawGridX (int a, int b) {
  textSize(12);
  fill (50);
  textAlign(CENTER, TOP);
  float xPos = map(a, 0, b, 60, 1050);

  stroke(224, 224, 224, 70);
  line(xPos, 40, xPos, 640);

  text("Game " + a, xPos, 650);
}
