# Cpp-Docker development container

A C/C++ development container for [Visual Studio Code](https://code.visualstudio.com/) with [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension. It is a linux environment based on the latest LTS distribution of ubuntu by Docker. The provided c/c++ compiler is `clang` and comes with a few clang related tools. It is installed with [Oh My Bash](https://ohmybash.nntoan.com/). `CMake` and `ninja-build` is installed for building C/C++ applications. `Python3` and `pip` is provided for adding development tools from PyPi. `Python3-dev` is provided to help build python bindings.

## Example

To use as development container for your project create, `.devcontainer/devcontainer.json` to project with the content,

```r json
{
    "name": "",
    "image": "exterex/cpp-dev",
    "extensions": [
        "ms-vscode.cpptools",
        "ms-vscode.cmake-tools",
        "xaver.clang-format",
        "llvm-vs-code-extensions.vscode-clangd"
    ]
}
```

To customize user in container use,
```json
{
    "containerUser": "vscode",
    "updateRemoteUserUID": false
}
```

in additon to the codeblock above. `"updateRemoteUserUID": false` prevents container to rebuild to update GID/UID if `containerUser` or `remoteUser` is specified.


For configuration of `devcontainer.json` see [code.visualstudio.com](https://code.visualstudio.com/docs/remote/devcontainerjson-reference)

## Build

The image is updated every time the `main` branch of the repository is updated and on a fixed schedule (see [workflows/ci.yml](.github/workflows/ci.yml)).

## License

This repository is distributed under `GPLv3`. For more information see [LICENSE](LICENSE).
