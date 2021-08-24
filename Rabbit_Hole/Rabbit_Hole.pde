import java.util.*;

ArrayList<Square> squares;
int n = 20, B = 0;
int period = 12*60, T = 0;
boolean pause = true;
float lo, hi;

void setup(){
    size(600, 600);
    squares = new ArrayList();  
    colorMode(HSB);
  
    reset();
    for(Square square : squares){
        square.draw();
    }
    
    lo = f(0);
    hi = f((float)(period)/(float)period);
}

void reset(){
    squares.clear();
    Square parent = null;
    ArrayList<Integer> indices = new ArrayList();
    for(int i = 0; i<n-1; i++){
        indices.add(i);
    }
    Collections.shuffle(indices);
    
    for(int i = 0; i<n; i++){
        Square me;
        if(i != n-1)
            me = new Square(parent, color(map(indices.get(i), 0, n-1, 240, 0), 180, 180));
        else
            me = new Square(parent, color(0, 0, B));
        squares.add(me);
        parent = me;
    }
}


void draw(){
    if(pause)
        return;
        
    float ratio = (float) T / (float) period;
    ratio = f(ratio);
    ratio = map(ratio, lo, hi, 0, 1);
    for(Square square : squares){
        square.update(ratio);
        square.draw();
    }
    if(T == period/2){
        B = 255 - B;
        squares.get(squares.size()-1).c = color(0, 0, B);
    }
    
    if(T == period){
        pause = true;
        T = 0;
        reset();
    }
    T++;
}

void keyPressed(){
    pause = false;
}

float f(float x){
    x = (float)(1.0/(1.0 + Math.exp(-4.2*(x-0.5))));
    return x;
}
