//new
Table bustable;
bustable=loadTable("/Users/ben/Downloads/siri/siri.20130125.csv");
StringList timelist;
String [] times=bustable.getStringColumn(0);
timelist = new StringList();

//get all the unique values of different timestamps 
for(int i=0; i <times.length-1; i++) {
  if(!(times[i].equals(times[i+1]))){
    timelist.append(times[i]);
  }
}

println(timelist);


// print all the LineID with groupped by the time stamps
//for(Sting timeStamp: timelist)
//  for(TableRow row : bustable.matchRows("1359072001000000", 0)) {
//      println(row.getString(1));
//      lng=row.getString(8);
//      
//    }
