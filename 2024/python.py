def d01a(lines: list[str]):
    lists = map(sorted, zip(*[map(int, x.split()) for x in lines]))
    return sum(abs(x - y) for x, y in zip(*lists))


def d01b(lines: list[str]):
    from collections import Counter

    a, b = [*map(Counter, zip(*map(str.split, lines)))]
    return sum(int(k) * v * b.get(k, 0) for k, v in a.items())
