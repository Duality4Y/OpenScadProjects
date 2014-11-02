/*
Author: Duality

I made this to allign leds, so I could precisely fix leds in a matrix.
first for making a single 8x8 led matrix. but later for making a led cube.

*/

//matrix width (like how many holes in a row)
matrix_width = 8;
//matrix height. together it makes a led matrix of 8x8 holes.
//if height = width = 8;
matrix_height = 8;
//led radius
led_r = 5; //radius for 5mm led
//matrix plate height.
plate_h = 2;

//spacing between leds/holes and offset from edge
spacing = 1;

module led_row(width)
{
	
	//calculate the x position for every led/hole circle.
	function calc_x(variable) = 
		(( 2*(variable*led_r)+variable*spacing)-led_r);
	
	//the same for the y.
	function calc_y(variable) = (led_r+spacing);
	
	//use a loop to place the holes one for one.
	for(i = [1:width])
	{
		translate([calc_x(i), calc_y(i), 0])
		cylinder(h = plate_h, r = led_r, $fn=100);
	}
}

led_row(matrix_width);

module led_col()
{
}
//for(i = [0:led_r+2:led_r*80])
//{
//	cube([i/2, i, i]);
//}