abstract class GameObject
{
  
  float health;
  int lives;
  float speed;
  
  PVector position;
  //Might only need down?
  PVector MoveUP;
  PVector MoveDOWN;
  PVector MoveLEFT;
  PVector MoveRIGHT;

  GameObject()
  {
    this(width/2, height/2);
  }
  
  GameObject(float x, float y)
  {
    position = new PVector(x,y);
    MoveUP = new PVector(0, -1);
    MoveDOWN = new PVector(0, 1);
    MoveLEFT = new PVector(-1, 0);
    MoveRIGHT = new PVector(1, 0);
  }
  
  abstract void drawObject();
  abstract void move();
  abstract void die();
}
