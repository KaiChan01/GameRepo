class EnemyBullet extends GameObject implements Collide
{
  float angle;
  
  EnemyBullet(int shipX, int shipY, float angle)
  {
    super(shipX, shipY);
    this.angle = angle;
    this.speed = 2*size;
  }
  
  void drawObject()
  { 
    pushMatrix();
    translate(position.x,position.y);
    fill(51,255,255);
    stroke(51,255,255);
    ellipse(0,0,5*size,5*size);
    popMatrix();
  }
  
  //Moves in relation to the angle of the bullet
  void move()
  {
    MoveDOWN.x = -sin(angle);
    MoveDOWN.y = cos(angle);
    
    this.MoveDOWN.mult(speed);
    
    position.add(MoveDOWN);
  }
  
  //If bullet hits player
  void apply(Player player)
  {
    if(player.invincFrame == 50)
    {
      player.health -= 20;
      player.invincFrame = 0;
      Objects.remove(this);
    }
  }
  
  void die()
  {
    //Remove from array list if bullet flys out of screen
    if(position.x > width+20*size || position.y < -20*size || position.y > height+20*size)
    {
      Objects.remove(this);
    }
  }
}
