#include <node.h>
#include <cstdio>
int main(int argc, char** argv)
{
    printf("hello");
    return node::Start(argc, argv);
}