class Confetti {
  //Les Attributs
  float cx, cy;
  float vitesse;
  color c;

  //Les Constructeurs
  Confetti() {
    cx = random(width);
    cy = random(-height, 0);
    vitesse = random(1, 4);
    c = color(random(255), random(255), random(255));
  }
   //Les Méthodes
  void tomber() {
    cy += vitesse;

    // Recommence en haut quand sort de l'écran
    if (cy > height) {
      cy = random(-50, 0);
      cx = random(width);
    }
  }

  void afficher() {
    fill(c);
    noStroke();
    ellipse(cx, cy, 6, 6);
  }
}
