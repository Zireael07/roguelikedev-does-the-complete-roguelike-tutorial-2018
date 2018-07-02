# roguelikedev-does-the-complete-roguelike-tutorial-2018

This is an entry in **Haxe**, using **HaxeFlixel** for input and output, in order to target both web and the desktop platforms. 

Unfortunately Haxe doesn't have cross-compiling yet, so if you are on Linux or OSX, you'll have to compile yourself (*lime build /platform/*)

## Week 1

Setting up is as easy as following the HaxeFlixel tutorial at http://haxeflixel.com/documentation/getting-started/

## Week 2

We're already doing graphics, and isometric graphics at that. Check out https://gamedevelopment.tutsplus.com/tutorials/creating-isometric-worlds-primer-for-game-developers-updated--cms-28392?_ga=2.20302904.14685188.1530446365-1060515045.1508064120 for the math behind the isometry.

The map is dead simple because the HaxeFlixel window is very small at default settings. Need to figure out a camera first before using a classic BSP map.

Haxe doesn't seem to have global functions, and it definitely doesn't have top-level functions (everything has to be in a class), so there is a tiny bit of code repetition so far.
