import org.gicentre.utils.spatial.*;    // For map projections.


// --------------------- Sketch-wide variables ----------------------

ArrayList<PVector>coords;    // Projected GPS coordinates.
PImage backgroundMap;        
PVector tlCorner,brCorner;   // Corners of map in WebMercator coordinates.
WebMercator proj;         

// ------------------------ Initialisation --------------------------

void setup(){
  size(600,600);
  smooth();
  readData();
}

// ------------------------ Processing draw -------------------------
void draw(){
  // Background map.
  //image(backgroundMap,0,0,746,379);
  
    // Projected GPS coordinates
  noFill();
  stroke(150,50,50,150);
  strokeWeight(5);
   
  beginShape();
  for (PVector coord : coords)
  {
    PVector scrCoord = geoToScreen(coord);
    point(scrCoord.x,scrCoord.y);  
  }
  endShape();
}


// ---------------------------- Utility functions -----------------------------
void readData(){
  
//  Table geoList;
//  geoList= new Table();
//  geoList.addColumn("lat");
//  geoList.addColumn("lng");
  
  WebMercator proj = new WebMercator();
  coords = new ArrayList<PVector>(); 
  
  Table geoTable = loadTable("siri.20130106.csv");
  for (TableRow row : geoTable.rows())  {
   String timestamp = row.getString(0);
   //if(timestamp.equals("1357430402000000")) {
     String line_id = row.getString(1);
     String congestion = row.getString(7);
     float lng = row.getFloat(8);
     float lat = row.getFloat(9);
     String delay = row.getString(10);
     coords.add(proj.transformCoords(new PVector(lng,lat)));
   //}
}
  
  // Store the WebMercator coordinates of the corner of the map.
  tlCorner = proj.transformCoords(new PVector(-6.615050, 53.606533));
  brCorner = proj.transformCoords(new PVector(-6.053150, 53.070415));
  
}
 
//Convert from WebMercator coordinates to screen coordinates.
PVector geoToScreen(PVector geo)
{
  return new PVector(map(geo.x,tlCorner.x,brCorner.x,0,600),
                     map(geo.y,tlCorner.y,brCorner.y,0,600));
}
