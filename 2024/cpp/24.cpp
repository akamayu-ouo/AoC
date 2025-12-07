#include <array>
#include <fstream>
#include <iostream>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <queue>
#include <vector>

struct O {
	std::string a, b, c;
	char op;
};

int main(void) {
	std::ifstream inf("../in/24.in");
	std::unordered_map<std::string, bool> values{};

	std::unordered_map<std::string, std::vector<std::string>> adj;
	std::unordered_map<std::string, O> operations;

	for (std::string line; std::getline(inf, line) and not line.empty();) {
		auto xy = line.substr(0, 3);
		values[xy] = line.back() == '1';
	}

	for (std::string line; std::getline(inf, line);) {
		auto o = 11 == line.find('-');
		const auto& op = operations.try_emplace(line.substr(15 - o, 3),
				line.substr(0, 3), line.substr(8 - o, 3),
				line.substr(15 - o, 3), line[4]).first->second;
		adj[op.a].emplace_back(op.c);
		adj[op.b].emplace_back(op.c);
	}
	std::cout << adj.size() << '\n';

	auto ready = [&](const O& o) {
		return values.contains(o.a) and values.contains(o.b);
	};

	std::queue<std::string> front;
	for(const auto& [_, o]: operations)
		if(ready(o))
			front.push(o.c);

	uint64_t ans{};
	while(not front.empty()) {
		auto now = front.front(); front.pop();
		const auto& o = operations[now];
		switch (o.op) {
			case 'A':
				values[o.c] = values.at(o.a) & values.at(o.b);
				break;
			case 'O':
				values[o.c] = values.at(o.a) | values.at(o.b);
				break;
			case 'X':
				values[o.c] = values.at(o.a) ^ values.at(o.b);
				break;
			default:
				break;
		}
		if(o.c[0] =='z') {
			int shift = 10 * (o.c[1] - '0') + (o.c[2] - '0');
			ans |= uint64_t{values[o.c]} << shift;
		}
		for(const auto& nxt : adj[o.c])
			if(const auto& o = operations[nxt]; ready(o))
				front.push(nxt);

	}

	std::cout << ans << '\n';
}
