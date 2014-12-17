/*
Author: Duality

This code is to create a hole matrix. for what ever you need.

*/

//matrix width (like how many holes in a row)
matrix_width = 5;
//matrix height. (and how many rows)
//together it makes a led matrix of 8x8 holes.
//if height = width = 8;
matrix_height = 8;
//led diameter
led_d = 5; //diameter for 5mm led
//matrix thickness.
matrix_thickness = 2;

//spacing between leds/holes and offset from edge's
spacing = 1;
//hole resolution
$fn=40;

module circle_matrix(width, height, hole_d)
{
	//calculate the x position for every led/hole circle.
	function calc_x(variable) = 
		( ( (variable*hole_d)+variable*spacing)-hole_d/2);
	//calculate the y position for ever led/hole circle.
	function calc_y(variable) = 
    	( ( (variable*hole_d)+variable*spacing)-hole_d/2);
	for(y = [0:height])
	{
		for(x = [0:width])
		{
			translate([calc_x(x), calc_y(y), 0])
			circle(r=hole_d/2);
		}
	}
}

module hole_matrix(width, height, hole_d)
{
	//calculate the with of the surface to extrude the holes from
	function calc_surface_width() =
		( width*hole_d+(width*spacing)+spacing);
	//also for the height of that surface.
	function calc_surface_height() =
		( height*hole_d+(height*spacing)+spacing);
	difference()
	{
		square([calc_surface_width(), calc_surface_height()]);
		circle_matrix(width, height, hole_d);
	}
}

//led_matrix creates a sheet with holes. and with linear_extrude() we give it
//the desired thickness.
linear_extrude(height=matrix_thickness)
hole_matrix(matrix_width, matrix_height, led_d);
