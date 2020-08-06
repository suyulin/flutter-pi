# Engine Binaries
This branch contains precompiled flutter engine binaries, header files for use on the Raspberry Pi.

## NEWS
- The layout of this repo changed a bit.
- I now provide 2 versions of the engine, one debug version and one release version.
- Flutter-pi still just loads `libflutter_engine.so` and expects the engine it finds behind that to be the one fitting to its runtime mode.
I.e., if flutter-pi is started with the `--release` flag, the engine flutter-pi expects to find is `libflutter_engine.so.release`.
- It's best to just create a symlink from `/usr/lib/libflutter_engine.so` to the version of the engine you'd like to use, like I explained below.
- `gen_snapshot_linux_x64` is for building the `app.so` to run your App in release mode. The binary must be executed on a Linux x64 machine. (If you're on Windows, just use WSL)

## Installation
If you want to install the flutter engine on your Pi, do the following steps:

1. Install the binaries:
```
$ git clone --depth 1 --branch engine-binaries https://github.com/ardera/flutter-pi.git
$ sudo cp ./libflutter_engine.so.{debug,release} ./icudtl.dat /usr/lib
$ sudo cp ./flutter_embedder.h /usr/include
```

2. Choose the version of `libflutter_engine.so` you'd like to use.
Use `libflutter_engine.so.release` if you'd like to run flutter-pi with the `--release` flag to run Apps in release mode.
Otherwise, use `libflutter_engine.so.debug`.

3. Then, create a symbolic link from `/usr/lib/libflutter_engine.so` to your chosen version of the engine. Like so (for the debug engine):
```
$ sudo ln -sr /usr/lib/libflutter_engine.so.release /usr/lib/libflutter_engine.so
```

## build parameters
The engine is built using tip-of-tree llvm/clang 10 and libcxx. The following args are passed to _gn_:
```bash
--target-triple arm-linux-gnueabihf
--linux-cpu arm
--embedder-for-target
--no-lto
--target-os linux
--arm-float-abi hard
```
