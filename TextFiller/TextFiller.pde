boolean screen[][];
int thresh = 3;
int threshsq = thresh*thresh;
int maxstep = 19;
int speed = 8;
int initcnt = 200;
int runningIndex = 0;
int point[][];
boolean paused = true;
boolean drawn[][];

void setup(){
    size(800, 300);
    background(0); 
    randomSeed(1200);
    PFont f = createFont("Calibri", 120);
    textFont(f);
    String s1 = "BHALLAGE NA";
    String s2 = "MARA JABO";
    CenterText(s1, height/2-25);
    CenterText(s2 , height/2+70);
    screen = new boolean[width][height];
    drawn = new boolean[width][height];
    fillScreenInfo();
    
    //noLoop();
    background(0);
    //debugscreen();
    point = new int[initcnt][2];
    for(int i = 0; i<initcnt; i++)
        while(!fillInitial(i));
    colorMode(HSB, initcnt);
    print("setup finished");
}

void debugscreen(){
    stroke(0, 0, 255);
    for(int x = 0; x<width; x++)
        for(int y = 0; y<height; y++)
            if(screen[x][y]) point(x, y);
}

void CenterText(String s, float h){
    float wd = textWidth(s);
    text(s, (width-wd)/2, h);
}

boolean fillInitial(int id){
    int x = int(random(width));
    int y = int(random(height));
    if(screen[x][y]){
        point[id][0] = x;
        point[id][1] = y;
        drawn[x][y] = true;
        return true;
    }
    return false;
}

boolean valid(float x, float y){
    if(x < 0 || x >= width || y < 0 || y >= height) return false;
    return true;
}

void fillScreenInfo(){
    for(int x = 0; x<width; x++)
        for(int y = 0; y<height; y++)
            screen[x][y] = check(x, y);
}

boolean check(int x, int y){
    for(int dx = -thresh; dx<=thresh; dx++)
        for(int dy = -thresh; dy<=thresh; dy++)
            if(valid(x+dx, y+dy) && get(x+dx, y+dy) != color(0))
                if(norm(dx, dy) <= threshsq) return true;
    return false;
}

float norm(int dx, int dy){
    return dx*dx + dy*dy;
}

float montecarlo(){
    while(true){
        float r1 = random(1);
        float probability = r1;
        float r2 = random(1);
        if(r2 < probability)
            return r1;
    }
}

boolean drawNext(int id){
    int px = point[id][0];
    int py = point[id][1];
    float mx = maxstep*montecarlo();
    //float r = random(1);
    //if(r < 0.02) mx *= 10; 
    float dx = random(-mx, mx);
    float dy = random(-mx, mx);
    int nx = int(px+dx);
    int ny = int(py+dy);
    if(valid(nx, ny) && screen[nx][ny] && !drawn[nx][ny]){
        line(px, py, px+dx,py+dy);
        point[id][0] = nx;
        point[id][1] = ny;
        drawn[nx][ny] = true;
        return true;
    }
    else return false;
    
}

void draw(){
    if(paused) return;
    for(int i = 0; i<speed; i++){
        int r = runningIndex;
        stroke(r, initcnt, initcnt);
        int j = 0;
        while(!drawNext(r) && j < 40) j++;
        runningIndex++;
        if(runningIndex == initcnt) runningIndex = 0;
    }
}

void mouseClicked(){
    if(mouseButton == RIGHT)
        noLoop();
    else paused = !paused;
}
