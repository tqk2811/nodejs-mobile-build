
### Usage example
Run `chmod +x build.mjs` and then `./build.mjs arm64 24` this will build for ARMv8 architecture with API version 24. To utilize multiple threads of your cpu edit line 111 on `build.mjs` replacing `make -j1` with `make -j[no. threads]` i.e. I use `make -j16` with my Ryzen 7.
