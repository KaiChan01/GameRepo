//Very small stars for the background
class Star extends GameObject
{
  //Fields
  boolean alive;
  float radius;
  color colour;
  
  Star(float x, float y)
  {
    super(x, y);
    //Make this relevate to screen size
    this.radius = random(2, 5);
    this.colour = color(random(10,200));
    this.alive = true;
  }
  
  void drawObject()
  {
    fill(colour);
    stroke(colour);
    ellipse(position.x,position.y,radius,radius);
  }
  
  void move()
  {
    position.add(MoveDOWN);
  }
  
  void die()
  {
    if(position.y > height)
   {
    stars.remove(this);
   }
  }
}
