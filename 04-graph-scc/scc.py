from random import seed, randint

def load_graph(graph_path):

    g = Graph(); gt = Graph()

    f = open(graph_path,'r') 
    i = 0
    while True:
        i+=1
        if i%1e5 == 0: print i
        #if i>100000: break
        raw_e = f.readline()
        if not raw_e: break

        a,b = map(int, raw_e.split(" ")[:2])
        g.add( (a,b) )
        gt.add( (b,a) )

    f.close()
    return [g, gt]

class Graph:

    def __init__(self):
        self.v = set()
        self.adjs = dict()

    def add(self, e):
        for v in e:
            if v not in self.v: 
                self.v.add(v)
                self.adjs[v] = set()

        adjs = self.adjs[e[0]]
        if e[1] not in adjs:
            adjs.add( e[1] )

def dfs(g, v=None, build_tree=False):
    g.color = {a:0 for a in g.v}
    g.t_end = {a:0 for a in g.v}
    g.cc = []
    g.time = 0
    for a in (v or g.v):
        if g.color[a] == 0:
            if build_tree: g.cc.append( {a} )
            dfs_visit(g, a, build_tree)

def dfs_visit_(g, a, build_tree=False):
    g.color[a] = 1
    g.time += 1
    for b in g.adjs[a]:
        if g.color[b] == 0:
            if build_tree: g.cc[-1].add( b )
            dfs_visit(g, b, build_tree)
    g.color[a] = 2
    g.time += 1
    g.t_end[a] = g.time

def dfs_visit(g, a, build_tree=False):
    Q = [a]

    while len(Q)>0:
        v = Q[-1]
        g.time += 1
        if g.color[v] == 2:
            Q.pop()
        elif g.color[v] == 0:
            g.color[v] = 1
            if build_tree: g.cc[-1].add( v )
            Q.extend((u for u in g.adjs[v] if g.color[u] == 0))
        elif g.color[v] == 1:
            g.color[v] = 2
            g.t_end[v] = g.time
            Q.pop()

def scc(g, gt):
    print "STEP 1: DFS"
    dfs(g);
    print "STEP 2: Sort by end time"
    v_ends = sorted(g.t_end.iteritems(), key=lambda i:i[1], reverse=True)
    print "STEP 3: DFS by END Time"
    dfs(gt, (v for v,end in v_ends), True)
    return gt.cc

