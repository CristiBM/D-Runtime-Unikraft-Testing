unittest
{
    import std.variant : Variant;

    struct C {
        void callA(int i, int j) {
            assert(i == 1);
            assert(j == 2);
        }

        void callB(string s) {
            assert(s == "ABC");
        }
    }

    struct CallLogger(C) {
        C content;
        void opDispatch(string name, T...)(T vals) {
            mixin("content." ~ name)(vals);
        }
    }

    struct var {
        private Variant[string] values;

        @property
        Variant opDispatch(string name)() const {
            return values[name];
        }

        @property
        void opDispatch(string name, T)(T val) {
            values[name] = val;
        }
    }

    import std.stdio : writeln;

    var test;
    test.foo = "test";
    test.bar = 50;
    test.foobar = 3.1415;

    assert(test.foo == "test");
    assert(test.bar == 50);
    assert(test.foobar == 3.1415);

    /*
     * Do not modify parameters
     */
    CallLogger!C l;
    l.callA(1, 2);
    l.callB("ABC");

    writeln("Test #2 passed");
}

