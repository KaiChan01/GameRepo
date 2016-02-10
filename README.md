# GameRepo
For Christmas Assignment

<b>Controls<b>
W,A,S,D - Move<br>
J - Shoot<br>
k - Charge cannon<br>

<b>Description</b>
For this assignment I decided to make a bullethell game set in space.
The player controls a spaceship and objective in this game is to destory as many enemies as possible to score points.
The player starts with 3 lives, a basic gun and chargable cannon. Power ups such as ammo for advance weapon and recover lives can be picked up.
If the player's score is greater than one of the top 5 highscores which are saved in a CSV file, it will replace one of the current highscore.


<b>Enemies</b>
There are two type of basic enemies in the game and one type of greater enemy.

<b>Enemy type 1:</b> 
1) Cannot shoot bullets but can inflict damage if the player collides with them<br>
2) Worth 200 points


<b>Enemy type 2:</b>

1) Will spray bullets and move across the screen<br>
2) can also inflict damage if player collides with them<br>
3) Worth 500 points


Greater enemy:
1) Can shoot bullets in 6 different spiraling pattern<br>
2) Can cause an area to explode<br>
3) Worth 1000 points<br>


For this assignment I drew all the objects within processing, I have include Abstract classes, classes and inheritance to create the objects.
I used plymorphism and interfaces to check collision between objects