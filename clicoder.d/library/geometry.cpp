// Problems to test this library {{{
// http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=2641
// }}}

// Geometry <3 {{{
class GeometryUtil {
	public:
		bool eql(double a, double b) { return abs(a - b) < EPS; }
		bool lt(double a, double b) { return b - a >= EPS; }
		bool lte(double a, double b) { return lt(a, b) || eql(a, b); }
		bool gt(double a, double b) { return !lte(a, b); }
		bool gte(double a, double b) { return !lt(a, b); }
		bool eql(P a, P b) { return eql(a.Y, b.Y) && eql(a.X, b.X); }
		GeometryUtil() {
		}
};

GeometryUtil geo = GeometryUtil();

template<typename T>
class Vector3D {
	public:
		T x, y, z;
		Vector3D(T _x, T _y, T _z): x(_x), y(_y), z(_z) {
		}

		T abs() {
			return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
		}

		T dot(Vector3D<T> rhs) {
			return x * rhs.x + y * rhs.y + z * rhs.z;
		}

		Vector3D<T> cross(Vector3D<T> rhs) {
			return Vector3D(y*rhs.z - z*rhs.y, z*rhs.x - x*rhs.z, x*rhs.y - y*rhs.x);
		}

		// check if this Vector3D (as a point) is on a line (a-b)
		const bool is_upon(const Vector3D<T> a, const Vector3D<T> b) const {
			dump((b-a).cross(b-(*this)).abs());
			dump(geo.eql((b-a).cross(b-(*this)).abs(), 0));
			dump((b-a).dot((*this)-a));
			dump(geo.gt( (b-a).dot((*this)-a), 0 ));
			dump((a-b).dot((*this)-b));
			dump(geo.gt( (a-b).dot((*this)-b), 0 ));

			return geo.eql( (b-a).cross(b-(*this)).abs(), 0 ) &&
				geo.gt( (b-a).dot((*this)-a), 0 ) &&
				geo.gt( (a-b).dot((*this)-b), 0 );
		}

		// Add vector
		Vector3D<T> operator+(const Vector3D<T>& rhs) const {
			return Vector3D<T>(x + rhs.x, y + rhs.y, z + rhs.z);
		}

		// Subtract vecrtor
		Vector3D<T> operator-(const Vector3D<T>& rhs) const {
			return Vector3D<T>(x - rhs.x, y - rhs.y, z - rhs.z);
		}

		// Multiply by scala value
		template<typename Scala>
		Vector3D<T> operator*(const Scala rhs) const {
			return Vector3D<T>(x * rhs, y * rhs, z * rhs);
		}
};
template<typename T>
ostream& operator<<(ostream& out, const Vector3D<T>& v) {
	return out << "(" << v.x << ", " << v.y << ", " << v.z << ")";
}

class Sphere {
	int x, y, z, r;
	public:
		Sphere(int _x, int _y, int _z, int _r) : x(_x), y(_y), z(_z), r(_r) {
		}
};
// }}}

// vim: foldmethod=marker
