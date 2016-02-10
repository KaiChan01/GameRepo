class Enemy2 extends GameObject implements Collide
{
  int destX, destY;
  int waitTime;
  int drops;
  int ammo;
  int maxHealth;
  AudioPlayer explosion;
  
  Enemy2(int startX, int StartY)
  {
    super(startX,StartY);
    this.destX = int(random(0,width));
    this.destY = int(random((50*size),100*size));
    this.speed = 1.5;
    
    //Enemy get tougher after every boss
    this.maxHealth = 100+(bossNum*50);
    this.health = 100+(bossNum*50);
    this.ammo = 3;
    this.waitTime = 40;
    this.explosion = minim.loadFile("explosion.wav");
    
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
    
    //Draw a small life bar
    stroke(0,255,0);
    fill(255);
    rectMode(RADIUS);
    rect(position.x, position.y-(30*size)/2, map(health, 0, maxHealth, 0, 20*size), 2*size);
  }
  
  void move()
  {
      if(position.x > destX)
      {
        position.add(MoveLEFT);
      }
    
      if(position.x < destX)
      {
        position.add(MoveRIGHT);
      }
      
      if(position.y > destY)
      {
        position.add(MoveUP);
      }
      
      if(position.y < destY)
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
    
    //Stops shooting for abit after ammo is depleted
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
  
  //if collides with player
  void apply(Player player)
  {
    if(player.invincFrame == 25)
    {
      player.health -= 25;
      player.invincFrame = 0;
    }
  }
  
  void explosion()
  {
    explosion.play();
    fill(255,69,0);
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0,0,30*size,30*size);
    for(int i = int(random(5,10)); i > 0; i--)
    {
      fill(255,215,0);
      stroke(255,69,0);
      ellipse(int(random(-20*size,+20*size)), int(random(-20*size,+20*size)),10*size,10*size);
    }
    popMatrix();
  }
  
  void die()
  {
    if(health <= 0)
    {
      //Draw and play explosion
      explosion();
      
      //Possible drops
      drops = int(random(0,30));
      if(drops > 28)
      {
        LiveUp drop = new LiveUp(position.x, position.y);
        Objects.add(drop);
      }
      
      // 1 out of 3 chance for GunPowerUp
      if(drops < 11)
      {
        GunPowerUp drop = new GunPowerUp(position.x, position.y);
        Objects.add(drop);
      }
      
      score = score + 500;
      Objects.remove(this);
    }
  }
}
