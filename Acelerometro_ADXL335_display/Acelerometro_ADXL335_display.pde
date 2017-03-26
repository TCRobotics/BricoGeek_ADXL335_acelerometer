
int x;
int y;
int z;
int q;
int a;
int pixeles;
int final;
unsigned char temp;
int X, Y, Z;

const int interruptor = 3;
int estado= 0;

void setup() {
  pinMode(interruptor, INPUT);  
  Serial.begin(115200); //por defecto el LCD trabaja a estos bps
  delay(4000);
    cambiar_fondo();
  delay(3000);
  cambiar_fondo();
  delay(3000);
  luz_fondo(100);
}

void loop() {
  estado = digitalRead(interruptor); 
  if (estado == HIGH) { 
    for (int i=0; i<127; i++){ 
      X = (map(analogRead(0),413, 274,-100,100)/30);    
      Y = (map(analogRead(1),408, 269,-100,100)/30);       
      Z = (map(analogRead(2),411, 275,-100,100)/30); 
      linea(i,0,i,63,0);
      delay(2);
      pixel(i,(53+X) ,1);
      pixel(i,(32+Y) ,1);
      pixel(i,(11+Z) ,1);
    delay(5);
    }
  }
}



//////////////////////FUNCIONES LCD SERIAL//////////////////////////////////////////////


//escribe caracteres en la pantalla
void escribir_LCD(char *data){
 Serial.print(data);
 delay(20);
}

//borra un caracter hacia atras
void backspace(){
 Serial.print(0x08,BYTE);
 delay(20);
}


//invierte el fondo del LCD de claro a oscuro o viceversa
void cambiar_fondo(){
  Serial.print(0x7C,BYTE);
  Serial.print(0x12,BYTE);
  delay(20); 
}

//permite ajustar la retroiluminacion
void luz_fondo(int luz){ // de 0 a 100
  Serial.print(0x7C,BYTE);
  Serial.print(0x02,BYTE); 
  Serial.print(luz,BYTE); 
  delay(20); 
}


//activa o desactiva el pixel en una coordenada 
void pixel (int x, int y, int on_off){   //x de 0 a 127 
  Serial.print(0x7C,BYTE);               //y de 0 a  63
  Serial.print(0x10,BYTE);               //on_off=1 ON
  Serial.print(x,BYTE);                  //on_off=0 Off
  Serial.print(y,BYTE);
  Serial.print(on_off,BYTE);
}

//dibuja o borra una linea
void linea (int desde_x, int desde_y, int hasta_x, int hasta_y, int on_off){ 
  Serial.print(0x7C,BYTE);             
  Serial.print(0x0C,BYTE);               
  Serial.print(desde_x,BYTE);
  Serial.print(desde_y,BYTE);
  Serial.print(hasta_x,BYTE);
  Serial.print(hasta_y,BYTE);  
  Serial.print(on_off,BYTE);
  delay(20);
}



