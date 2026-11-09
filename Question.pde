class Question {
  //Les Attributs
  String texte;
  String[] reponses;
  int bonneReponse;

  //Constructeur suivi de paramètre
  Question(String t, String[] r, int b) {
    texte = t;
    reponses = r;
    bonneReponse = b;
  }
}
