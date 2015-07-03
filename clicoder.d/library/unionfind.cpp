class UnionFindTree {
	int n;
	VI parent;
	public:
		UnionFindTree(int _n): n(_n) {
			parent = VI(n);
			REP (i, n) {
				parent[i] = i;
			}
		}

		int group(int x) {
			if (parent[x] == x) {
				return x;
			} else {
				return parent[x] = group(parent[x]);
			}
		}

		bool united(int x, int y) {
			return group(x) == group(y);
		}

		bool all_united() {
			int g = group(0);
			FOR (i, 1, n) {
				if (group(i) != g) { return false; }
			}
			return true;
		}

		void unite(int x, int y) {
			x = group(x);
			y = group(y);
			parent[x] = y;
		}
};
