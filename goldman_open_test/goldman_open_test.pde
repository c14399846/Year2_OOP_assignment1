import java.util.*;


Table goldman;
Table american_intl_grp;
Table amazon;
Table microsoft;
Table bank_of_america;
Table coke;
Table pepsi;

void setup()
{
  size(500,500);
  background(0);
  
    
  
  goldman = loadTable("GOOG-NYSE_GS.csv","header");
  ArrayList<Float> goldman_close = new ArrayList<Float>();
  
  //println(goldman.getRowCount());
  //println(goldman.getColumnCount());
  //reads in fro start of close column in file (the fifth column)
  println(goldman.getFloat(0,4));
  
  
  for(int f = 0;f < goldman.getRowCount();f++)
  {
    //float stands for goldman close
    float gs_c = goldman.getFloat(f,4);
    goldman_close.add(gs_c);
  }
  
  float gs_max_price = Collections.max(goldman_close);
  
  println(gs_max_price);
  //println(goldman.getFloat(4171,4));
  
    
  
}