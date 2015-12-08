//This funciton loads in data from all tables into their respective arraylists
class LoadIn
{
 float close;//closing stock price on the day
 float volume;//volume of stocks traded on the day
 String date;//date stocks are traded
 
 LoadIn(String gs_load)
 {
   //splits the dataset into seperate pieces
   String[] fields = gs_load.split(",");
  
   date = fields[0];
   close = Float.parseFloat(fields[4]);
   volume = Float.parseFloat(fields[5]);
 }//end LoadIn
}//end class