from random import seed, randint

def load_graph(graph_path):
    f = open(graph_path,'r') 
    v_name = lambda data: int(data.split("\t")[0])
    v_adjs = lambda data: map(int,data.split("\t")[1:-1]) 

    adjs = {v_name(vd):v_adjs(vd) for vd in list(f)}
    g = Graph(adjs.keys(), adjs)
    f.close()
    return g

class Graph:

    def __init__(self, v, adjs):
        self.v = list(v)
        self.adjs = dict(adjs)

    def rand_edge(self):
        ai = randint(0, len(self.v)-1) 
        a  = self.v[ai]
        bi = randint(0, len(self.adjs[a])-1)
        b  = self.adjs[a][bi]
        return (a, b)

    def contract(self, e):
        a, b = e
        # Relink b edges to a 
        for be in self.adjs[b]:
            for i,v in enumerate(self.adjs[be]):
                if (v==b):
                    self.adjs[be][i] = a
                    self.adjs[a].append(be)

        # Remove loop
        self.adjs[a] = [v for v in self.adjs[a] if v!=a]
        
        # Remove vertex b
        self.v.remove(b)
        del self.adjs[b]


def min_cut(g):
    seed()
    while len(g.v)>2:
        e = g.rand_edge()
        g.contract(e)

    print g.v, len(g.adjs[g.v[0]]), len(g.adjs[g.v[1]])
    return len(g.adjs[g.v[0]])
