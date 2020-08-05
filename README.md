# Engine Binaries
This branch contains precompiled flutter engine binaries (and include files) for use on the Raspberry Pi.

## Installation
If you want to install the flutter engine on your Pi, do the following steps:

1. `git clone --depth 1 --branch engine-binaries https://github.com/ardera/flutter-pi.git`
2. `sudo cp ./libflutter_engine.so ./icudtl.dat /usr/lib`
3. `sudo cp ./flutter_embedder.h /usr/include`
4. Done! You can now compile and run flutter-pi on your Raspberry Pi.

## build parameters
The engine is built using tip-of-tree llvm/clang 10 and libcxx. The following args are passed to _gn_:
```bash
--target-triple arm-linux-gnueabihf
--linux-cpu arm
--runtime-mode debug
--embedder-for-target
--lto
--target-os linux
--arm-float-abi hard
```
