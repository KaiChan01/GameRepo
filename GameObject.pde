abstract class GameObject
{
  
  float health;
  int lives;
  
  PVector position;
  
  //Might only need down?
  PVector up;
  PVector down;
  PVector left;
  PVector right;

  GameObject()
  {
    //Need to make use of this
    this(width/2, height/2);
  }
  
  GameObject(float x, float y)
  {
    position = new PVector(x,y);
    up = new PVector(0, -1);
    down = new PVector(0, 1);
    left = new PVector(-1, 0);
    right = new PVector(1, 0);
  }
  
  abstract void drawObject();
  abstract void move();
  abstract void die();
}
