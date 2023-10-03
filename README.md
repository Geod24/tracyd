# Tracy for D

This is a small wrapper around [Tracy](https://github.com/wolfpld/tracy) profiler
for the D programming language.

## Documentation

[Documentation](https://github.com/wolfpld/tracy/releases/latest/download/tracy.pdf) for usage and build
instructions of the Tracy. TracyD does not come with special documentation.

## Profiling a program execution

Just import `tracyd` module, run the program and open Tracy. Only CPU is profiled by default.

```D
import tracyd;

void main ()
{
    // Your code
}
```

### Integrating into your build system

Using Tracy requires building the C++ library.
It is recommended to use either a git submodule or a copy of Tracy in your application.
Provided you have done so, you would need to call the `Makefile` (or replicate it)
to build Tracy, and add the resulting object file to your `sourceFiles`.
A future version will make this step easier.

### Profiling the memory

TracyD includes a modified version of Druntime's conservative GC to trace memory allocations. Memory allocations can be traced when the linked program is executed
with the `--DRT-gcopt="gc:tracking-conservative"` parameter.

```Bash
$ ./program --DRT-gcopt="gc:tracking-conservative"
