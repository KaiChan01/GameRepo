# GameRepo
For Christmas Assignment

For this assignment I decided to make a bullethell game set in space.
The player controls a spaceship and objective in this game is to destory as many enemies as possible to score points.
The player starts with 3 lives, a basic gun and chargable cannon. Power ups such as ammo for advance weapon and recover lives can be picked up.
If the player's score is greater than one of the top 5 highscores which are saved in a CSV file, it will replace one of the current highscore.

There are two type of basic enemies in the game and one type of greater enemy.

Enemy type 1: 

1) Cannot shoot bullets but can inflict damage if the player collides with them.

2) Worth 200 points


Enemy type 2:

1) Will spray bullets and move across the screen

2) can also inflict damage if player collides with them

3) Worth 500 points


Greater enemy:

1) Can shoot bullets in 6 different spiraling pattern

2) Can cause an area to explode

3) Worth 1000 points


For this assignment I drew all the objects within processing, I have include Abstract classes, classes and inheritance to create the objects.
I used plymorphism and interfaces to check collision between objects