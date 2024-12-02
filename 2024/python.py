def d01a(lines: list[str]):
    lists = map(sorted, zip(*[map(int, x.split()) for x in lines]))
    return sum(abs(x - y) for x, y in zip(*lists))


def d01b(lines: list[str]):
    from collections import Counter

    a, b = [*map(Counter, zip(*map(str.split, lines)))]
    return sum(int(k) * v * b.get(k, 0) for k, v in a.items())


def d02a(lines: list[str]):
    from operator import sub

    parse = lambda x: map(int, x.split())
    diffs = lambda x: set(map(sub, g := [*x], g[1:]))
    valid = lambda x: not (x - {1, 2, 3}) or not (x - {-1, -2, -3})
    check = lambda x: valid(diffs(parse(x)))
    return sum(map(check, lines))


def d02b(lines: list[str]):
    from operator import sub

    parse = lambda x: [*map(int, x.split())]
    grows = lambda x: [x] + [x[:i] + x[i + 1 :] for i in range(len(x))]
    diffs = lambda x: set(map(sub, x, x[1:]))
    valid = lambda x: not (x - {1, 2, 3}) or not (x - {-1, -2, -3})
    check = lambda x: any(map(valid, map(diffs, grows(parse(x)))))
    return sum(map(check, lines))
