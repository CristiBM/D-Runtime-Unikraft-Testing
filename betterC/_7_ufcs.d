unittest
{
    import std.stdio : writefln, writeln;
    import std.algorithm.iteration : filter;
    import std.algorithm.comparison : cmp;
    import std.range : iota;

    assert(cmp(10.iota.filter!(a => a % 2 == 0), [0, 2, 4, 6, 8]) == 0);

    assert(cmp(filter!(a => a % 2 == 0)(iota(10)), [0, 2, 4, 6, 8]) == 0);

    "Test%s".writefln(" #7 passed");
}
