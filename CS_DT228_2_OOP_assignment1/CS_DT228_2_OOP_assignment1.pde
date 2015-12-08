import java.util.*;//used for setSize function
import controlP5.*;

int initHeight = 1000;
int initWidth = 1000;

float border = initWidth * 0.2f;
float piemax;
float maxTrade = 1;
float stock_max = 2;

//colours for each dataset
color gs_col = color(255,0,0);
color amzn_col = color(255,128,0);
color aig_col = color(0,0,255);
color msft_col = color(100,255,0);
color boa_col = color(0,204,255);
color coke_col = color(102,0,204);
color pepsi_col = color(160,160,160);
color white = color(255,255,255);
color holdCol;//holds a stocks colour

//names for each dataset
String gs_name = "Goldman";
String amzn_name = "Amazon";
String aig_name = "AIG";
String msft_name = "Microsoft";
String boa_name = "Bank of America";
String coke_name = "Coke";
String pepsi_name = "Pepsi";
String largest_stock;

//menu system
boolean menu = true;
boolean lineGraph = false;
boolean pieChart = false;
boolean doughnut = false;

//linegraphs
boolean gs_bool = false;
boolean amzn_bool = false;
boolean aig_bool = false;
boolean msft_bool = false;
boolean boa_bool = false;
boolean coke_bool = false;
boolean pepsi_bool = false;

//Araylists to hold data loaded in
ArrayList<LoadIn> goldman_close = new ArrayList<LoadIn>();
ArrayList<LoadIn> amzn_close = new ArrayList<LoadIn>(); 
ArrayList<LoadIn> AIG_close = new ArrayList<LoadIn>();
ArrayList<LoadIn> MSFT_close = new ArrayList<LoadIn>();
ArrayList<LoadIn> BOA_close = new ArrayList<LoadIn>();
ArrayList<LoadIn> coke_close = new ArrayList<LoadIn>();
ArrayList<LoadIn> pepsi_close = new ArrayList<LoadIn>();
ArrayList<LoadIn> colList = new ArrayList<LoadIn>();

//classes
ControlP5 controlP5;

//Main menu buttons
controlP5.Button menu_button;
controlP5.Button line_button;
controlP5.Button pie_button;

//Linegraph buttons
controlP5.Button gs_button;
controlP5.Button amzn_button;
controlP5.Button aig_button;
controlP5.Button msft_button;
controlP5.Button boa_button;
controlP5.Button coke_button;
controlP5.Button pepsi_button;


void setup()
{
  surface.setSize(initHeight,initWidth);
  controlP5 = new ControlP5(this); //button class

  //loads in data from all the datasets
  loadData();
  
  //menu buttons
  line_button = controlP5.addButton("LineGraph" ,1,initWidth/2,initHeight/2,100,75);
  pie_button = controlP5.addButton("Pie Chart",1, initWidth/2,initHeight/2 - 150,100,75); 
  menu_button = controlP5.addButton("Main Menu", 1, 0,0,75,50);
  
  //line graph buttons
  amzn_button = controlP5.addButton("Amazon", 1, 75,0, 75, 50);
  aig_button = controlP5.addButton("AIG", 1, 150,0, 75, 50);
  msft_button = controlP5.addButton("Microsoft", 1, 0,50, 75, 50);
  boa_button = controlP5.addButton("Bank of America", 1, 75, 50, 75, 50);
  coke_button = controlP5.addButton("Coke", 1, 150,50, 75, 50);
  pepsi_button = controlP5.addButton("Pepsi", 1, 0,100, 75, 50);
  gs_button = controlP5.addButton("Goldman", 1, 75,100,75,50);  
}


