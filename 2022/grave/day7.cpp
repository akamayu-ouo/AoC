#include <iostream>
#include <vector>
#include <string>
#include <string_view>
#include <optional>
#include <range/v3/all.hpp>

namespace rg = ranges;
namespace rv = ranges::views;
namespace ra = ranges::actions;

struct Node {
	private:
	Node* addChild(std::string_view n, size_t sz, bool dir) {
		Node* nd = new Node();
		nd->name = n;
		nd->size = sz;
		nd->isdir = dir;
		nd->up = this;
		this->down.push_back(nd);
		return nd;
	}
	std::optional<Node*> findChild(std::string_view n) {
		auto it = rg::find(this->down, n,
				[](auto*p)->std::string_view{return p->name;});
		if(it == rg::end(this->down)) return {};
		else return {*it};
	}
	public:
	std::string name;
	size_t size{0};
	bool isdir{true};
	Node* up{nullptr};
	std::vector<Node*> down{};

	Node* newDir(std::string_view n) {
		if(auto o = findChild(n)) return *o;
		return addChild(n, 0, true);
	}
	Node* newFile(std::string_view n, size_t sz) {
		if(auto o = findChild(n)) return *o;
		return addChild(n, sz, false);
	}
};

auto split(std::string_view sv) {
	auto m = sv.find(' ');
	auto fst = sv.substr(0,m);
	auto snd = sv.substr(m+1);
	return std::make_pair(fst, snd);
}

void showLev(int level) {
	for(int i = 0; i < level; ++i){
		std::cout << "  ";
	}
}

void show (Node* now, int level = 0) {
	//if(now->isdir)
	//showLev(level), std::cout << now->name << '\n';
	//else
	showLev(level), std::cout << now->name << ' ' << now->size << '\n';
	for(auto* p : now->down) {
		show(p, level+1);
	}
}

size_t addSize (Node* now) {
	return now->size = rg::accumulate(now->down, now->size, std::plus<size_t>{}, addSize);
}

size_t sumSmall (Node* now) {
	auto sz = (now->isdir && now->size <= 100000ull)*(now->size);
	return rg::accumulate(now->down, sz, std::plus<size_t>{}, sumSmall);
}

size_t closestValid (Node* now, size_t target) {
	return rg::accumulate(now->down, now->size,
			[=](size_t a, size_t b){return (a - target) < (b - target) ? a : b;},
			[=](Node* p){return closestValid(p, target);});
}

int main (void) {
	std::string line;
	Node FS, *now{&FS}; FS.up = now;
	for(std::string_view sv : rg::getlines(std::cin)) {
		auto [fst, snd] = split(sv);
		switch(sv.front()) {
			break; case '$':
				if(snd != "ls") {
					auto fn = split(snd).second;
					if(fn == "..") now = now->up;
					else now = now->newDir(fn);
				}
			break; case 'd':
				now->newDir(snd);
			break; default:
				now->newFile(snd, std::stoull(std::string(fst)));
			break;
		}
	}

	auto totsz = addSize(&FS);
	std::cout << sumSmall(&FS) << '\n';
	auto fresz = totsz - (70000000ull - 30000000ull);
	std::cout << closestValid(&FS, fresz) << '\n';
	return EXIT_SUCCESS;
}
