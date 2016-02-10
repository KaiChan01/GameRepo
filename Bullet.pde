class Bullet extends GameObject implements BulletHit, BulletHit2, BulletHit3
{
  float angle;
  int weaponType;
  int damage;
  
  Bullet(int weaponType, float x, float y, float posX, float posY, float angle)
  {
    super(x+posX,y+posY);
    
    this.angle = angle;
    this.speed = 4*size;
    
    if(weaponType == 0)
    {
      this.damage = 25;
    }
    
    if(weaponType == 1)
    {
      this.damage = 1+bossNum;
    }
  }
  
  void drawObject()
  {
    fill(0,255,0);
    stroke(0,200,0);
    pushMatrix();
    rectMode(CENTER);
    translate(position.x,position.y);
    rotate(angle);
    rect(0,0,2*size,-10*size);
    rectMode(CORNER);
    popMatrix();
  }
  
  void damage(Enemy enemy)
  {
    enemy.health -= damage;
    Objects.remove(this);
  }
  
  void damage2(Enemy2 enemy)
  {
    enemy.health -= damage;
    Objects.remove(this);
  } 
  
  void damage3(Boss enemy)
  {
    enemy.health -= damage;
    Objects.remove(this);
  } 
  
  void move()
  {
    MoveUP.x = sin(angle);
    MoveUP.y = -cos(angle);
    
    MoveUP.mult(speed);
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
