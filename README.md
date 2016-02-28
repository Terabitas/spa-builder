# Building

To build container:

```
docker build -t nildev/spa-builder:latest .
docker build -t quay.io/nildev/spa-builder:latest .
```

# How to use

Get `nildev` tool:
```
go get github.com/nildev/tools/cmd/nildev
```

Build container. If your app is in `$GOPATH` you can pass only path relative to `src`:
```
nildev build --spa github.com/nildev/account
```

If it is somewhere else:
```
nildev build --spa /full/path/to/dir
```

# How to debug

```
docker run --rm -it --net=host --entrypoint="bash" -v "/var/run/docker.sock:/var/run/docker.sock" -v "/Users/SteelzZ/Projects/Workspace/src:/src" -v "/Users/SteelzZ/Projects/NildevWorkspace/flux-bobas:/app-src" nildev/spa-builder:latest
cd /
./build.sh bitbucket.org/bobas/front github.com/nildev/spa-host bobas/front:latest
```