unittest
{
    import std.bigint : BigInt;

    /**
     * Computes the power of a base
     * with an exponent.
     *
     * Returns:
     *     Result of the power as an
     *     arbitrary-sized integer
     */
    BigInt bigPow(uint base, uint power) pure
    {
        BigInt result = 1;

        foreach (_; 0 .. power)
            result *= base;

        return result;
    }

    import std.datetime.stopwatch : benchmark;
    import std.functional : memoize,
        reverseArgs;
    import std.stdio : writefln, writeln;

    alias fastBigPow = memoize!(bigPow);

    void test()
    {
        assert(fastBigPow(5, 10000).uintLength == 726);
    }

    foreach (i; 0 .. 10) {
        real time = benchmark!test(1)[0].total!"usecs"/1000.0;
        if (i)
            assert(time < 0.5);
        else
            assert(time > 5);
    }

    writeln("Test #0 passed");
}

