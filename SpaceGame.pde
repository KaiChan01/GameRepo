/* Assignment 2 
   Author: Ka Yu Chan
   Date: 26/12/15
*/
int spawn;
int tempFrame;
int CurFrame;

//Loading some font
PFont spaceFont;

ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<GameObject> Objects = new ArrayList<GameObject>();

int newStars;
boolean start;
boolean animation;

//used in relation to screen size
float size;

boolean[] input = new boolean[512];

void setup()
{
  size(900,510);
  background(0);
  spaceFont = createFont("airstrike.ttf", width/20);
  start = false;
  animation = false;
  
  //size is equal to 5
  size = (width-height) / 168;
  
  //Making initial Stars
  for(int i = 0; i < 100; i++)
  {
    Star star = new Star((random(0,width)), (random(0,height)));
    stars.add(star);
  }
  
  //Making player test
  GameObject one = new Player(width/2,height+(30*size),'W','S','A','D','J','K','L');
  Objects.add(one);
}

void draw()
{
  background(0);
  
  for(int i = 0; i < stars.size(); i++)
  {
    Star StarMethods = stars.get(i);
    
    StarMethods.drawObject();
    StarMethods.move();
    StarMethods.die();
  }
  
  //Keep drawing stars
  newStars = int(random(0,6));
  if(newStars == 5)
  {
     Star star = new Star((random(0,width)), 0);
     stars.add(star);
  }
  
  //Moving other objects
  
  
  if(start == false)
  {
    menu();
  }
  else
  {
    if(animation == false)
    {
      //Enemies spawn
      spawn = int(random(0,10));
      if(spawn == 1)
      {
        //Need to figure this out
        tempFrame = frameCount;
         if(frameCount/tempFrame == 1)
         {
           GameObject a = new Enemy(random(100,width-100), 0);
           Objects.add(a);
         }
      }
    }
    
    for(int i = 0; i < Objects.size(); i++)
    {
      GameObject ObjectsMethods = Objects.get(i);
    
      ObjectsMethods.drawObject();
      ObjectsMethods.move();
      ObjectsMethods.die();
      
      if((Objects.get(i)) instanceof Player)
      {
        Player a = (Player) Objects.get(i);
        a.guns();
        if(animation == true)
        {
          a.startAnimation();
        }
      }
    }
  }
}

void menu()
{
  textAlign(CENTER);
  textFont(spaceFont);
  fill(100,100,220);
  stroke(150,150,20);
  //Will change name
  text("SPACE BATTLE",width/2,height/10);
  
  if(  mouseX > width/3 
    && mouseX < width-(width/3) 
    && mouseY > (7*(height/10)+32) 
    && mouseY < (9*height/10)+32)
  {
    fill(0,255,255);
    
    if(mousePressed == true)
    {
      start = true;
      animation= true;
    }
  }
    text("Start", width/2, 9*(height/10));
}

void keyPressed()
{
  input[keyCode] = true;
}

void keyReleased()
{
  input[keyCode] = false;
}
