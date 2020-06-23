unittest
{
    import std.stdio : writefln, writeln;

    int value = 0;
    scope(exit)
    {
        scope(success)
            assert(value == 4);
        assert(value == 3);
        scope(exit)
        {
            assert(value == 4);
        }
        assert(value == 3);
        value = 4;
    }
    assert(value == 0);
    value = 1;
    scope(exit)
    {
        assert(value == 2);
        value = 3;
    }

    assert(value == 1);

    import core.stdc.stdlib : free, malloc;
    int* p = cast(int*) malloc(int.sizeof);
    scope(exit)
    {
        free(p);
        assert(value == 1);
        value = 2;
    }

    writeln("Test #4 passed");
}
