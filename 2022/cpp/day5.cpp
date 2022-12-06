#include <iostream>
#include <string_view>
#include <range/v3/all.hpp>

namespace rg = ranges;
namespace rv = ranges::views;
namespace ra = ranges::actions;

int main (void) {
	std::array<std::string, 9> stacks;
	auto ii = rg::getlines(std::cin)
	        | rv::take_while([](std::string_view sv){return !sv.empty();})
	        | rv::transform([](auto&& r) { return r | rv::drop(1) | rv::stride(4); });
	// transpose is not so easy in range-v3 :(
	for(auto&& r : ii) {
		for(auto&& [i, c] : rv::enumerate(r)) {
			if(std::isalpha(c)) stacks[i].push_back(c);
		}
	}
	for(auto& s : stacks) s |= ra::reverse;

	const auto moves = rg::getlines(std::cin)
	        | rv::drop_while([](std::string_view sv){return sv[0] != 'm';})
	        | rv::for_each([](auto&& r) {
	          			return rg::yield_from(r | rv::split(' ') | rv::drop(1) | rv::stride(2));
	          		})
	        | rv::transform([](auto&& r) -> int {
	          			return rg::accumulate(r, 0, [](auto a, auto b){return a*10+(b-'0');});
	          		})
	        | rv::chunk(3)
	        | rg::to<std::vector<std::vector<int>>>;

	auto run = [&moves](auto stacks, auto style){
		auto crane = [=](int n){return rv::reverse | rv::take(n) | style;};
		for(const auto& m: moves) {
			int n = m[0], f = m[1]-1, t = m[2]-1;
			auto v = stacks[f] | crane(n);
			stacks[t].append(v.begin(), v.end());
			stacks[f].resize(stacks[f].length() - n);
		}
		return stacks | rv::for_each([](std::string_view sv){
		             	return rg::yield_from(sv | rv::reverse | rv::take(1));
		             })
		           | rg::to<std::string>;
	};

	std::cout << run(stacks,     rv::all) << '\n';
	std::cout << run(stacks, rv::reverse) << '\n';
	return EXIT_SUCCESS;
}
