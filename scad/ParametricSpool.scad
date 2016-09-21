/**

    Parametric Spool
    by snho

**/

/** VARIABLES **/
// Flange diameter of the spool
FLANGE_DIAMETER = 50;
// Inside diameter of the spool        
INSIDE_DIAMETER = 10;
// Outside Rim Thickness        
FLANGE_THICKNESS = 5;
// Inside shaft wall thickness       
BARREL_THICKNESS = 5;
// Traverse Length       
TRAVERSE = 60;
// Shaft Connector Length        
CONNECTOR_LENGTH = 10;
// Clearance for glue adhesion and fit       
CONNECTOR_CLEARANCE = 1;
// Print Quality - Sides in a circle. Can result in non-circular shapes when the number of sides is small.       
SIDES = 100;
// Distance between models for printing male and female at the same time    
MODEL_DISPLACEMENT = 10;

/** MODULES **/

module outerRim() {
    linear_extrude(height = FLANGE_THICKNESS)
    difference() {
        // Outer shape
        circle(d = FLANGE_DIAMETER, $fn = SIDES);
        // Inner circle
        circle(d = INSIDE_DIAMETER, $fn = SIDES);
    }
}

module innerShaft() {
    linear_extrude(height = TRAVERSE)
    difference() {
        // Outer circle
        circle(d = INSIDE_DIAMETER + BARREL_THICKNESS, $fn = SIDES);
        //Inner circle
        circle(d = INSIDE_DIAMETER, $fn = SIDES);
    }
}

module innerShaftMale() {
    linear_extrude(height = (TRAVERSE / 2) - CONNECTOR_LENGTH)
    difference() {
        // Outer circle
        circle(d = INSIDE_DIAMETER + BARREL_THICKNESS, $fn = SIDES);
        //Inner circle
        circle(d = INSIDE_DIAMETER, $fn = SIDES);
    }
    translate([0, 0, (TRAVERSE / 2) - CONNECTOR_LENGTH])
    linear_extrude(height = CONNECTOR_LENGTH)
    difference() {
        circle(d = (INSIDE_DIAMETER + BARREL_THICKNESS / 2), $fn = SIDES);
        circle(d = (INSIDE_DIAMETER), $fn = SIDES);
    }
}

module innerShaftFemale() {
    linear_extrude(height = (TRAVERSE / 2) - CONNECTOR_LENGTH)
    difference() {
        // Outer circle
        circle(d = INSIDE_DIAMETER + BARREL_THICKNESS, $fn = SIDES);
        //Inner circle
        circle(d = INSIDE_DIAMETER, $fn = SIDES);
    }
    translate([0, 0, (TRAVERSE / 2) - CONNECTOR_LENGTH])
    linear_extrude(height = CONNECTOR_LENGTH)
    difference() {
        circle(d = (INSIDE_DIAMETER + BARREL_THICKNESS), $fn = SIDES);
        circle(d = (INSIDE_DIAMETER + BARREL_THICKNESS / 2), $fn = SIDES);
    }
}


/** Printer/Render Ready Model **/
outerRim();
translate([0, 0, FLANGE_THICKNESS])
innerShaftMale();
translate([FLANGE_DIAMETER + MODEL_DISPLACEMENT, 0, 0])
outerRim();
translate([FLANGE_DIAMETER + MODEL_DISPLACEMENT, 0, FLANGE_THICKNESS])
innerShaftFemale();
