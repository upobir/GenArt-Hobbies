class myvector{
    int x, y;
    
    myvector(int x_, int y_){
        x = x_;
        y = y_;
    }
    myvector add(myvector m, myvector n){
        return new myvector(m.x + n.x, m.y + n.y);
    }
    
    myvector rot(myvector m){
        return new myvector(-m.y, m.x);
    }
    
    myvector mult(myvector m, int k){
        return new myvector(k*m.x, k*m.y);
    }
}

class Brancher{
    ArrayList<leaf> leaves;
    ArrayList<myvector> inside;
    
    Brancher(myvector init){
        leaves = new ArrayList<leaf>();
        inside = new ArrayList<myvector>();
        celldraw(init.x, init.y);
        visited[init.x][init.y] = true;
        myvector dir = new myvector(1, 0);
        for(int i = 0; i<4; i++){
            leaves.add(new leaf(init.add(init, dir), dir));
            dir = dir.rot(dir);
        }
    }
    
    void update(){
        for(int i = leaves.size()-1; i>=0; i--){
            leaf l = leaves.get(i);
            if(l.show()){
                visited[l.pos.x][l.pos.y] = true;
                //println("adding "+l.pos.x+" "+l.pos.y);
                inside.add(l.pos);
            }
            else{
                leaves.remove(i);
                continue;
            }
            
            leaf[] newl = l.update();
            if(newl != null){
                leaves.remove(i);
                for(leaf nl: newl)
                    leaves.add(nl);
            }
        }
    }
    
    void randomAdd(){
        if(inside.size() == 0) {
            println("finished");
            noLoop();
            return;
        }
        
        if(random(1) < 0.01 || leaves.size() < 10){
            int id = int(random(inside.size()));
            myvector dir = randomDir();
            for(int i = 0; i<4; i++){
                leaf l = new leaf(dir.add(inside.get(id), dir), dir);
                if(l.ok()){
                    leaves.add(l);
                    return;
                }
                dir = dir.rot(dir);
            }
            //myvector m = inside.get(id);
            //println("erasing "+m.x+" "+m.y);
            inside.remove(id);
        }
        return;
    }
}

class leaf{
    myvector pos;
    myvector dir;
    int len;
    leaf(myvector pos_, myvector dir_){
        pos = pos_;
        dir = dir_;
        len = 1;
    }
    
    
    
    leaf[] update(){
        leaf[] ret = null;
        
        float avlen = 100.0;
        if(random(1) > (avlen-1.0)/avlen){
            do{
                myvector ndir = dir.mult(dir, -1);
                ret = new leaf[0];
                for(int i = 0; i<3; i++){
                    ndir = ndir.rot(ndir);
                    if(random(1) < 0.5)
                        ret = (leaf[]) append(ret, new leaf(pos.add(pos,ndir), ndir)); 
                }
            }while(ret.length == 0);
        }
        else{
            pos = pos.add(pos, dir);
            len++;
        }
        return ret;
    }
    
    boolean ok(){
        return (valid(pos.x, pos.y)  && !visited[pos.x][pos.y]);
    }
    
    boolean show(){
        if(ok()){
            celldraw(pos.x, pos.y);
            return true;
        }
        else
            return false;
    }
}
