class Enemy extends GameObject implements Collide
{
  float startX;
  float startY;
  boolean sway;
  int drops;
  int maxHealth;
  AudioPlayer explosion;
  
  Enemy(float startX, float StartY)
  {
    super(startX,StartY);
    
    this.startX=startX;
    this.startY=startY;
    this.sway=true;
    this.speed = 1.05;
    
    //Enemy get tougher after every boss
    this.maxHealth = 100+(bossNum*100);
    this.health = 100+(bossNum*100);
    this.explosion = minim.loadFile("explosion.wav");
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
    
    //Draw a small life bar
    stroke(0,255,0);
    fill(255);
    rectMode(RADIUS);
    rect(position.x, position.y-(30*size)/2, map(health, 0, maxHealth, 0, 20*size), 2*size);
  }
  
  //Moves in a swaying motion
  void move()
  {
    position.add(MoveDOWN);
    //Move left
    if(sway == true)
    {
      MoveLEFT.mult(speed);
      position.add(MoveLEFT);
      
     if(position.x-startX<-100)
      {
        //Speeds up a little as it sways
        speed = 1.05;
        sway = false;
        MoveLEFT = new PVector(-1, 0);
      }
    }
    
    //Move right
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
    if(player.invincFrame == 50)
    {
      player.health -= 40;
      player.invincFrame = 0;
    }
  }
  
  //Drawing a small explosion and playing sound
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
      explosion();
      
      //Possibility of droping an powerup if distoryed by player
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
      
      score = score + 200;
      Objects.remove(this);
    }
  }
}
