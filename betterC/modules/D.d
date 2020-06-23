module D;

import A;
import B;

void test()
{
    //foo();   // error, A.foo() or B.foo() ?
    assert(A.foo() == "A"); // ok, call A.foo()
    assert(B.foo() == "B"); // ok, call B.foo()
}
