class Defaultweapon extends Player
{
  int infinity;
  
  float x, y;
  char shootButton;
  
  Defaultweapon(float gunX, float gunY, char shoot, float gX)
  {
    this.position.x = gX;
    this.position.y = 8*size;
    this.shootButton = shoot;
    
    this.x = gunX;
    this.y = gunY;
  }
  
  void drawWeapon()
  { 
    //TEST!
    pushMatrix();
    translate(x,y);
    fill(100,170,255);
    beginShape();
    //Start point
    vertex(position.x,-position.y-(2*size));
    vertex(position.x+0,-position.y);
    vertex(position.x+(2*size),-position.y);
    vertex(position.x+(2*size),-position.y-(2*size));
    vertex(position.x+(4*size),-position.y+size);
    vertex(position.x+(4*size),-position.y+(4*size));
    vertex(position.x+(2*size),-position.y+(6*size));
    
    //leftside
    vertex(position.x,-position.y+(6*size));
    vertex(position.x-(2*size),-position.y+(4*size));
    vertex(position.x-(2*size),-position.y+size);
    vertex(position.x,-position.y-(2*size));
    vertex(position.x,-position.y);
    endShape();
    
    fill(0,255,255);
    
    beginShape();
    vertex(position.x+size,-6*size);
    vertex(position.x+(2*size),-5*size);
    vertex(position.x+size,-4*size);
    vertex(position.x,-5*size);
    vertex(position.x+size,-6*size);
    endShape();
    
    popMatrix();
  }
  
  int shoot(int cd)
  { 
    if(input[shootButton] == true && cd > 10)
    {
      Bullet bullet = new Bullet(x , y, position.x ,-position.y);
      Objects.add(bullet);
      cd = 0;
    }
    
    //pushMatrix();
    //translate(x,y);
    /*
    bullet.drawBullet();
    bullet.move();
    bullet.die();
    */
    //popMatrix();
    
    return cd;
  }
  
  void die()
  {
  }
}
