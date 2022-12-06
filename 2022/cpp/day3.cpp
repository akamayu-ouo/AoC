#include <iostream>
#include <vector>
#include <bit>
#include <range/v3/all.hpp>

namespace rg = ranges;
namespace rv = ranges::views;

auto hash(char c) {
	return 1ull << (std::tolower(c) - 'a') + (26*!!std::isupper(c)) + 1;
}

auto sum_up(const rg::view_ auto& in) {
	return rg::accumulate(in, 0, std::plus<>{},
			[](const auto& oc) {
				auto h = rg::accumulate(oc, 0ull-1ull, std::bit_and<>{},
						[](const auto& ic) {
							return rg::accumulate(ic | rv::transform(hash), 0ull, std::bit_or<>{});
						});
				return std::countr_zero(h);
			});
}

int main (void) {
	const auto input = rg::getlines(std::cin) | rg::to_vector;

	auto p1 = input 
		    | rv::transform([](const auto& v){ return rv::chunk(v, v.size()/2); });
	auto p2 = rv::chunk(input, 3);

	std::cout << sum_up(p1) << '\n';
	std::cout << sum_up(p2) << '\n';
	return EXIT_SUCCESS;
}
