class Player extends GameObject
{
  //Fields for players
  float bombs;
  
  Player()
  {
    super(width/2, height/2);
  }
  
  Player(float newX, float newY)
  {
    super(newX, newY);
    
    //Read in again at some point
    this.health = 100;
    this.lives = 3;
    this.bombs = 3;
    this.ammo = 0;
  }
  
  void drawObject()
  {
    pushMatrix();
    translate(position.x, position.y);
    stroke(255,255,0);
    fill(20,100,100);
    beginShape();
    //Right side
    vertex(0,-100);
    vertex(30,0);
    vertex(100,50);
    vertex(80,70);
    vertex(20,70);
    vertex(15,90);
    vertex(0,90);
    
    //Left side
    vertex(-15,90);
    vertex(-20,70);
    vertex(-80,70);
    vertex(-100,50);
    vertex(-30,0);
    vertex(0,-100);
    endShape();
    
    stroke(100);
    fill(100);
    //Cockpit
    ellipse(0,-40,20,50);
    
    //Shine
    stroke(100);
    fill(150);
    ellipse(5,-50,5,10);
    
    popMatrix();
  }
  
  void move()
  {
    position.add(up);
  }
  
  void die()
  {
  }
}
