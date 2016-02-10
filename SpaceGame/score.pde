class Score
{
  String name;
  int score;
  
  Score(String playerScore)
  {
    String[] details = playerScore.split(" ");
    name = details[0];
    score = Integer.parseInt(details[1]);
  }
}
