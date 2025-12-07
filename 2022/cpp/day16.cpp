#include <iostream>
#include <string>
#include <regex>



int main (void) {
	const std::regex line_regex{"Valve ([A-Z]+) has flow rate=([0-9]+); tunnels? leads? to valves? (?:([A-Z]+),? ?)+"};
	std::smatch line_match;
	std::string line;
	while(std::getline(std::cin, line)) {
		std::cout << line << '\n';
		if (std::regex_match(line, line_match, line_regex)) {
            for (size_t i = 0; i < line_match.size(); ++i) {
                std::ssub_match sub_match = line_match[i];
                std::string piece = sub_match.str();
                std::cout << "  submatch " << i << ": " << piece << '\n';
				std::cout << std::flush;
            }   
        }
	}
}
