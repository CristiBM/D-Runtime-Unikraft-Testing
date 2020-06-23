unittest
{
    import core.stdc.stdio;

    enum LOCAL_DATA_NUM = 1000;
    enum INSTANCES_NUM = 10000;

    class ARandomClass {
        int counter = 0;
        int[LOCAL_DATA_NUM] data;


        this(){}

        void method1() {
            for (int i = 0; i < LOCAL_DATA_NUM; i++) {
                ulong temp = ((LOCAL_DATA_NUM - 1) * (LOCAL_DATA_NUM - 1)
                        * (LOCAL_DATA_NUM - 1) * i);
                data[i] = temp % cast(ulong)(int.max);
            }
        }

        void  method2() {
            ulong temp = ((LOCAL_DATA_NUM - 1) * (LOCAL_DATA_NUM - 1)
                        * (LOCAL_DATA_NUM - 1) * counter);

            assert(data[counter] == temp % cast(ulong)(int.max));
        }
    }

    ARandomClass[] instancesArray = new ARandomClass[INSTANCES_NUM];
    for (int i = 0; i < INSTANCES_NUM; i++) {
        instancesArray[i] = new ARandomClass;
        assert(instancesArray[i]);
        int[] array = new int[10];
        instancesArray[i].method1();
    }

    for (int i = 0; i < INSTANCES_NUM; i++) {
        for (int j = 0; j < LOCAL_DATA_NUM - 1; j++) {
            assert(instancesArray[i]);
            instancesArray[i].method2();
        }
    }

    printf("Test #9 passed\n");
}

