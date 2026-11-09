// Variables 
boolean commencer = false;
boolean quizFini = false;
boolean reponseChoisie = false;
boolean bonneReponse = false;

int choix = -1;
int questionIndex = 0;

int reponseJ = 0;
int reponseF = 0;

//Appeelle de classes et tableux
Robot robot;
Question[] quiz;
Confetti[] confettis = new Confetti[100];

// Initialisation de la page d'accueil
void setup() {
  size(600, 400);
  textAlign(CENTER, CENTER);
  textSize(16);

  robot = new Robot(width/2, height - 80);
  initialiserQuiz();

  for (int i = 0; i < confettis.length; i++) {
    confettis[i] = new Confetti();
  }
}

void draw() {
  if (!commencer) {
    afficherAccueil();
  } else if (quizFini) {
    afficherFin();
  } else {
    afficherJeu();
  }
}

void afficherAccueil() {
  background(0);

  for (int i = 0; i < confettis.length; i++) {
    confettis[i].tomber();
    confettis[i].afficher();
  }

  fill(255);
  textSize(48);
  text("QUIZ DE DEVINETTE", width/2, height/2);
  textSize(24);
  text("Cliquez pour commencer", width/2, height -50);
}
void afficherJeu() {
  background(255);

  robot.afficher(reponseChoisie, bonneReponse);
  afficherQuestion();
  afficherReponses();

  if (reponseChoisie) {
    afficherResultat();
  }
}

void afficherFin() {

  background(0, 200, 0);
  fill(255);
  textSize(26);
  text("Quiz terminé !", width/2, height/2);
  textSize(18);
  text("Bonnes réponses : " + reponseJ, width/2, height/2 + 35);
  text("Mauvaises réponses : " + reponseF, width/2, height/2 + 55);
  textSize(16);
  text("Cliquez pour rejouer", width/2, height/2 + 95);
}

void afficherQuestion() {

  Question q = quiz[questionIndex];
  fill(0);
  textSize(18);
  text(q.texte, width/2, 60);
}

void afficherReponses() {

  Question q = quiz[questionIndex];

  for (int i = 0; i < q.reponses.length; i++) {
    float x = 60 + i * 110;

    stroke(i == choix ? color(0, 180, 0) : color(100));
    noFill();
    rect(x, 120, 80, 40, 8);

    fill(0);
    text(q.reponses[i], x + 40, 140);
  }
}

void afficherResultat() {

  fill(bonneReponse ? color(0, 180, 0) : color(255, 0, 0));
  textSize(20);
  text(bonneReponse ? "Bonne réponse !" : "Mauvaise réponse", width/2, 200);

  //affichage de la bonne réponse en cas de mauvise séléction
  if (!bonneReponse) {
    Question q = quiz[questionIndex];
    fill(0);
    textSize(16);
    fill(0, 0, 255);
    text("Bonne réponse : " + q.reponses[q.bonneReponse], width/2, 230);
  }
  fill(0);
  textSize(18);
  text("Cliquez pour continuer", width/2, height -28);
}

void initialiserQuiz() {

  quiz = new Question[]{
    new Question("Quel est l'âge que peut atteindre une reine des fourmis ?", new String[]{"5 ans", "3 ans", "30 ans", "20 ans"}, 2),
    new Question("Quelle est la capitale du Chili ?", new String[]{"Manille", "Granada", "Santiago", "Valdivia"}, 2),
    new Question("Quel était le nom de Paris il y a 2000 ans ?", new String[]{"Lutèce", "Alésia", "Lugdunum", "La Cité"}, 0),
    new Question("Quelle est la plus petite unité de mémoire des ordinateurs ?", new String[]{"1 bit", "5 bits", "8 octet", "4 kilo"}, 0),
    new Question("Dans la mythologie grecque, qui était connu comme le messager des dieux ?", new String[]{"Hera", "Hermes", "Ares", "Apollon"}, 1),
    new Question( "Quel est le plus grand organe du corps humain ?", new String[]{"Le foie", "L'intestin", "La trachée", "La peau"}, 3)
  };
}

void resetEtat() {
  reponseChoisie = false;
  bonneReponse = false;
  choix = -1;
  robot.reset();
}

void mousePressed() {

  if (!commencer) {
    commencer = true;
    return;
  }
  if (quizFini) {
    quizFini = false;
    questionIndex = 0;

    reponseJ = 0;
    reponseF = 0;

    resetEtat();
    return;
  }

  if (reponseChoisie) {
    questionIndex++;
    if (questionIndex >= quiz.length) {
      quizFini = true;
    } else {
      resetEtat();
    }
    return;
  }

  gererClicReponse();
}

void gererClicReponse() {
  Question q = quiz[questionIndex];

  for (int i = 0; i < q.reponses.length; i++) {
    float x = 60 + i * 110;
    if (mouseX > x && mouseX < x + 80 && mouseY > 120 && mouseY < 160) {
      choix = i;
      robot.bougerAntenne(i);
      reponseChoisie = true;
      bonneReponse = (choix == q.bonneReponse);

      if (bonneReponse) {
        reponseJ++;
      } else {
        reponseF++;
      }
    }
  }
}