void loadData()
{
  //load data from tables
  String[] goldman = loadStrings("GOOG-NYSE_GS.csv");
  String [] amazon = loadStrings("GOOG-NASDAQ_AMZN.csv");
  String [] american_intl_grp = loadStrings("GOOG-NYSE_AIG.csv");
  String [] microsoft = loadStrings("GOOG-NASDAQ_MSFT_1999.csv");
  String [] bank_of_america = loadStrings("GOOG-NYSE_BAC.csv");
  String [] coke = loadStrings("GOOG-NYSE_KO.csv");
  String [] pepsi = loadStrings("GOOG-NYSE_PEP.csv");
  
  
  //datasets loaded in
  for(String gs_load: goldman){
    LoadIn tableLoad = new LoadIn(gs_load); 
    goldman_close.add(tableLoad);
  }
  
  for(String gs_load: amazon){
    LoadIn tableLoad = new LoadIn(gs_load); 
    amzn_close.add(tableLoad);
  }
  
  for(String gs_load: american_intl_grp){
    LoadIn tableLoad = new LoadIn(gs_load); 
    AIG_close.add(tableLoad);
  }
  
  for(String gs_load: microsoft){
    LoadIn tableLoad = new LoadIn(gs_load); 
    MSFT_close.add(tableLoad);
  }
  
  for(String gs_load: bank_of_america){
    LoadIn tableLoad = new LoadIn(gs_load); 
    BOA_close.add(tableLoad);
  }
  
  for(String gs_load: coke){
    LoadIn tableLoad = new LoadIn(gs_load); 
    coke_close.add(tableLoad);
  }
  
  for(String gs_load: pepsi){
    LoadIn tableLoad = new LoadIn(gs_load); 
    pepsi_close.add(tableLoad);
  }  
}//end loadData


//Calculates the max stock value
void calcMax(ArrayList<LoadIn> stocks_close,String name)
{
  for (int i = 0;i<stocks_close.size();i++){
    if (stocks_close.get(i).close > stock_max){
      stock_max = stocks_close.get(i).close;
      largest_stock = name;
    }//end if
  }//end for
}//end calcMax


//used to calc max trade on a day (close price * volume)
float calcMaxTrade(ArrayList<LoadIn> stocks_close)
{
  float mill = 1000000.00f;
  for (int i = 0;i<stocks_close.size();i++){
    if (((stocks_close.get(i).close * stocks_close.get(i).volume)/mill) > maxTrade){
      piemax = ((stocks_close.get(i).close * stocks_close.get(i).volume)/mill);
    }//end if
  }//end for
  return piemax;
}//end calcMaxTrade


//Function that draws the stocks graph if the variable is true
void stockDraw()
{  
  background(0);
  
  //show the stock buttons, will display chosen graph if clicked
  gs_button.show();
  amzn_button.show();
  aig_button.show();
  msft_button.show();
  boa_button.show();
  coke_button.show();
  pepsi_button.show();
  menu_button.show();
  
  /*
    The line graph drawn will depend on the largest close stock,
    its y-axis will increase or decrease based on this stock
  */
  
  //if button is clicked(true), show graphs  
  if(aig_bool){
    calcMax(AIG_close,aig_name);
    drawLineGraph(AIG_close,aig_col);
    holdCol = aig_col;
    drawStockPrice(AIG_close,800,125,aig_name);
    stockText(aig_name);//displays largest stock 
  }
  
  if(amzn_bool){
    calcMax(amzn_close,amzn_name);
    drawLineGraph(amzn_close,amzn_col);
    holdCol = amzn_col;
    drawStockPrice(amzn_close,950,100,amzn_name);
    stockText(amzn_name);
  }
  
  if(gs_bool){
    calcMax(goldman_close,gs_name);
    drawLineGraph(goldman_close,gs_col);
    holdCol = gs_col;
    drawStockPrice(goldman_close,800,75,gs_name); 
    stockText(gs_name);  
  }
  
  if(pepsi_bool){
    calcMax(pepsi_close,pepsi_name);
    drawLineGraph(pepsi_close,pepsi_col);
    holdCol = pepsi_col;
    drawStockPrice(pepsi_close,950,150,pepsi_name);
    stockText(pepsi_name);
  }
  
  if(msft_bool){
    calcMax(MSFT_close,msft_name);
    drawLineGraph(MSFT_close,msft_col);
    holdCol = msft_col;
    drawStockPrice(MSFT_close,950,75,msft_name);
    stockText(msft_name);
  }
  
  if(boa_bool){
    calcMax(BOA_close,boa_name);
    drawLineGraph(BOA_close,boa_col);
    holdCol = boa_col;
    drawStockPrice(BOA_close,800,100,boa_name);
    stockText(boa_name);
  }
  
  if(coke_bool){
    calcMax(coke_close,coke_name);
    drawLineGraph(coke_close,coke_col);
    holdCol = coke_col;
    drawStockPrice(coke_close,950,125,coke_name);
    stockText(coke_name);
  }
  
  //resets max after it's run
  stock_max = 2;
  largest_stock = " ";
}

