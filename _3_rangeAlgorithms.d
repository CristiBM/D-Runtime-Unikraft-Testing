
unittest
{
    import std.algorithm : canFind, count, equal, map,
      filter, sort, uniq, joiner, chunkBy, splitter;
    import std.array : array, empty;
    import std.range : zip;
    import std.stdio : writeln;
    import std.string : format;

    string text = q{This tour will give you an
overview of this powerful and expressive systems
programming language which compiles directly
to efficient, *native* machine code.};

    string res = q{2 -> an, of, to
3 -> and, you
4 -> This, code, give, this, tour, will
5 -> which
7 -> machine, systems
8 -> *native*, compiles, directly, language, overview, powerful
9 -> efficient
10 -> expressive
11 -> programming};

    alias pred = c => canFind(" ,.\n", c);
    auto words = text.splitter!pred
      .filter!(a => !a.empty);

    auto wordCharCounts = words
      .map!(a => a.count);

    /*
     * Output the character count
     * per word in a nice way
     * beginning with least chars!
     */
    assert(zip(wordCharCounts, words)
      .array()
      .sort()
      .uniq()
      .chunkBy!(a => a[0])
      .map!(chunk => format("%d -> %s",
          chunk[0],
          chunk[1]
            .map!(a => a[1])
            .joiner(", ")))
      .joiner("\n")
      .equal(res));

    writeln("Test #3 passed");
}
