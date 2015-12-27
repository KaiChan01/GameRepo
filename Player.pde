class Player extends GameObject
{
  //Fields for players
  float health;
  float lives;
  float bombs;
  
  Player()
  {
    super(width/2, height/2);
  }
  
  player(float x, float y)
  {
    super(x,y);
    
    //Read in again at some point
    health = 100;
    lives = 3;
    bombs = 3;
    ammo = 0;
  }
  
  void drawObject()
  {
    
  }
  
  void move()
  {
  }
  
  void die()
  {
  }
}
