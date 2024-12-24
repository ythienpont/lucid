# Lucid

# Notes to myself
- dpt stands for data plane threads and is the alternative name for lucid
- lucid is event/handler based
- Tofino is a P4-programmable Ethernet switch ASIC (Application-specific integrated circuit).
    It is the main focus of the language since their developers have lots of experience with it
- docker script only works in the lucid repo, fix this.


## Lucid Installation
### Install from source
1. Install opam, a source-based package manager for OCaml
Caml (originally an acronym for Categorical Abstract Machine Language) is a multi-paradigm, general-purpose, high-level, functional programming language which is a dialect of the ML (meta-language) programming language family. OCaml (formerly Objective Caml) is a general-purpose, high-level, multi-paradigm programming language which extends the Caml dialect of ML with object-oriented features.

[Instructions for opam install](https://opam.ocaml.org/doc/Install.html)

The quickest way to get the latest opam up and working is to run this script:
```bash
bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
```

2. Add an OCaml 4.12 switch (TODO: elaborate why)
```bash
opam switch create 4.12.0
opam switch 4.12.0
```

3. Clone the Lucid repository
Clone the [Lucid repository](https://github.com/PrincetonUniversity/lucid)

```bash
git clone git@github.com:PrincetonUniversity/lucid.git
```

4. Install Lucid dependencies
```bash
cd lucid
opam install --deps-only .
```
5. build lucid with make
```bash
make
```

### Install script
On a Linux machine (with sudo access), you should be able to do:
```bash
./install_dependencies.sh
make
```
to install all the dependencies from scratch (i.e., including opam, ocaml, etc.) and build the Lucid interpreter (`dpt`) and tofino compiler (`dptc`).

### Docker
There is also a fairly lightweight docker image that can run the Lucid interpreter and Tofino compiler. 

**1. Install docker**
  - if you are on a laptop/desktop, just install the docker desktop app: [docker desktop](https://www.docker.com/products/docker-desktop/)
  - if you are on a server... you can probably figure out how to install docker

**2. Clone the Lucid Repository and pull the lucid docker container**

Run this in your terminal:
```
git clone https://github.com/PrincetonUniversity/lucid/
cd lucid
./docker_lucid.sh pull
```

This will download about 400MB of data and should take < 5 minutes. 

Once finished, you can run `./docker_lucid.sh interpret` to run the interpreter or `./docker_lucid.sh compile` to run the Tofino compiler. The `docker_lucid` script takes care of forwarding all arguments, files, and directories to / from the docker image.

## Run the Lucid interpreter

Using the docker container, you can run the interpreter with `./docker_lucid.sh interpret <lucid program name>`. The interpreter type checks your program, then runs it in a simulated network defined by a specification file. 

Try it out with one of the tutorial programs ([monitor.dpt](https://github.com/PrincetonUniversity/lucid/blob/main/tutorials/interp/01monitor/monitor.dpt)):

```
jsonch@jsonchs-MBP lucid % ./docker_lucid.sh interp tutorials/interp/01monitor/monitor.dpt
# ... startup output elided ...
t=0: Handling event eth_ip(11,22,2048,1,2,128) at switch 0, port 0
t=600: Handling event prepare_report(11,22,2048,1,2,128) at switch 0, port 196
sending report about packet {src=1; dst=2; len=128} to monitor on port 2
dpt: Final State:

Switch 0 : {

 Pipeline : [ ]

 Events :   [ ]

 Exits :    [
    eth_ip(11,22,2048,1,2,128) at port 1, t=600
    report(1,2,128) at port 2, t=1200
  ]

 Drops :    [ ]

 packet events handled: 0
 total events handled: 2

}
```

### Run the compiler

Finally, to compile Lucid programs to P4 for the Intel tofino, run the compiler with `./docker_lucid.sh compile <lucid program name> -o <build directory name>`.

The compiler translates a Lucid program into P4, optimizes it, and produces a build directory with a P4 program, Python control plane, and a directory that maps control-plane modifiable Lucid object names to their associated P4 object names. 
Try it out with the tutorial application: 

```
jsonch@jsonchs-MBP lucid % ./docker_lucid.sh compile tutorials/interp/01monitor/monitor.dpt -o monitor_build
build dir: monitor_build
build dir: /Users/jsonch/Desktop/gits/lucid/monitor_build
# ... output elided ...
[coreLayout] placing 41 atomic statement groups into pipeline
.........................................
[coreLayout] final pipeline
--- 41 IR statements in 3 physical tables across 2 stages ---
stage 0 -- 2 tables: [(branches: 3, IR statements: 25, statements: 25),(branches: 4, IR statements: 13, statements: 13)]
stage 1 -- 1 tables: [(branches: 4, IR statements: 3, statements: 3)]
Tofino backend: -------Layout for egress: wrapping table branches in functions-------
Tofino backend: -------Layout for egress: deduplicating table branch functions-------
Tofino backend: -------Translating to final P4-tofino-lite IR-------
Tofino backend: -------generating python event parsing library-------
Tofino backend: -------generating Lucid name => P4 name directory-------
Tofino backend: -------printing P4 program to string-------
Tofino backend: -------printing Python control plane to string-------
compiler: Compilation to P4 finished. Writing to build directory:/app/build
local p4 build is in: /Users/jsonch/Desktop/gits/lucid/monitor_build
jsonch@jsonchs-MBP lucid % ls monitor_build
eventlib.py     libs            lucid.p4        manifest.txt
globals.json    logs            lucid.py        scripts
layout_info.txt lucid.cpp       makefile        src
jsonch@jsonchs-MBP lucid % cat monitor_build/manifest.txt 
Lucid-generated tofino project folderContents: 
lucid.p4 -- P4 data plane program
lucid.py -- Python script to install multicast rules after starting lucid.p4
eventlib.py -- Python event parsing library
globals.json -- Globals name directory (maps lucid global variable names to names in compiled P4)
makefile -- simple makefile to build and run P4 program
lucid.cpp -- c control plane (currently unused)
```

## Configuring the network
The Lucid interpreter type checks a lucid program and optionally runs the program in a simulated network. You configure the simulation with a interpreter specification file, which is typically defined in `<progname>.json`.

For more information on the specification files, read the [docs](https://github.com/PrincetonUniversity/lucid/wiki/02-Lucid-interpreter#specification-file).

## Syntax Highlighting
### VSCode

There is a VSCode syntax highlighter for Lucid [here](https://github.com/benherber/Lucid-DPT-VSCode-Extension)

### Treesitter
If you want to add the C syntax highlighting for dpt, you can add this to your nvim config 
```lua
vim.treesitter.language.register('c', 'dpt')

vim.filetype.add({
  extension = {
    dpt = 'dpt',
  },
})
```
