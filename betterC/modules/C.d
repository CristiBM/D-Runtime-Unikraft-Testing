module C;

import A;

string foo()
{
    return "C";
}

string test()
{
    assert(foo() == "C"); // C.foo() is called, it is found before imports are searched
    return bar(); // A.bar() is called, since imports are searched
}
