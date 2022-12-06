#include <iostream>

int main (void) {
	auto inside = [](int s1, int e1, int s2, int e2) {
		return (s1 <= s2) && (e1 >= e2);
	};
	auto tailed = [](int s1, int e1, int s2, int e2) {
		return (s1 <= e2) && (e1 >= s2);
	};
	int c1{0}, c2{0};
	for(int s1,e1,s2,e2;
		scanf("%d-%d,%d-%d",&s1,&e1,&s2,&e2) != EOF;) {
		c1 += inside(s1,e1,s2,e2) || inside(s2,e2,s1,e1);
		c2 += tailed(s1,e1,s2,e2) || tailed(s2,e2,s1,e1);
	}
	std::cout << c1 << '\n';
	std::cout << c2 << '\n';
	return EXIT_SUCCESS;
}
