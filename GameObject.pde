abstract class GameObject
{
  
  float health;
  int lives;
  
  PVector position;
  
  //Might only need down?
  PVector MoveUP;
  PVector MoveDOWN;
  PVector MoveLeft;
  PVector MoveRight;

  GameObject()
  {
    //Need to make use of this
    this(width/2, height/2);
  }
  
  GameObject(float x, float y)
  {
    position = new PVector(x,y);
    MoveUP = new PVector(0, -1);
    MoveDOWN = new PVector(0, 1);
    MoveLeft = new PVector(-1, 0);
    MoveRight = new PVector(1, 0);
  }
  
  abstract void drawObject();
  abstract void move();
  abstract void die();
}
