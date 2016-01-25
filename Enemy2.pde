class Enemy2 extends GameObject implements Collide
{
  int destX, destY;
  int waitTime;
  int drops;
  int ammo;
  
  Enemy2()
  {
  }
  
  Enemy2(int startX, int StartY)
  {
    super(startX,StartY);
    this.destX = int(random(0,width));
    this.destY = int(random((50*size),height-(100*size)));
    this.speed = 1.5;
    this.health = 150;
    this.ammo = 3;
    this.waitTime = 40;
    
    this.MoveUP.mult(speed);
    this.MoveDOWN.mult(speed);
    this.MoveLEFT.mult(speed);
    this.MoveRIGHT.mult(speed);
  }
  
  void drawObject()
  {
    pushMatrix();
    translate(position.x,position.y);
    stroke(102,0,51);
    fill(153,0,76);
    ellipse(0,0,50,50);
    beginShape();
    vertex(-15*size,0);
    vertex(15*size,0);
    vertex(17*size,5*size);
    vertex(-17*size,5*size);
    endShape();
    
    fill(51,0,51);
    beginShape();
    vertex(16*size,5*size);
    vertex(10*size,13*size);
    vertex(-10*size,13*size);
    vertex(-16*size,5*size);
    vertex(-17*size,5*size);
    endShape();
    popMatrix();
  }
  
  void move()
  {
    if(position.x > destX)
    {
      position.add(MoveLEFT);
    }
    else if(position.x < destX)
    {
      position.add(MoveRIGHT);
    }
    
    if(position.y > destY)
    {
      position.add(MoveUP);
    }
    else if(position.y < destY)
    {
      position.add(MoveDOWN);
    }
    
    if(ammo > 0)
    {
      if(frameCount%30 == 0)
      {
        for(int i = 1; i < 6; i++)
        {
          EnemyBullet c = new EnemyBullet(int(position.x), int(position.y), HALF_PI+i/0.01);
          Objects.add(c);
        }
        ammo --;
      }
    }
    
    if(ammo == 0)
    {
      waitTime --;
      if(waitTime == 0)
      {
        ammo = 3;
        waitTime = 40;
      }
    }
  }
  
  void apply(Player player)
  {
    if(player.invincFrame == 25)
    {
      player.health -= 25;
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
      if(drops == 1 || drops == 2 || drops == 3 || drops == 4 || drops == 5)
      {
        GunPowerUp drop = new GunPowerUp(position.x, position.y);
        Objects.add(drop);
      }
      Objects.remove(this);
    }
  }
}
