unittest
{
    import std.container.binaryheap;
    import std.algorithm.comparison : equal;
    import std.range : take;
    import std.stdio;

    auto maxHeap = heapify([4, 7, 3, 1, 5]);
    assert(maxHeap.take(3).equal([7, 5, 4]));

    auto minHeap = heapify!"a > b"([4, 7, 3, 1, 5]);
    assert(minHeap.take(3).equal([1, 3, 4]));

    int[] a = [ 4, 1, 3, 2, 16, 9, 10, 14, 8, 7 ];
    auto h = heapify(a);
    assert(equal(a, [ 16, 14, 10, 8, 7, 9, 3, 2, 4, 1 ]));

    int[] b = [4, 1, 3, 2, 16, 9, 10, 14, 8, 7];
    auto top5 = heapify(b).take(5);
    assert(top5.equal([16, 14, 10, 9, 8]));

    // Red-Black trees
    import std.range : iota;
    import std.container.rbtree;
    auto maxTree = redBlackTree!"a > b"(iota(5));
    assert(equal(maxTree[], [4, 3, 2, 1, 0]));

    auto rbt2 = redBlackTree(1, 3);
    assert(equal(rbt2[], [1, 3]));

    // Doubly-linked lists
    import std.container : DList;
    auto nl = DList!int([1, 2, 3, 4, 5]);
    for (auto rn = nl[]; !rn.empty;)
        if (rn.front % 2 == 0)
            nl.popFirstOf(rn);
        else
            rn.popFront();
    assert(equal(nl[], [1, 3, 5]));
    auto rs = nl[];
    rs.popFront();
    nl.remove(rs);
    assert(equal(nl[], [1]));

    writeln("Test #8 passed");
}
