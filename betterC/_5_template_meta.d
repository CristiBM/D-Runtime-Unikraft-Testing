unittest
{
    import std.traits : isFloatingPoint;
    import std.uni : toUpper;
    import std.string : format;
    import std.stdio : writeln;

    /*
     * A Vector that just works for
     * numbers, integers or floating points.
     */
    struct Vector3(T)
      if (is(T: real))
    {
    private:
        T x,y,z;

        mixin template GetterSetter(string var) {
            mixin("T get%s() const { return %s; }"
              .format(var.toUpper, var));

            mixin("void set%s(T v) { %s = v; }"
              .format(var.toUpper, var));
        }

        /*
         * Easily generate getX, setX etc.
         * functions with a mixin template.
        */
        mixin GetterSetter!"x";
        mixin GetterSetter!"y";
        mixin GetterSetter!"z";

    public:
        static if (isFloatingPoint!T) {
            T dot(Vector3!T rhs) {
                return x * rhs.x + y * rhs.y +
                    z * rhs.z;
            }
        }
    }

    auto vec = Vector3!double(3,3,3);
    auto vec2 = Vector3!double(4,4,4);
    assert(vec.dot(vec2) == 36);

    auto vecInt = Vector3!int(1,2,3);
    vecInt.setX(3);
    vecInt.setZ(1);
    assert(vecInt.getX == 3 && vecInt.getY == 2 && vecInt.getZ == 1);

    writeln("Test #5 passed");
}

