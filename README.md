# Docker-Compiler-Packager
A CI/CD Pipeline that demonstrates Docker Containers compiling c/c++ from chosen URL or given Schedule

- Compiles code for chosen OS
- Pushes _source & _compiled images to repo
- Saves packaged code as artifacts

## Workflow Steps:
1] Configure environment variables
- Set SHA/hash variables
- Create a $TIMESTAMP with $WORK_WEEK & $COMMIT_HASH variables
- Set Source Repo version control variables
- Attach $TIMESTAMP to $REPO_NAME
- Set the working directory for $REPO_CHECKOUT
- Set CMake Flags

2] Checkout
- Checkout 1ndevelopment/Actions-Packager-Example
- Checkout $REPO_CHECKOUT

3] Build image &amp; compile source within container
- Build c-example-main_24ww24.4_cmake.2.29.6_cg7305a_source:latest

4] Compile chosen source within container
- Determine Compiling Container for $REPO_CHECKOUT
- Compile $REPO_CHECKOUT in /$REPO_NAME_TIMESTAMP directory

- Commit changes from container to image
- Change Image Name from _source to _compiled

5] Push &amp; Cleanup
- Push c-example-main_24ww24.4_cmake.2.29.6_cg7305a_source:latest to $DOCKER_REPO_HOST

- Push c-example-main_24ww24.4_cmake.2.29.6_cg7305a_compiled:latest to $DOCKER_REPO_HOST
- Upload packaged build as an artifact

- Cleanup workspace, remove images
