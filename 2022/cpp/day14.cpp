#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

struct Vec {
	int x, y;
};

std::istream& operator>>(std::istream& is, Vec& v) {
	is >> v.x;
	is.ignore(1);
	is >> v.y;
	return is;
}
std::ostream& operator<<(std::ostream& os, const Vec& v) {
	return os << v.x << ',' << v.y;
}

bool operator==(const Vec& a, const Vec& b) {
	return a.x == b.x && a.y == b.y;
}
bool operator!=(const Vec& a, const Vec& b) {
	return !(a == b);
}
Vec operator+(const Vec& a, const Vec& b) {
	return {a.x+b.x, a.y+b.y};
}
Vec operator-(const Vec& a, const Vec& b) {
	return {a.x-b.x, a.y-b.y};
}

using Point = Vec;

bool OnWall(const auto& w, const Point& p) {
	auto hit = [&](const Point& s, const Point& e) -> bool {
		if(e.x == p.x && p.x == s.x)
			return (s.y <= p.y && p.y <= e.y) || (e.y <= p.y && p.y <= s.y);
		else if(e.y == p.y && p.y == s.y)
			return (s.x <= p.x && p.x <= e.x) || (e.x <= p.x && p.x <= s.x);
		return false;
	};
	return std::transform_reduce(w.cbegin(), w.cend(), false, std::logical_or<>{},
			[&](const auto& v){
				return std::transform_reduce(v.cbegin()+1, v.cend(), v.cbegin(),
						false, std::logical_or<>{}, hit);
			});
}

bool OnFallen(const auto& f, const Point& p) {
	return std::find(f.cbegin(), f.cend(), p) != f.cend();
}

bool Falling(const auto& wall, auto& fallen, auto maxy) {
	std::vector<Vec> d{{0,1}, {-1,1}, {1,1}, {0,0}};
	auto dd = d.cbegin();
	Point p{500, 0};
	do{
		dd = std::find_if(d.cbegin(), d.cend(), 
				[&](const auto& v){
					Point pp{p.x+v.x, p.y+v.y};
					return !OnWall(wall, pp) && !OnFallen(fallen, pp);
				});
		if(dd == d.cend() || p.y >= maxy) return false;
		p = p + *dd;
	}while(dd->y);
	fallen.push_back(p);
	return true;
}

int main (void) {
	std::vector<std::vector<Point>> walls{};
	Point p;
	do{
		walls.emplace_back();
		auto& v = walls.back();
		while(std::cin >> p){
			v.emplace_back(p);
			if(std::cin.peek() != '\n'){
				std::cin.ignore(3);
			}else{
				break;
			}
		}
	}while(std::cin);

	auto maxy = 0;
	for(const auto& w : walls)
		for(const auto& p : w)
			maxy = std::max(maxy, p.y);

	std::vector<Point> fallen{};
	while(Falling(walls, fallen, maxy)){};
	std::cout << fallen.size() << '\n';

	walls.emplace_back();
	walls.back().emplace_back(-100000,maxy+2);
	walls.back().emplace_back( 100000,maxy+2);
	while(Falling(walls, fallen, maxy+3)){};
	std::cout << fallen.size() << '\n';

	return EXIT_SUCCESS;
}
