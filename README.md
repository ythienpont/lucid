# Future Internet: Lucid
This repository contains the resources for the **Future Internet 2024-2025** presentation by Judith Hershko and Yonah Thienpont. Included in this repository are:
- The [demo code](https://github.com/ythienpont/lucid/tree/main/examples) used in the presentation
- A [document](https://github.com/ythienpont/lucid/blob/main/paper_future_internet.pdf) containing instructions to run it
- A [cheatsheet](https://github.com/ythienpont/lucid/blob/main/cheatsheet/cheatsheet.pdf) of the Lucid language
- The slides of the presentation

## About Lucid
Lucid is a high-level programming language designed to simplify the development of control applications in the data plane. By abstracting the complexities of languages like P4, Lucid enables:
- **Interleaved control and packet processing logic**
- **High-level abstractions** for events, handlers, and arrays
- Programs that are **hardware-constrained by construction**, ensuring correctness

## Install Lucid
Follow the installation instructions provided in the [Lucid repository](https://github.com/PrincetonUniversity/lucid/blob/main/readme.md).

### Running the Interpreter
The Lucid interpreter can be run using a Docker container. To run a Lucid program:

```bash
./docker_lucid.sh interpret <lucid program name>
```

This command type-checks your program and runs it in a simulated network, as defined by your specification file.

Try our [demo programs](https://github.com/ythienpont/lucid/tree/main/examples) by copying it inside the Lucid repository or you can start experimenting yourself with one of the tutorial programs ([monitor.dpt](https://github.com/PrincetonUniversity/lucid/blob/main/tutorials/interp/01monitor/monitor.dpt)).

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
