#include <iostream>
#include <vector>
#include <string>
#include <string_view>
#include <range/v3/all.hpp>

namespace rg = ranges;
namespace rv = ranges::views;

struct Node {
	private:
	public:
		size_t size{0};
		Node* up{nullptr};
		std::vector<Node*> down{};
		
		Node() : up{this} {}
		Node(Node* u) : up{u} {}
		
		Node* addDir() {
			down.push_back(new Node(this));
			return down.back();
		}
		
		~Node() { for(auto*p:down) delete p; }
};

size_t addSize (Node* now) {
	return now->size += rg::accumulate(now->down, 0ull, rg::plus{}, addSize);
}

size_t sumSmall (Node* now) {
	auto sz = (now->size <= 100000ull)*(now->size);
	return rg::accumulate(now->down, sz, rg::plus{}, sumSmall);
}

size_t closestValid (Node* now, size_t target) {
	return target
	    + rg::accumulate(now->down, now->size - target, rg::min,
	          [=](Node* p){return closestValid(p, target) - target;});
}

auto split(std::string_view sv) {
	auto m = sv.find(' ');
	return std::make_pair(sv.substr(0,m), sv.substr(m+1));
}

int main (void) {
	auto r = Node{}, *now{&r};
	for(std::string_view sv : rg::getlines(std::cin)) {
		if(sv.starts_with('$')){
			sv.remove_prefix(2);
			if(sv.starts_with("cd")){
				auto to = split(sv).second;
				now = (to == "..") ? now->up : now->addDir();
			}
		}else if(std::isdigit(sv.front())){
			auto sz = split(sv).first;
			now->size += std::stoull(std::string(sz));
		}
	}
	
	auto totsz = addSize(&r);
	std::cout << sumSmall(&r) << '\n';
	auto todel = totsz - (70000000ull - 30000000ull);
	std::cout << closestValid(&r, todel) << '\n';
	
	return EXIT_SUCCESS;
}
