class EnemyBullet extends GameObject implements EnemyHit
{
  float angle;
  
  EnemyBullet()
  {
  }
  
  EnemyBullet(int shipX, int shipY, float angle)
  {
    super(shipX, shipY);
    this.angle = angle;
    this.speed = 3*size;
  }
  
  void drawObject()
  { 
    pushMatrix();
    translate(position.x,position.y);
    fill(51,255,255);
    stroke(51,255,255);
    ellipse(0,0,5*size,5*size);
    popMatrix();
    println(position.x,position.y);
  }
  
  void move()
  {
    MoveDOWN.x = -sin(angle);
    MoveDOWN.y = cos(angle);
    
    this.MoveDOWN.mult(speed);
    
    position.add(MoveDOWN);
  }
  
  void hit(Player player)
  {
    player.health -= 20;
    Objects.remove(this);
  }
  
  void die()
  {
    if(position.x > width+20*size || position.y < -20*size || position.y > height+20*size)
    {
      Objects.remove(this);
    }
  }
}
