#include <iostream>
#include <bitset>
#include <range/v3/all.hpp>

namespace rg = ranges;
namespace rv = ranges::view;
namespace ra = ranges::action;

const std::vector<std::vector<unsigned char>> Tiles{
	{0b0'011'110,0b0'000'000,0b0'000'000,0b0'000'000},
	{0b0'001'000,0b0'011'100,0b0'001'000,0b0'000'000},
	{0b0'011'100,0b0'000'100,0b0'000'100,0b0'000'000},
	{0b0'010'000,0b0'010'000,0b0'010'000,0b0'010'000},
	{0b0'011'000,0b0'011'000,0b0'000'000,0b0'000'000}
};

int main (void) {
	const auto moves = rg::getlines(std::cin)
	                 | rv::join
	                 | rv::transform([](int c)->short{return (c == '<');})
	                 | rg::to_vector;

	std::array<unsigned char, 4096> Board{0};

	const std::array<int, 5> TS{1,3,3,4,2};
	auto D = moves | rv::cycle;
	auto Di = D.begin();
	auto T = Tiles | rv::cycle;
	auto Ti = T.begin();
	auto S = TS | rv::cycle;
	auto Si = S.begin();
	auto B = Board | rv::cycle;
	auto Bi = B.begin();

	auto move = [](auto& t, char d) -> bool {
		auto m = (d)? 0b01'000'000 : 0b00'000'001;
		for(const auto&l : t) if(l&m) return false;
		if(d) {
			for(auto& l : t) l <<= 1;
		}else{
			for(auto& l : t) l >>= 1;
		}
		return true;
	};

	auto touch = [&](const auto& t, const auto& p) {
		if(Board.size() - p <= 4){
			for(int i = 0; i < 4; ++i){
				if(t[i]&Board[(p+i)%Board.size()]) return true;
			}
		}else{
			for(int i = 0; i < 4; ++i){
				if(t[i]&Board[p+i]) return true;
			}
		}
		return false;
		//for(const auto& [lt, lp] : rv::zip(t | rv::all, rg::counted_view(p, t.size()) )){
		//	if(lt&lp) return true;
		//}
		//return false;
	};

	auto set = [&](const auto& t, const auto& p) {
		if((Board.size() - p) <= 4){
			for(int i = 0; i < 4; ++i){
				Board[(p+i)%Board.size()] |= t[i];
			}
		}else{
			for(int i = 0; i < 4; ++i){
				Board[p+i] |= t[i];
			}
		}
		//for(auto&& [lt, lp] : rv::zip(t | rv::all, rg::counted_view(p, t.size()) )){
		//	lp |= lt;
		//}
	};
	auto unset = [&](const auto& t, const auto& p) {
		if((Board.size() - p) <= 4){
			for(int i = 0; i < 4; ++i){
				Board[(p+i)%Board.size()] &= ~t[i];
			}
		}else{
			for(int i = 0; i < 4; ++i){
				Board[p+i] &= ~t[i];
			}
		}
		//for(auto&& [lt, lp] : rv::zip(t | rv::all, rg::counted_view(p, t.size()) )){
		//	lp &= ~lt;
		//}
	};

	auto show = [](const auto& a) {
		for(const auto& l : a | rv::reverse){
			std::cout << std::bitset<8>{l} << '\n';
		}
	};

	int l = 1;
	std::int64_t N = 1'000'000'000'000;//= 1'000'000'000;//1'000'000'000'000
	rg::fill(Board, 0b0'000'000);
	Board.back() = 0b1'111'111;
	auto p = Bi;
	int cc = 0;
	std::int64_t sz{0};
	while(N--) {
		auto t = *Ti++;
		int dz = 0;
		auto p = sz%Board.size();
		for(int i = 0; i < 7; ++i)
			Board[(p+i)%Board.size()] = 0;
		//rg::fill_n(p, 3+4, 0b0'000'000);
		p = (p+3)%Board.size();
		dz += 3;
		do {
			auto d{*Di++};
			//std::cout << " ------ \n";
			//set(t, p);
			//show(Board);
			//unset(t, p);
			//std::cout << "  . \n";
			if(move(t, d) && touch(t, p)) move(t , !d);
			//set(t, p);
			//show(Board);
			//unset(t, p);
			p = (p + (Board.size()-1)) % Board.size();
			dz -= 1;
		}while(!touch(t, p));
		p += 1;
		dz += 1;
		set(t, p);
		dz += *Si++;//t.size();
		if(dz > 0) sz += dz;
		//sz = std::max(z, sz);
		//show(Board);
		//std::cout << "\n";
	}
	//show(Board);
	//for(auto r : Board | rv::reverse) {
	//	std::bitset<8>  b{r};
	//	std::cout << b << '\n';
	//}
	//std::cout << (p - B.begin() ) << '\n';
	std::cout << sz << '\n';
	return EXIT_SUCCESS;
}
