#define BUILDING_NODE_EXTENSION
//#define NODE_ADDON_API_DISABLE_DEPRECATED
#include <node.h>
//#include <node/node_api.h>
//#include <napi.h>
#include <nan.h>

NAN_METHOD(Hello)
{
    auto message = Nan::New("Hello from C++!").ToLocalChecked();
    info.GetReturnValue().Set(message);
}

NAN_MODULE_INIT(InitAll)
{
    NAN_EXPORT(target, Hello);
}

NODE_MODULE(addon, InitAll)