import org.gicentre.utils.spatial.*;    // For map projections.


// --------------------- Sketch-wide variables ----------------------

ArrayList<PVector>coords;    // Projected GPS coordinates.
PImage backgroundMap;        
PVector tlCorner,brCorner;   // Corners of map in WebMercator coordinates.
WebMercator proj;
StringList timelist;
String [] times;

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
  
  Table geoList;
  geoList= new Table();
  geoList.addColumn("lat");
  geoList.addColumn("lng");
  
  Table geoTable = loadTable("siri.20130106.csv");
  
  String [] times=geoTable.getStringColumn(0); //read all the time col in the geotable
  //all the unique values in the time col in the geotable, they are used as annimation
  StringList timelist = new StringList();

    
  
  
  
  
  for (TableRow row : geoTable.rows())  {
   String timestamp = row.getString(0);
   String line_id = row.getString(1);
   String congestion = row.getString(7);
   String lng = row.getString(8);
   String lat = row.getString(9);
   String delay = row.getString(10);
  
  if(line_id.equals("747")) {
    TableRow newRow = geoList.addRow();
    newRow.setString("lat", lat);
    newRow.setString("lng", lng);
    }
  }
 
  
//  Read the point data.
//  String[] geoCoords = loadStrings("siri.20130106.csv");
   
  WebMercator proj = new WebMercator();
  coords = new ArrayList<PVector>();  
  
  for (TableRow row : geoList.rows())
  {
    float lng = row.getFloat(1);
    float lat = row.getFloat(0);
    coords.add(proj.transformCoords(new PVector(lng,lat)));
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
