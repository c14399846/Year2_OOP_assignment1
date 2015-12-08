void drawLineGraph(ArrayList<LoadIn> stocks_close, color graphCol)
{
  
  drawAxis(16, 20, border);   
  
  float windowRange = (initWidth - (border * 2.0f));
  float dataRange = stock_max;
  
  //colour of line and text for that stock/dataset
  stroke(graphCol);
  fill(graphCol);  
  
  for (int i = stocks_close.size() - 2 ; i >=0 ; i --){
    float x1 = map(i + 1, 0, stocks_close.size(), border + windowRange, border);
    float x2 = map(i, 0, stocks_close.size(), border + windowRange, border);
    float y1 = map(stocks_close.get(i + 1).close, 0, dataRange, initHeight - border, (initHeight - border) - windowRange);
    float y2 = map(stocks_close.get(i).close, 0, dataRange, initHeight - border, (initHeight - border) - windowRange); 
    
    //line graph
    line(x1, y1, x2, y2);
  }//end for
}//end drawLineGraph


void drawAxis( int horizIntervals, int verticalIntervals, float border)
{
  stroke(255,255,255);
  fill(255,255,255);
  
  //Draw the horizontal azis  
  line(border, initHeight - border, initWidth - border, initHeight - border);
  
  float windowRange = (initWidth - (border * 2.0f));  
  float tickSize = border * 0.1f;
      
  for (int i = 0 ; i <= horizIntervals ; i ++){   
   //Draw the ticks on x axis
   float x = map(i, 0, horizIntervals, border, border + windowRange);
   line(x, initHeight - (border - tickSize), x, (initHeight - border));    
    
   // x axis (years)
   textAlign(CENTER, CENTER);   
   float textY = initHeight - (border * 0.5f); 
   text((int) map(i, 0, horizIntervals, 1999, 2016), x, textY);
  }//end for
  
  
  //Draw the vertical axis
  line(border, border , border, initHeight - border);
  
  for (int i = 0 ; i <= verticalIntervals ; i ++){
    float y = map(i, 0, verticalIntervals, initHeight - border,  border);
    line(border - tickSize, y, border, y); //ticks y-axis
    float hAxisLabel = map(i, 0, verticalIntervals, 0, stock_max);
        
    //Stock price y-axis
    textAlign(RIGHT, CENTER);  
    text((int)hAxisLabel, border - (tickSize * 2.0f), y);
  }//end for
}//end drawAxis

void drawStockPrice(ArrayList<LoadIn> stocks_close,int stockWidth,int stockHeight,String stockName)
{
  if (mouseX >= border && mouseX <= initWidth - border){
    
    //draws the vertical line and the stock price at the location of the line
    line(mouseX, border, mouseX, initHeight - border);
    int i = (int)map(mouseX, border, initWidth - border, stocks_close.size() - 1, 0);
    
    fill(white);//makes date text white
    text("Date: " + stocks_close.get(i).date,initWidth/2,initHeight-900);
    fill(holdCol);//changes stock price text back to its corresponding stock colour
    text(stockName + " Price : " + stocks_close.get(i).close, stockWidth, stockHeight);
  }//end if
}//end drawStockPrice

void stockText(String name)
{
  if(largest_stock == name){
    text("Largest Stock company (Price):  " + name,initWidth/2 + 70,initHeight-890); 
  }//end if
}//end stockText