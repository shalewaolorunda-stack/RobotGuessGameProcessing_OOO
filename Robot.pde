class Robot {
  //Les Attributs
  // Variables du robot
  float x, y;
  float angleAntenne;

  Robot(float x, float y) {
    this.x = x;
    this.y = y;
    angleAntenne = -PI/2;
  }

  //Variables du robot
  //Les Méthodes
  void afficher(boolean reponseChoisie, boolean bonneReponse) {

    // Le corps
    fill(63, 68, 68);
    rect(x - 35, y - 40, 70, 72);

    // Les LEDs
    fill(255, 255, 0);
    rect(x - 10, y - 15, 30, 10);

    fill(0, 255, 0);
    rect(x - 10, y + 5, 30, 10);

    fill(255, 0, 0);
    ellipse(x - 25, y - 30, 15, 15);

    // La tête
    fill(63, 68, 68);
    rect(x - 50, y - 80, 100, 35);

    // Yeux
    fill(0);
    ellipse(x - 15, y - 74, 10, 10);
    ellipse(x + 15, y - 74, 10, 10);

    // Bouche, change selon la réponse
    noFill();
    stroke(0);
    if (reponseChoisie && !bonneReponse) {
      arc(x, y - 63, 40, 20, PI, TWO_PI); // Triste
    } else {
      arc(x, y - 63, 40, 20, 0, PI); // Sourire
    }

    // Les roues
    fill(255);
    ellipse(x - 20, y + 35, 20, 20);
    ellipse(x + 20, y + 35, 20, 20);

    // Antenne orientable
    strokeWeight(3);
    float ax = x + cos(angleAntenne) * 70;
    float ay = y - 80 + sin(angleAntenne) * 70;
    line(x, y - 80, ax, ay);

    fill(255, 144, 0);
    ellipse(ax, ay, 10, 10);
  }
  void bougerAntenne(int choix) {
    angleAntenne = map(choix, 0, 3, -PI/1.4, -PI/2.8);
  }
  void reset() {
    angleAntenne = -PI/2;

    x = width/2;
    y = height - 80;
  }
}
