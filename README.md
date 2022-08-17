# BOMBSWEEPER
#### Video Demo: https://www.youtube.com/watch?v=1TngFVT_nG4&ab_channel=M3H4D
#### Description: 

##### There are 3 main files used in this program: 
1. main.lua
2. Board.lua
3. Tiles.lua

###### **main.lua**
This is the main file that is used to run the code. It has all the keyboard functions, mouse functions, a function that rounds a number to the nearest 16th (this is explained further) and has the object *board* of class Board.lua. Furthermore, all the different screens were made here aswell, screens such as the title screen or victory screen. The mouse function which was implimented here, has the bulk of code which manages the different point systems and how each tile is manipulated. 

###### **Board.lua**
This is a class I made which manages everything related to the board, so where the board is placed, how many flags are left, which value is given to each tile, and where each bomb is kept. Each *tile* on the board is an object of the class Tiles.lua, where each *tile* is stored in an aray called ***boardCords***.

A few functions to note from this file:
1. tileMapping(): It takes 2 values as parameters row and col, and then returns the number of bombs around the tile. This output is then used to give each tile a value
2. getBox(): It takes in 2 parameters i and j, which are generally x and y values inputted by the mouse. Using the value returned from this function the index of the array ***boardCords*** can be found and the relevant tile can then be manipulated.
3. bombAssigner(): This function bassicly places a set number of bombs randomly across the board.
4. freeSpaces(): This is a recursive function, and similar to *tileMapping()* it takes in row and col as parameters. This function reveals all the nearby tiles which have no value.

###### **Tiles.lua**
This is the class which controls everything related to a tile. So for example it shows where a tile should be displayed, whether the tile is a bomb or it has a flag on it, what picture should be used to display the value of that tile and whether or not the tile has been clicked already.

##### There are 2 folders which contain the pictures and sound effects used in the game:
1. Tiles
2. SFX

##### There are also 2 extra files that help with setting up the screen and classes:
1. push.lua
2. class.lua

###### **push.lua**
This is a file I found from the cs50 games track which is used to set the screen up to proper resolutions

###### **class.lua**
This is another file I found from the cs50 games track, and it is used to setup different classes and objects.

##### Some extra details on the project
- Since I am new to lua and love2d I wasn't sure what the best aproach was in designing the board. At first I made only 1 class which was for the board and using this class I would display everything and have most of the game logic in it, but after a little while things got too complicated for me to handle so I decided to think of new ways to apporach this problem. The solution as you might have read was to make another class and make several objects where each one of the objects corelated to 1 tile, all these objects were stored in 1 array called *boardCords*.

- Another problem I faced was that the pictures I was gonna use were 16x16 and since this was all new to me I couldnt really figure out, how if I click somewhere it would corelate to that tile, so instead of using a coordinate system that went in steps of 1, I used a system that went in steps of 16 using the function *round16()*. This way I could get accurate x and y values and all I had to do was pass them in the function *getBox()* and get the relevant tile
- I drew all of the tiles in Adobe Photoshop by myself, and got all the sound effects from bfxr. 
- There is also a notes file that I wrote for a general idea on how the game should work and what things were left for me to program.


