# roguelikedev-does-the-complete-roguelike-tutorial-2018

This is an entry in **Haxe**, using **HaxeFlixel** for input and output, in order to target both web and the desktop platforms. 

Unfortunately Haxe doesn't have cross-compiling yet, so if you are on Linux or OSX, you'll have to compile yourself (*lime build /platform/*)

## Week 1

Setting up is as easy as following the HaxeFlixel tutorial at http://haxeflixel.com/documentation/getting-started/

## Week 2

We're already doing graphics, and isometric graphics at that. Check out https://gamedevelopment.tutsplus.com/tutorials/creating-isometric-worlds-primer-for-game-developers-updated--cms-28392?_ga=2.20302904.14685188.1530446365-1060515045.1508064120 for the math behind the isometry.

The map is dead simple because the HaxeFlixel window is very small at default settings. Need to figure out a camera first before using a classic BSP map.

Haxe doesn't seem to have global functions, and it definitely doesn't have top-level functions (everything has to be in a class), so there is a tiny bit of code repetition so far.

## Week 3

Moved the isometric map rendering code to a separate class and used FlxGroup to ensure that the map gets drawn before the player.

The FOV is recursive shadowcasting, ported from Java (SquidLib) to Haxe. This algorithm, according to all sources, is easiest to understand and implement, but it's downside is the lack of symmetry. For tutorial purposes, it's however good enough.

Due to HTML5 WebGL errors when tinting sprites, if you are using the sources, you need to use *lime build html5 -Dcanvas* to force canvas rendering. Other targets work fine.

## Week 4

The UI flickers when you move because in HaxeFlixel, everything is drawn in world space. Need to figure out how to avoid that flickering, though.
