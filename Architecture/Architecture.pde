import java.util.*;

Brancher B;
boolean visited[][];
int gridwidth, gridheight;
boolean pause = false;
ArrayList<Integer> cols;

int cellsize = 1;
int speed = 5;

void setup(){
    size(512, 512);
    background(0);
    
    gridwidth = width/cellsize;
    gridheight = height/cellsize;
    visited = new boolean[gridwidth][gridheight];
    cols = new ArrayList<Integer>();
    colorMode(RGB, 64);
    int n = 0;
    for(int r = 0; r<64; r++)
        for(int g = 0; g<64; g++)
            for(int b = 0; b<64; b++)
                cols.add(color(r, g, b));
    Collections.sort(cols, new Comparator<Integer>(){
        public int compare(Integer i1, Integer i2){
            if(brightness(i1) != brightness(i2))
                return comp(brightness(i1), brightness(i2));
            else if(hue(i1) != hue(i2)) 
                return comp(hue(i1), hue(i2));
            else if(saturation(i1) != saturation(i2))
                return comp(saturation(i1), saturation(i2));
            return 0;
        }
    });
    
    B = new Brancher(new myvector(gridwidth/2, gridheight/2));

    frameRate(60);
}

int comp(float x, float y){
    if(x == y) return 0;
    else if(x < y) return -1;
    else return 1;
}

void draw(){
    speed = frameCount / 180 + 1;
    if(speed > 10) speed = 10;
    if(pause) return;
    int sp = speed;
    while(sp != 0){
        B.update();
        B.randomAdd();
        sp--;
    }
}

void mouseClicked(){
    pause = !pause;
    if(pause) println("paused");
    else println("resuming");
}

boolean valid(int x, int y){
    if(x < 0 || x >= gridwidth || y < 0 || y >= gridheight) return false;
    return true;
}

myvector randomDir(){
    float r = random(1);
    if(r < 0.25) return new myvector(1, 0);
    else if(r < 0.5) return new myvector(0, 1);
    else if(r < 0.75) return new myvector(-1, 0);
    else return new myvector(0, -1);
}

float dist(color c, color d){
    float r = red(c)-red(d);
    float g = green(c)-green(d);
    float b = blue(c)-blue(d);
    return (abs(r)+abs(g)+abs(b));
}

float comp(int x, int y, color c){
    float cnt = 0, sum = 0;
    for(int dx = -1; dx<=1; dx++)
        for(int dy = -1; dy<=1; dy++)
            if(valid(x+dx, y+dy) && visited[x+dx][y+dy]){
                sum += dist(c, color(get((x+dx)*cellsize, (y+dy)*cellsize)));
                cnt += 1;
            }
    return sum/cnt;
}

void getColor(int x, int y){
    /*int c = -1;
    float best = 100000000.0;
    for(int i = 0; i<cols.size()/1000 || i<1; i++){
        //int r = cols.size()-i-1;
        int r = int(random(cols.size()));
        float tmp = comp(x, y, cols.get(r));
        if(c == -1){
            c = r;
            best = tmp;
        }
        else if(tmp < best){
            c = r;
            best = tmp; 
        }
    }*/
    int c = cols.size()-1;
    color co = cols.get(c);
    stroke(co);
    cols.remove(c);
}

void celldraw(int x, int y){
    getColor(x, y);
    //stroke(64);
    if(cellsize == 1) point(x, y);
    else rect(x*cellsize, y*cellsize, cellsize, cellsize);
}
