/*
 * Module System
 */
unittest
{
    import A;
    import B;
    import C;
    import D;

    import core.stdc.stdio;

    alias foo = B.foo;

    assert(foo() == "B");   // call B.foo()
    assert(A.foo() == "A"); // call A.foo()
    assert(B.foo() == "B"); // call B.foo()
    assert(C.test() == "A.bar"); // calls A.bar()
    D.test();

    printf("Test betterC #8 passed\n");
}

/*
 * C++ interfacing
 */
extern (C++) int sum(int i, int j, int k);
unittest
{
    import core.stdc.stdio;

    assert (sum(1, 2, 3) == 6);

    printf("Test betterC #7 passed\n");
}

/*
 * scope(exit)
 */
unittest
{
    import core.stdc.stdio;
    void f() {
        struct Foo
        {
            int x = 0;

            this(int i) { x = i; }
            ~this() { assert(x == 3); }
        }
        Foo f = Foo(1);
        {
            scope(exit)
            {
                assert(f.x == 2);
                f.x++;
            }
            /*
             * executes when the scope exits due to exception unwinding
             * Since we don't have exceptions in betterC, we'll observe
             * that these are never executed
             *
             * scope(success) also doesn't work
             */
            //scope(failure) printf("4");
            scope(exit)
            {
                assert(f.x == 1);
                f.x++;
            }
        }
    }

    f();

    printf("Test betterC #6 passed\n");
}

/*
 * Switch
 */
unittest
{
    import core.stdc.stdio;

    string f() {
        int s = 12;
        final switch (s) {
            case 22 : return "a";
            case 12 : return "b";
        }
    }
    assert(f() == "b");

    printf("Test betterC #5 passed\n");
}


/*
 * Lambdas
 */
unittest
{
    import core.stdc.stdio;

    int i = 3;
    auto twice  = function (int x) => x * 2;
    auto square = delegate (int x) => x * x;

    assert(twice(i) == 6);
    assert(square(i) == 9);

    printf("Test betterC #4 passed\n");
}


/*
 * Delegates and functions
 */
int myGlobalF(int x) {
    return 234 ^^ 2;
}

int aFunction(int delegate(int function(int)) f) {
    return f(&myGlobalF);
}

struct ARandomClass {
  int attr;

  this(int attr) {
    this.attr = attr;
  }

  /*
   * As u can see, this method uses the attr attribute, so in order to actually work,
   * its context must also be known; this is not the case for 'function' types, but it
   * is the case for 'delegate' type
   */
  int aRandomFunction(int function(int) f) {
      return f(attr);
  }
}

unittest
{
    import core.stdc.stdio;

    ARandomClass a = ARandomClass(234);
    assert(a.aRandomFunction(&myGlobalF) == 54756);
    assert(aFunction(&a.aRandomFunction) == 54756);

    printf("Test betterC #3 passed\n");
}


/*
 * Nested functions
 */
unittest
{
    import core.stdc.stdio;

    int outterF() {
        int innerF() {
            struct Outter {
                this(int i) {
                    this.i = i;
                }

                struct Inner {
                    string data;
                    int idx = 5;
                };
                int i;
                Inner instance;
            }
            Outter var = Outter(2);
            return var.instance.idx + var.i;
        }
        return innerF();
    }

    assert(outterF() == 7);
    printf("Test betterC #2 passed\n");
}


/*
 * Conditional compilation
 */
version(full)
{
    void extraFunctionality()
    {
        assert(0);
    }
}
else // demo
{
    version = feature;
    void extraFunctionality()
    {
        assert(1);
    }
}

void testVersion() {
    version(feature)
        assert(true);
    else
        assert(false);
}

unittest
{
    import core.stdc.stdio;
    extraFunctionality();
    testVersion();

    // StaticIfCondition + Templates
    template INT(int i)
    {
        static if (i == 32)
            alias INT = int;
        else static if (i == 16)
            alias INT = short;
        else
            static assert(0); // not supported
    }
    INT!(16) a;  // a is a short

    assert(a.sizeof == 2);

    printf("Test betterC #1 passed\n");
}

extern (C) void main() {
    static foreach(u; __traits(getUnitTests, __traits(parent, main)))
        u();
}
