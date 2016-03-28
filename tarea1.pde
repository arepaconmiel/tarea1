import java.util.ArrayList;

Panel panel;

void setup() {
  size(440,500);
  panel = newPanel();
  RadioButtonGroup g = new RadioButtonGroup();

  

  panel.add(
    newVBox().position(0,0).size(440,500)
    .add(newHBox()
      .add(newTextField().columns(6).value("0").id("pantalla").colorespecifico(#8897A0).colorletra(#FCFEFF))
    )
    .add(newHBox()
      .add(newButton("C").id("C"))
      .add(newButton("+/-").id("masmenos"))
      .add(newButton("%").id("porcentaje"))
      .add(newButton("/").id("dividir").colorespecifico(#F59A2A).colorletra(#FCFEFF))
    )
    .add(newHBox()
      .add(newButton("7").id("7"))
      .add(newButton("8").id("8"))
      .add(newButton("9").id("9"))
      .add(newButton("X").id("multiplicar").colorespecifico(#F59A2A).colorletra(#FCFEFF))
    )
    .add(newHBox()
      .add(newButton("4").id("4"))
      .add(newButton("5").id("5"))
      .add(newButton("6").id("6"))
      .add(newButton("-").id("menos").colorespecifico(#F59A2A).colorletra(#FCFEFF))
    )
    .add(newHBox()
      .add(newButton("1").id("1"))
      .add(newButton("2").id("2"))
      .add(newButton("3").id("3"))
      .add(newButton("+").id("mas").colorespecifico(#F59A2A).colorletra(#FCFEFF))
    )
    .add(newHBox()
      .add(newButton("0").id("0").width(216))
      .add(newButton(",").id("coma"))
      .add(newButton("=").id("igual").colorespecifico(#F59A2A).colorletra(#FCFEFF))
    )
  );
  panel.update();
}

void draw() {
  background(255);
  panel.draw();
}

void mousePressed() {
  panel.mouseDown(mouseX,mouseY,new Click());
}

void mouseReleased() {
  panel.mouseUp(mouseX,mouseY,null);
}

void keyPressed() {
  panel.keyStroke(key,keyCode,null);
}

class Click extends Action {
  void run(Graphic g) {
    Control c = (Control)g;
    if (c.id()=="0") {
      printPanel("0");
    }
    if (c.id()=="1") {
      printPanel("1");
    }
    if (c.id()=="2") {
      printPanel("2");
    }
    if (c.id()=="3") {
      printPanel("3");
    }
    if (c.id()=="4") {
      printPanel("4");
    }
    if (c.id()=="5") {
      printPanel("5");
    }
    if (c.id()=="6") {
      printPanel("6");
    }
    if (c.id()=="7") {
      printPanel("7");
    }
    if (c.id()=="8") {
      printPanel("8");
    }
    if (c.id()=="9") {
      printPanel("9");
    }
    if (c.id()=="mas") {
      printPanel("+");
    }
    if (c.id()=="menos") {
      printPanel("-");
    }
    if (c.id()=="dividir") {
      printPanel("/");
    }
    if (c.id()=="multiplicar") {
      printPanel("*");
    }
    if (c.id()=="igual") {
      printResult();
    }
    if (c.id()=="coma") {
      printPanel(".");
    }
    if (c.id()=="C") {
      printPanel("C");
    }
    if (c.id()=="masmenos") {
      printMasMenos();
    }
    if (c.id()=="porcentaje") {
      printPorcentaje();
    }
      
  }
  
  void printPanel(String s) {
    Control pantalla = (Control)panel.getById("pantalla");
    String val = pantalla.value().toString();
    
    if(s =="C"){
      pantalla.value("0");
    }else{
      if(pantalla.value() == "0"){
        if(s != "*" && s != "/" && s != "+" && s != "-"){
          pantalla.value(s);  
        }else{
          pantalla.value(pantalla.value() + ""+ s);
        }
      }else{ //basico
      
        if(val.contains("+") || val.contains("-") || val.contains("/") || val.contains("*")){ //hay una operacion en pantalla por resolver
          if(s == "*" || s == "/" || s == "+" || s == "-"){ //quiere otra operacion
            if(val.endsWith("*") == false && val.endsWith("-")== false && val.endsWith("+")== false && val.endsWith("/")== false){ 
              
              printResult();
              val = pantalla.value().toString();
              pantalla.value(val + s);  
            }
            
          }else{ // es un numero
 
            pantalla.value(pantalla.value() + ""+ s);  
          }
        }else{
          String mostrar = pantalla.value() + ""+ s;
          pantalla.value(mostrar);
        }
      }
    }
    panel.update();
    
  }
  
  
   void printPorcentaje() {    //vamos por la idea de que EL segundo numero tome esta forma (-3)
     
    boolean bandera = true;
    Control pantalla = (Control)panel.getById("pantalla");
    String val = pantalla.value().toString();
    float y;
    String r;
    String[] ss;
     if(val.contains("+") == false && val.contains("-") == false && val.contains("/") == false && val.contains("*")== false){
       pantalla.value("0");
     }
     if(val.endsWith("*") == false && val.endsWith("-")== false && val.endsWith("+")== false && val.endsWith("/")== false){ 
     if(val.contains("+") && bandera){
      ss =val.split("\\+");
      if(ss[1].contains(")")){
          ss[1] = ss[1].replace("(", "");
          ss[1] = ss[1].replace(")", "");
        }
      y = Float.parseFloat(ss[1]);
      r = String.valueOf(y/100);
      if(y <0){
        pantalla.value(ss[0]+"+("+r+")");
      }else{
        pantalla.value(ss[0]+"+"+r);
      }
      bandera =false;
    }
    
    if(val.contains("/")&& bandera){
      ss =val.split("\\/");
      if(ss[1].contains(")")){
          ss[1] = ss[1].replace("(", "");
          ss[1] = ss[1].replace(")", "");
        }
      y = Float.parseFloat(ss[1]);
      r = String.valueOf(y/100);
      if(y <0){
        pantalla.value(ss[0]+"/("+r+")");
      }else{
        pantalla.value(ss[0]+"/"+r);
      }
      bandera =false;
    }
    if(val.contains("*")&& bandera){
      ss =val.split("\\*");
      if(ss[1].contains(")")){
          ss[1] = ss[1].replace("(", "");
          ss[1] = ss[1].replace(")", "");
        }
      y = Float.parseFloat(ss[1]);
      r = String.valueOf(y/100);
      if(y <0){
        pantalla.value(ss[0]+"*("+r+")");
      }else{
        pantalla.value(ss[0]+"*"+r);
      }
      bandera =false;
    }
    if(val.contains("-")&& bandera){ // ACA ES DONDE CONDICIONA QUE LA PRIMERA VES SEA UN NUMERO AL ESTILO (-9)
      ss =val.split("\\-");
 
      ArrayList<String> v = new ArrayList();
      for (int i = 0; i < ss.length; i++) {
        if(!ss[i].contains("(")){
          if (ss[i].contains(")")) {
            v.add("-"+ss[i].replace(")", ""));
          } else {
            v.add(ss[i]);
          }
         }
        }
      if(v.size() >1){  
        y = Float.parseFloat(v.get(1));
        r = String.valueOf(y/100);
        if(y <0){
          pantalla.value(v.get(0)+"-("+r+")");
        }else{
          pantalla.value(v.get(0)+"-"+r);
        }
      }else{ // solo era un numero.. caso inicial      
          pantalla.value("0");  
      }
    
      bandera = false;
    }
    
    
    panel.update();
    }
    
  }
  
  
   void printResult() {
     
    boolean bandera =true;
    Control pantalla = (Control)panel.getById("pantalla");
    String val = pantalla.value().toString();
    float aux;
    
    if(val.contains("+")&& bandera){
      String[] ss =val.split("\\+");
      
      
      for(int i =0; i < ss.length; i++){
        if(ss[i].contains(")")){
          ss[i] = ss[i].replace("(", "");
          ss[i] = ss[i].replace(")", "");
        }
      }
      float x = Float.parseFloat(ss[0]);
      float y = Float.parseFloat(ss[1]);
      String r = String.valueOf(x+y);
      aux= x+y;
      if(aux < 0){
        r= "(-"+ (aux * -1) +")";
      }
      pantalla.value(r);
      
    
    bandera = false;
    }
    
    if(val.contains("/") && bandera){
      String[] ss =val.split("\\/");
      for(int i =0; i < ss.length; i++){
        if(ss[i].contains(")")){
          ss[i] = ss[i].replace("(", "");
          ss[i] = ss[i].replace(")", "");
        }
      }
      float x = Float.parseFloat(ss[0]);
      float y = Float.parseFloat(ss[1]);
      String r = String.valueOf(x/y);
      aux= x/y;
      if(aux < 0){
        r= "(-"+ (aux * -1) +")";
      }
      pantalla.value(r);
      bandera = false;
    }
    
    if(val.contains("*")&& bandera){
      String[] ss =val.split("\\*");
      for(int i =0; i < ss.length; i++){
        if(ss[i].contains(")")){
          ss[i] = ss[i].replace("(", "");
          ss[i] = ss[i].replace(")", "");
        }
      }
      float x = Float.parseFloat(ss[0]);
      float y = Float.parseFloat(ss[1]);
      String r = String.valueOf(x*y);
      aux= x*y;
      if(aux < 0){
        r= "(-"+ (aux * -1) +")";
      }
      pantalla.value(r);
      bandera = false;
    }
    
    if(val.contains("-")&& bandera){
      String[] ss =val.split("\\-");
      ArrayList<String> v = new ArrayList();
      for (int i = 0; i < ss.length; i++) {
        if(!ss[i].contains("(")){
          if (ss[i].contains(")")) {
            v.add("-"+ss[i].replace(")", ""));
          } else {
            v.add(ss[i]);
          }
         }
        }
      if(v.size() >1){
        float x = Float.parseFloat(v.get(0));
        float y = Float.parseFloat(v.get(1));
        String r = String.valueOf(x-y);
        aux= x-y;
        if(aux < 0){
          r= "(-"+ (aux * -1) +")";
        }
        pantalla.value(r);
      }
    
      bandera = false;
    }
    
    panel.update();
    
  }
  
 
  void printMasMenos() {
    boolean  bandera = true;
    Control pantalla = (Control)panel.getById("pantalla");
    String val = pantalla.value().toString();
    float y;
    String r;
    String[] ss;
     if(val.contains("+") == false &&  val.contains("-") == false && val.contains("/") == false && val.contains("*")== false){
       pantalla.value("(-"+pantalla.value()+")");
     }
      if(val.endsWith("*") == false && val.endsWith("-")== false && val.endsWith("+")== false && val.endsWith("/")== false){ 
     
     if(val.contains("+") && bandera){
      ss =val.split("\\+");
      if(ss[1].contains(")")){
        ss[1] = ss[1].replace("(", "");
        ss[1] = ss[1].replace(")", "");
        ss[1] = ss[1].replace("-", "");
      }else{
        ss[1] = "(-"+ss[1]+")";
      }
      pantalla.value(ss[0]+"+"+ss[1]);
      bandera = false;
    }
    
    if(val.contains("/") && bandera){
      ss =val.split("\\/");
      if(ss[1].contains(")")){
        ss[1] = ss[1].replace("(", "");
        ss[1] = ss[1].replace(")", "");
        ss[1] = ss[1].replace("-", "");
      }else{
        ss[1] = "(-"+ss[1]+")";
      }
      pantalla.value(ss[0]+"/"+ss[1]);
      bandera = false;
    }
    if(val.contains("*") && bandera){
      ss =val.split("\\*");
      if(ss[1].contains(")")){
        ss[1] = ss[1].replace("(", "");
        ss[1] = ss[1].replace(")", "");
        ss[1] = ss[1].replace("-", "");
      }else{
        ss[1] = "(-"+ss[1]+")";
      }
      pantalla.value(ss[0]+"*"+ss[1]);
      bandera = false;
      
    }
    
    if(val.contains("-") && bandera){
      ss =val.split("\\-");
 
      ArrayList<String> v = new ArrayList();
      for (int i = 0; i < ss.length; i++) {
        if(!ss[i].contains("(")){
          if (ss[i].contains(")")) {
            v.add("-"+ss[i].replace(")", ""));
          } else {
            v.add(ss[i]);
          }
         }
        }
      if(v.size() >1){
        if(v.get(1).startsWith("-")){
          
          pantalla.value(v.get(0)+"-"+ v.get(1).replace("-", ""));
        }else{
          pantalla.value(v.get(0)+"-(-"+ v.get(1) +")");
        }
      }else{ // solo era un numero.. caso inicial
        r = v.get(0).replace("-", "");
        pantalla.value(r);
      }
    
      bandera = false;
    }
    
    
    panel.update();
      }
    
  }
  
}
