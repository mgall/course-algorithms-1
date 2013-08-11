from random import seed, randint

inf = 1000000

def load_graph(graph_path):
    g = Graph(); 
    f = open(graph_path,'r') 
    while True:
        r = f.readline().split('\t')
        if not r or r[0].strip() == '': break

        a = int(r[0])
        g.v.add(a);
        adjs = (map(int,e.split(',')) for e in r[1:-1])
        g.adjs[a] = { v:w for v,w in adjs}

    f.close()
    return g

class Graph:

    def __init__(self):
        self.v = set()
        self.adjs = dict()

def msp_dijkstra(g, s):
    g.d = {u:inf for u in g.v}
    g.p = {u:None for u in g.v}
    g.d[s] = 0
    S = { s }
    Q = set(g.v)
    while len(Q) > 0:
        u = extract_min(g, Q)
        S.add(u);
        for v in g.adjs[u].keys():
            relax(g, u, v)

def extract_min(g, Q):
    u = min( ((v,g.d[v]) for v in Q), key=lambda u:u[1])
    Q.discard( u[0] )
    return u[0]
   
def relax(g, u, v):
    w = g.d[u] + g.adjs[u][v]
    if g.d[v] > w:
        g.d[v] = w
        g.p[v] = v
    return w


