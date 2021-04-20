% MAKEPARALLEL(1)
% The Android Open Source Project

# NAME

makeparallel - command line tool for communication with the GNU make jobserver

# SYNOPSIS

To run a multi-thread or multi-process binary inside GNU make using
makeparallel, add:

```Makefile
	+makeparallel subprocess arguments
```
to a rule.  For example, to wrap ninja in make, use something like:
```Makefile
	+makeparallel ninja -f build.ninja
```
To determine the size of the jobserver pool, add:
```Makefile
	+makeparallel echo > make.jobs
```
to a rule that is guarantee to run alone (i.e. all other rules are either
dependencies of the makeparallel rule, or the depend on the makeparallel
rule.  The output file will contain the `-j<num>` flag passed to the parent
make process, or `-j1` if no flag was found.  Since GNU make will run
makeparallel during the execution phase, after all variables have been
set and evaluated, it is not possible to get the output of makeparallel
into a make variable.  Instead, use a shell substitution to read the output
file directly in a recipe.  For example:
```Makefile
	echo Make was started with $$(cat make.jobs)
```

# DESCRIPTION

`makeparallel` communicates with the [GNU make jobserver](http://make.mad-scientist.net/papers/jobserver-implementation/)
in order claim all available jobs, and then passes the number of jobs
claimed to a subprocess with `-j<jobs>`.

The number of available jobs is determined by reading tokens from the jobserver
until a read would block.  If the makeparallel rule is the only one running the
number of jobs will be the total size of the jobserver pool, i.e. the value
passed to make with `-j`.  Any jobs running in parallel with with the
makeparellel rule will reduce the measured value, and thus reduce the
parallelism available to the subprocess.