void pieChart()
{
  menu_button.show();
  
  float radius = initWidth / 3;//size of piechart
  float totalMax = 0.0f;
  
  //max traded amount per dataset/stock
  float gs_trade = calcMaxTrade(goldman_close);
  float amzn_trade = calcMaxTrade(amzn_close); 
  float aig_trade = calcMaxTrade(AIG_close);
  float msft_trade = calcMaxTrade(MSFT_close);
  float boa_trade = calcMaxTrade(BOA_close);
  float coke_trade = calcMaxTrade(coke_close);
  float pepsi_trade = calcMaxTrade(pepsi_close);
  
  //contains the max traded amount on the day, the stocks colour and name
  float pieSet[] = {gs_trade,amzn_trade,aig_trade,msft_trade,boa_trade,coke_trade,pepsi_trade};
  String [] pieNames = {gs_name,amzn_name,aig_name,msft_name,boa_name,coke_name,pepsi_name}; 
  color pieColors[] = {gs_col,amzn_col,aig_col,msft_col,boa_col,coke_col,pepsi_col};

  //calculates the total max trades,used later to map
  for(float f:pieSet){
    totalMax += f;
  }
  
  
  float toMouseX = mouseX - radius;
  float toMouseY = mouseY - radius;  
  float angle = atan2(toMouseY, toMouseX); 
  
  //maps position of mouse to the piechart (circle)
  if (angle < 0){
    angle = map(angle, -PI, 0, PI, TWO_PI);
  }
  
  float last = 0;
  float sum = 0;
  
  
  for(int i = 0 ; i < pieSet.length ; i ++){
    sum += pieSet[i];
    
    float current = map(sum, 0, totalMax, 0, TWO_PI);

    stroke(pieColors[i]);
    fill(pieColors[i]);
    
    float r = radius;
    
    // If the mouse angle is inside the pie segment display its max trade in millions of US dollars
    if (angle > last && angle < current){
      r = radius * 1.5f;
      text(pieNames[i] + " Max Trade Price " + nf(pieSet[i],1,2) + " ($ Millions)",initWidth-300,initHeight-900);
    }//end if

    //draws the piechart
    arc(radius,radius,r,r,last,current);
    
    //used to see if the mouse is still inside the piechart
    last = current;     
  }//end for
  
  
}

void menu()
{
  //hide all buttons,except menu buttons, at start of program
  gs_button.hide();
  amzn_button.hide();
  aig_button.hide();
  msft_button.hide();
  boa_button.hide();
  coke_button.hide();
  pepsi_button.hide();
  menu_button.hide();
  
  //shows menu buttons
  line_button.show();
  pie_button.show();
    
  //visual data is hidden
  lineGraph = false;
  pieChart = false;
    
  //line grpahs are hidden
  gs_bool = false;
  amzn_bool = false;
  aig_bool = false;
  msft_bool = false;
  boa_bool = false;
  coke_bool = false;
  pepsi_bool = false;
}


void draw()
{  
  //menu system
  if(menu == true){
    background(0);
    menu(); 
  }
 
  //linegraph
  if(lineGraph == true){  
    background(0);
    stockDraw();
  }
  
  //piechart
  if(pieChart == true){
     background(0);
   //code for bargraph
   pieChart();  
  }//end if
}//end draw


//Function that changes the bool value of a variable if their corresponding button is pressed
//It is the controlP5 button system
void controlEvent(ControlEvent buttonPressed)
{
  if(buttonPressed.controller().getName().equals(gs_name)){
    gs_bool = !gs_bool; 
  }
  
  if(buttonPressed.controller().getName().equals(amzn_name)){
    amzn_bool = !amzn_bool; 
  }
  
  if(buttonPressed.controller().getName().equals(aig_name)){
    aig_bool = !aig_bool; 
  }
  
  if(buttonPressed.controller().getName().equals(msft_name)){
    msft_bool = !msft_bool; 
  }
  
  if(buttonPressed.controller().getName().equals(boa_name)){
    boa_bool = !boa_bool; 
  }
  
  if(buttonPressed.controller().getName().equals(coke_name)){
    coke_bool = !coke_bool; 
  }
  
  if(buttonPressed.controller().getName().equals(pepsi_name)){
    pepsi_bool = !pepsi_bool; 
  }
  
  //if click on main menu, resets the graphs
  if(buttonPressed.controller().getName().equals("Main Menu")){
    menu = true;
  }
  
  //sets up for linegraph
  if(buttonPressed.controller().getName().equals("LineGraph")){
    line_button.hide();
    pie_button.hide();
    
    menu = false;
    lineGraph = true;
  }
  
  //sets up for piechart
  if(buttonPressed.controller().getName().equals("Pie Chart")){
    line_button.hide();
    pie_button.hide();
    
    menu = false;
    pieChart = true;
  }//end if
}//end controlEvent