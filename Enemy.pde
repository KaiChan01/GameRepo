class Enemy extends GameObject implements Collide
{
  float startX;
  float startY;
  boolean sway;
  int drops;
  
  Enemy()
  {
  }
  
  Enemy(float startX, float StartY)
  {
    super(startX,StartY);
    
    this.startX=startX;
    this.startY=startY;
    this.sway=true;
    this.speed = 1.05;
    this.health = 200;
  }
  
  void drawObject()
  {
    pushMatrix();
    translate(position.x,position.y);
    stroke(255);
    fill(32,32,32);
    ellipse(0,0,25*size,25*size);
    stroke(160,160,160);
    line(-(25*size)/2,0,(25*size)/2,0);
    line(0,-(25*size)/2,0,(25*size)/2);
    stroke(152,0,0);
    fill(255,0,0);
    ellipse(0,0,20*size,20*size);
    fill(255,85,85);
    stroke(255,85,85);
    ellipse(-(5*size/2),-(5*size/2),8*size,8*size);
    
    popMatrix();
  }
  
  void move()
  {
    position.add(MoveDOWN);
    if(sway == true)
    {
      MoveLEFT.mult(speed);
      position.add(MoveLEFT);
      
     if(position.x-startX<-100)
      {
        speed = 1.05;
        sway = false;
        MoveLEFT = new PVector(-1, 0);
      }
    }

    if(sway == false)
    {
      MoveRIGHT.mult(speed);
      position.add(MoveRIGHT);
      if(position.x-startX>100)
      {
        speed = 1.05;
        sway = true;
        MoveRIGHT = new PVector(1, 0);
      }
    } 
  }
  
  void apply(Player player)
  {
    if(player.invincFrame == 25)
    {
      player.health -= 40;
      player.invincFrame = 0;
    }
  }
  
  void die()
  {
    if(health <= 0)
    {
      drops = int(random(0,50));
      if(drops == 15)
      {
        LiveUp drop = new LiveUp(position.x, position.y);
        Objects.add(drop);
      }
      
      // 5 out of 50 chance for GunPowerUp
      if(drops == 1 || drops == 2 || drops == 3 || drops == 4 || drops == 5);
      {
        GunPowerUp drop = new GunPowerUp(position.x, position.y);
        Objects.add(drop);
      }
      
      Objects.remove(this);
    }
  }
}
