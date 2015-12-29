class Player extends GameObject
{
  //Fields for players
  float bombs;
  char up;
  char down;
  char left;
  char right;
  char shoot; 
  char bomb; 
  char drop;
  
  Player()
  {
    super(width/2, height/2);
  }
  
  Player(float newX, float newY, char up, char down, char left, char right, char shoot, char bomb, char drop)
  {
    super(newX, newY);
    
    //Read in again at some point
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.shoot = shoot;
    this.bomb = bomb;
    this. drop = drop;
    this.health = 100;
    this.lives = 3;
    this.bombs = 3;
  }
  
  void drawObject()
  {
    pushMatrix();
    translate(position.x, position.y);
    
    //Exhaust
    fill(100);
    stroke(100);
    rect(60,20,15,70);
    rect(-60,20,-15,70);
    rect(-5,50,10,10);
    
    fill(240);
    stroke(240);
    beginShape();
    //Right side of ship
    vertex(0,-20);
    vertex(10,-15);
    vertex(10,10);
    vertex(30,0);
    vertex(10,-100);
    vertex(20,-100);
    vertex(50,10);
    vertex(80,50);
    vertex(80,70);
    vertex(20,70);
    vertex(30,10);
    vertex(10,30);
    vertex(10,50);

    //Left side
    vertex(-10,50);
    vertex(-10,30);
    vertex(-30,10);
    vertex(-20,70);
    vertex(-80,70);
    vertex(-80,50);
    vertex(-50,10);
    vertex(-20,-100);
    vertex(-10,-100);
    vertex(-30,0);
    vertex(-10,10);
    vertex(-10,-15);
    endShape();
    
    fill(255,100,0);
    ellipse(0,0,10,20);
    popMatrix();
  }
  
  void guns()
  {
  }
  
  void move()
  {
    
  }
  
  void die()
  {
  }
}
