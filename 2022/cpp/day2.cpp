#include <iostream>
#include <numeric>
#include <vector>
#include <functional>

int score (const auto& list, auto shape, auto cmp) {
	return std::transform_reduce(list.cbegin(), list.cend(), 0, std::plus<>{},
			[&](const auto& m){
				return 1 + std::invoke(shape,m) + 3 * std::invoke(cmp,m);
			});
}

int main (void) {
	struct Match{int a, b;};
	std::vector<Match> input;
	std::string line;
	while(std::getline(std::cin, line)){
		input.emplace_back(line.front()-'A', line.back()-'X');
	}
	// Direct calculation
	// return 1 + (m.a == ((m.b+2)%3)) - (m.a == ((m.b+1)%3)); 
	auto outcome = [](const auto&m) { return (4+m.b-m.a)%3; };
	auto myshape = [](const auto&m) { return (2+m.b+m.a)%3; };
	std::cout << score(input, &Match::b, outcome) << '\n';
	std::cout << score(input, myshape, &Match::b) << '\n';
	return EXIT_SUCCESS;
}
