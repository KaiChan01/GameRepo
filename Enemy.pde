class Enemy extends GameObject
{
  int ammo;
  float startX;
  float startY;
  boolean sway;
  
  Enemy()
  {
  }
  
  Enemy(float startX, float StartY)
  {
    super(startX,StartY);
    
    this.ammo = 5;
    this.startX=startX;
    this.startY=startY;
    this.sway=true;
  }
  
  void drawObject()
  {
    fill(255,0,0);
    pushMatrix();
    translate(position.x,position.y);
    ellipse(startX,startY,50,50);
    popMatrix();
  }
  
  void move()
  {
    position.add(MoveDOWN);
    if(sway == true)
    {
      position.add(MoveLEFT);
     if(position.x-startX<-100)
      {
        sway = false;
      }
    }

    if(sway == false)
    {
      position.add(MoveRIGHT);
      if(position.x-startX>100)
      {
        sway = true;
      }
    }    
  }
  
  void die()
  {
  }
}
