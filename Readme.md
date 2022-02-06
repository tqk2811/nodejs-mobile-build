
### Usage example
Run
```
chmod +x build.mjs
```
and then 
```
./build.mjs arm64 24
```
this will build for ARMv8 architecture with API version 24. To utilize multiple threads of your cpu add a third argument indicating the number of threads you wanna use.

Platforms options:

| OPTION | PLATFORM | SUCCESSFUL BUILD |
--- | --- | --- |
| **arm** | ARMv7 | v17.4.0 |
| **ia32** | i686 |
| **x64** | x86-64 |
| **arm64** | ARMv8 | v17.4.0 |

