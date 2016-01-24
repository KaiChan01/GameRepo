class Bullet extends GameObject implements BulletHit, BulletHit2
{
  
  Bullet(float x, float y, float posX, float posY)
  {
    super(x+posX,y+posY);
    
    speed = 4*size;
    MoveUP.mult(speed);
  }
  
  void drawObject()
  {
    fill(0,255,0);
    stroke(0,200,0);
    pushMatrix();
    rectMode(CENTER);
    translate(position.x,position.y);
    rect(0,0,2*size,-10*size);
    rectMode(CORNER);
    popMatrix();
  }
  
  void damage(Enemy enemy)
  {
    enemy.health -= 25;
    Objects.remove(this);
  }
  
  void damage2(Enemy2 enemy)
  {
    enemy.health -= 25;
    Objects.remove(this);
  } 
  
  void move()
  {
    position.add(MoveUP);
  }
  
  void die()
  {
    if(this.position.y < 0)
    {
      Objects.remove(this);
    }
  }
}
