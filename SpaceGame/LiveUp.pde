class LiveUp extends GameObject implements Collide
{
  int dirX, dirY;
  AudioPlayer powerUp;
  
  LiveUp(float X, float Y)
  {
    super(X,Y);
    
    this.dirX = int(random(0,2));
    this.dirY = int(random(0,2));
    this.powerUp = minim.loadFile("Powerup.wav");
  }
  
  void drawObject()
  {
    pushMatrix();
    translate(position.x,position.y);
    stroke(51,255,153);
    fill(255,255,0);
    ellipse(0,0,10*size,10*size);
    fill(25,51,0);
    text("1Up",0,0);
    popMatrix();
  }
  
  void move()
  {
    if(dirX == 0)
    {
      position.add(MoveLEFT);
    }
    else
    {
      position.add(MoveRIGHT);
    }
    
    if(dirY == 0)
    {
      position.add(MoveUP);
    }
    else
    {
      position.add(MoveDOWN);
    }
  }
  
  void apply(Player player)
  {
    powerUp.play();
    
    if(player.lives < 3)
    {
      player.lives++;
      Objects.remove(this);
    }
    else if(player.health < 100)
    {
      player.health = 100;
      Objects.remove(this);
    }
    
    if(player.health == 100 && player.lives == 3)
    {
      fill(0,204,204);
      text("MAX LIVES",player.position.x,player.position.y);
    }
    
  }
  
  void die()
  {
    if(position.x > width+50*size || position.x < 0-50*size || position.y > height+50*size || position.y < 0-50*size)
    {
      Objects.remove(this);
    }
  }
}
