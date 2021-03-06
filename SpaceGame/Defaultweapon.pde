class Defaultweapon extends GameObject
{
  int infinity;
  float angle;
  int weaponType;
  int soundIndex;
  
  float x, y;
  char shootButton;
  
  Defaultweapon(int weaponType, float shipX, float shipY, char shoot, float gX, float gY, float angle)
  {
    super(gX,gY);
    
    this.weaponType = weaponType;
    this.shootButton = shoot;
    this.angle = angle;
    this.x = shipX;
    this.y = shipY;
    this.soundIndex = 1;
  }
  
  void drawObject()
  { 
    //TEST!
    pushMatrix();
    translate(x,y);
    rotate(angle);
    fill(100,170,255);
    beginShape();
    //Start point
    vertex(position.x,-position.y);
    vertex(position.x+(size),-position.y);
    vertex(position.x+(size),-position.y-(2*size));
    vertex(position.x+(3*size),-position.y+size);
    vertex(position.x+(3*size),-position.y+(4*size));
    vertex(position.x+(size),-position.y+(6*size));
    
    //leftside
    vertex(position.x-(size),-position.y+(6*size));
    vertex(position.x-(3*size),-position.y+(4*size));
    vertex(position.x-(3*size),-position.y+size);
    vertex(position.x-(size),-position.y-(2*size));
    vertex(position.x-(size),-position.y);
    vertex(position.x,-position.y);
    endShape();
    
    fill(0,255,255);
    
    beginShape();
    vertex(position.x,-position.y+2*size);
    vertex(position.x+(size),-position.y+3*size);
    vertex(position.x,-position.y+4*size);
    vertex(position.x-size,-position.y+3*size);
    vertex(position.x,-position.y+2*size);
    endShape();
    popMatrix();
  }
  
  int shoot(int cd)
  { 
    if(input[shootButton] == true && cd > 10)
    {
      Bullet bullet = new Bullet(weaponType, x , y, position.x ,-position.y, angle);
      Objects.add(bullet);
      
      //Animation some flashes
      stroke(100,100,0,100);
      fill(255,255,0,100);
      pushMatrix();
      translate(x,y);
      ellipse(position.x,-position.y,10*size,10*size);
      popMatrix();
      
      if(weaponType == 0)
      {
        //Play sound
        gun.rewind();
        gun.play();
        //Cooldown is set to zero and must wait to fire again
        cd = 0;
      }
      
      if(weaponType == 1)
      {
        //Gun is ready to shoot instantly, no Cooldown, a machine gun
        cd = 11;
      }
    }
    return cd;
  }
  
  void move()
  {
  }
  
  void die()
  {
  }
}
