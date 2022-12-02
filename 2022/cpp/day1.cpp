#include <iostream>
#include <numeric>
#include <algorithm>
#include <vector>

int main (void) {
	std::vector<int> sums{};
	std::string line{};
	do{
		if(!line.empty()){
			sums.back() += std::stoi(line);
		}else{
			sums.emplace_back(0);
		}
	}while(std::getline(std::cin, line));

	auto head{sums.begin()}, third{head+3};
	std::nth_element(head, third, sums.end(), std::greater_equal<>{});

	std::cout << *std::max_element(head, tird) << '\n';

	std::cout << std::accumulate(head, third, 0) << '\n';
}
