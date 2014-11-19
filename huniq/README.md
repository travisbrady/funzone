huniq
=====

A very simple HyperLogLog-based way to count unique strings. 
No external depencies, tiny executable, easily hackable code.

Hyperloglog code is from: https://github.com/armon/hlld

The same idea as:
```bash
$ cat some_file | sort -u | wc -l
```

Build it:
```bash
$ make
```

Run:
```
$ cat fake_data | ./huniq
```
