import com.barneycodes.spicytext.*;

Table data;
PImage Mannfield;
PGraphics pg;
PImage ssl;
PImage ssl1;
PImage gc3;
PImage gc2;

void setup () {
  size (1100, 700);
  data = loadTable ("datapts5.csv", "header");
  Mannfield = loadImage("Mannfield1.jpg");
  pg = createGraphics(1100, 700);
  pg.beginDraw();
  pg.background(#F2F7FF);
  pg.tint(255, 60);
  pg.image(Mannfield, 0, 0);
  pg.endDraw();
  ssl = loadImage("ssl.jpg");
  ssl1 = loadImage("ssl1.png");
  gc3 = loadImage("gc3.png");
  gc2 = loadImage("gc2.png");
}

void draw () {
  color gcHover = (#F57E60);
  color sslHover = (#F560AB);
  //background(#F2F7FF);
  //pushStyle();
  //tint(255, 40);
  //imageMode(CENTER);
  //image(Mannfield, width/2, height/2, 1100, 700);
  //popStyle();
  image(pg, 0, 0);
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
      if (teamMmr < 1875) {
        fill(gcHover);
      } else {
        fill (sslHover);
      }
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
    color gcStroke = color(0);
    color gcText = color(247, 220, 216);
    color sslRect = color(230, 30, 80, 170);
    color sslStroke = color(0);
    color sslText = color(227, 200, 224);
    color sslName = color(#ED88D1);
    color gcName = color(#EDC788);
    if (dist(mouseX, mouseY, mapGames, mapMmr) <= 5) {
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
      if (teamMmr >= 1875) {
        //pushStyle();
        ////tint(255, 250);
        //image(ssl, rectX, rectY, 250, 150);
        //popStyle();
        pushStyle();
        tint(200, 120, 160);
        image(ssl1, rectX + 15, rectY - 17.5, 220, 170);
        popStyle();
      } else if (teamMmr >= 1715) {
        pushStyle();
        tint(150);
        image(gc3, rectX + 15, rectY - 17.5, 220, 170);
        popStyle();
      } else {
        pushStyle();
        tint(150);
        image(gc2, rectX + 15, rectY - 17.5, 220, 170);
        popStyle();
      }
      if (teamMmr < 1875) {
        fill(gcRect);
      } else {
        fill (sslRect);
      }
      if (teamMmr < 1875) {
        strokeWeight(3);
        stroke(gcStroke);
      } else {
        strokeWeight(3);
        stroke(sslStroke);
      }
      rect(rectX, rectY, 250, 135);
      if (teamMmr < 1875) {
        fill(gcName);
      } else {
        fill (sslName);
      }
      textSize(18);
      textAlign(CENTER);
      text(row.getString(0), rectX + 125, rectY + 20);
      if (teamMmr < 1875) {
        fill(gcText);
      } else {
        fill (sslText);
      }
      textSize(14);
      text("S23 Peak: " + int(teamMmr), rectX + 125, rectY + 40);
      if (row.getString(4).equals("W")) {
        fill(#B1F7B4);
        text("Win", rectX + 125, rectY + 60);
      } else {
        fill(#FA7272);
        text("Loss", rectX + 125, rectY + 60);
      }
      if (teamMmr < 1875) {
        fill(gcText);
      } else {
        fill (sslText);
      }
      if (row.getInt(3) > 0) {
        fill(#A3F5D7);
      } else {
        fill(#DBF56D);
      }
      text("Points: " + row.getInt(3), rectX + 125, rectY + 80);
      if (teamMmr < 1875) {
        fill(gcText);
      } else {
        fill (sslText);
      }
      if (!row.getString(5).equals("n/a")) {
        fill(#6DABF5);
        textSize(18);
        text(row.getString(5), rectX + 125, rectY + 100);
        textSize(14);
      } else {
        text("No tag", rectX + 125, rectY + 100);
      }
      if (teamMmr < 1875) {
        fill(gcText);
      } else {
        fill (sslText);
      }
      text("Days into the ranked season: " + row.getInt(6), rectX + 125, rectY + 120);
    }
  }
}
