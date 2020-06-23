
unittest
{
    import std.stdio : writeln;

    auto calculate(string op, T)(T lhs, T rhs)
    {
        return mixin("lhs " ~ op ~ " rhs");
    }


    // pass the operation to perform as a
    // template parameter.
    assert(calculate!"+"(5,12) == 17);
    assert(calculate!"-"(10,8) == 2);
    assert(calculate!"*"(8,8) == 64);
    assert(calculate!"/"(100,5) == 20);

    mixin(`writeln("Test #1 passed");`);
}
