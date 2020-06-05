enum State{
    NOTSTARTED, DRAWING, FINISHED;
}

class Arc{
    final int duration = 5;
    int clck = 0;
    Node u, v;
    Cell parent;
    float stAngle, fnAngle;
    boolean visited;
    boolean drawForward;
    State state;
    
    Arc(Node u, Node v, Cell parent, float uAngle){
        this.u = u;
        this.v = v;
        this.parent = parent;
        stAngle = uAngle;
        fnAngle = stAngle+HALF_PI;
        
        stAngle += 0.02;
        fnAngle -= 0.02;
        
        visited = false;
        drawForward = false;
        state = State.NOTSTARTED;
    }
    
    void draw(){
        noFill();
        stroke(parent.col);
        strokeWeight(2);
        float K = 0.99;
        arc(parent.centerX, parent.centerY, parent.side*K, parent.side*K, stAngle, fnAngle, OPEN);
    }
    
    boolean animateDraw(boolean lastFinished){
        if(state == State.NOTSTARTED){
            if(lastFinished){
                state = State.DRAWING;
            }
            return false;
        }
        if(state == State.DRAWING){
            clck++;
            if(clck == duration)
                state = State.FINISHED;
        }
        
        float drawStAngle, drawFnAngle;
        if(drawForward){
            drawStAngle = stAngle;
            drawFnAngle = map(clck, 0, duration, stAngle, fnAngle);
        }
        else{
            drawStAngle = map(clck, 0, duration, fnAngle, stAngle);
            drawFnAngle = fnAngle;
        }
        
        noFill();
        stroke(parent.col);
        strokeWeight(2.9);
        strokeCap(PROJECT);
        float K = 0.99;
        arc(parent.centerX, parent.centerY, parent.side*K, parent.side*K, drawStAngle, drawFnAngle, OPEN);
        
        return (state == State.FINISHED);
    }
    
    boolean isUnordered(Node u, Node v){
        if(this.u == u && this.v == v) return true;
        if(this.v == u && this.u == v) return true;
        return false;
    }
}
