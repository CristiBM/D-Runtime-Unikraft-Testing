unittest
{
    import std.functional : binaryFun;
    import std.range.primitives : empty, front,
        popFront,
        isInputRange,
        isForwardRange,
        isRandomAccessRange,
        hasSlicing,
        hasLength;
    import std.stdio : writeln;
    import std.traits : isNarrowString;

    /**
    Returns the common prefix of two ranges
    without the auto-decoding special case.

    Params:
        pred = Predicate for commonality comparison
        r1 = A forward range of elements.
        r2 = An input range of elements.

    Returns:
    A slice of r1 which contains the characters
    that both ranges start with.
     */
    auto commonPrefix(alias pred = "a == b", R1, R2)
                     (R1 r1, R2 r2)
    if (isForwardRange!R1 && isInputRange!R2 &&
        !isNarrowString!R1 &&
        is(typeof(binaryFun!pred(r1.front,
                                 r2.front))))
    {
        import std.algorithm.comparison : min;
        static if (isRandomAccessRange!R1 &&
                   isRandomAccessRange!R2 &&
                   hasLength!R1 && hasLength!R2 &&
                   hasSlicing!R1)
        {
            immutable limit = min(r1.length,
                                  r2.length);
            foreach (i; 0 .. limit)
            {
                if (!binaryFun!pred(r1[i], r2[i]))
                {
                    return r1[0 .. i];
                }
            }
            return r1[0 .. limit];
        }
        else
        {
            import std.range : takeExactly;
            auto result = r1.save;
            size_t i = 0;
            for (;
                 !r1.empty && !r2.empty &&
                 binaryFun!pred(r1.front, r2.front);
                 ++i, r1.popFront(), r2.popFront())
            {}
            return takeExactly(result, i);
        }
    }

    assert(commonPrefix("The end of the world"d,
                         "The end ought to be close"d) == "The end o");

    writeln("Test #6 passed");
}
