JellyLua
========

JellyLua is a Lua framework for working with the excellent 
[pbLua](http://hempeldesigngroup.com/lego/pblua/) NXT firmware.

Please note that JellyLua is still in an early alpha stage, and
anything could change between versions.

Instructions
------------

JellyLua comprises two parts: The library and the `jelly` tool.

### The `jelly` tool

`jelly` is used to upload your script to the NXT. You can connect your
NXT brick to your computer with the USB cable and type:

    jelly <your script> <your serial port device>

for example:

    jelly script.lua /dev/ttyACM0

Jelly will launch and tranfer your script to the brick, at which point
your script will start to run. You can then disconnect the brick and
use your robot, or leave it connected if you need to display any output
your script prints.

### The library

The library consists of a simple event loop and a few convenience
functions. To use it, all you need to do is implement the callback
functions detailed below, and you may use the convenience functions
without any additional setup.

### Callback functions

The callback functions are:

`OnButtonPress(button_code)`

This function is called whenever a button is pressed on the NXT brick.
The argument is the code of the button pressed.

`OnButtonRelease(button_code)`

This function is called whenever a button is released on the NXT brick.
The argument is the code of the button released.

`MainLoop()`

This function implements the main functionality of your program. It is
run once per loop iteration, and will block the callbacks until it
returns.

`Initialize()`

This allows for code initialization. It's called right before the event
loop starts running.

### Convenience functions

The convenience functions defined are:

`Print(text)`

Scroll the NXT LCD by one line and print the given text.
