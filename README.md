# Docker-Compiler-Packager
A CI/CD Pipeline that demonstrates Docker Containers compiling c/c++ from chosen URL or given schedule.

- Compiles code for chosen OS
- Saves packaged code as artifacts
- Pushes _source & _compiled images to repo:

## Workflow Steps:
1] Configure environment variables
- Set SHA/hash variables
- Create a $TIMESTAMP with $WORK_WEEK & $COMMIT_HASH variables
- Set Source Repo version control variables
- Attach $TIMESTAMP to $REPO_NAME
- Set the working directory for $REPO_CHECKOUT
- Set CMake Flags

2] Checkout
- Checkout 1ndevelopment/Docker-Compiler-Packager
- Checkout $REPO_CHECKOUT

3] Build image
- Build $DOCKER_SOURCE_IMG_source:$DOCKER_TAG
- Push $DOCKER_SOURCE_IMG_source:$DOCKER_TAG to $DOCKER_REPO_HOST

4] Compile chosen source within container
- Determine Compiling Container for $REPO_CHECKOUT
- Compile $REPO_CHECKOUT in /$REPO_NAME_TIMESTAMP directory
- Commit changes from container to image
- Change Image Name from $DOCKER_SOURCE_IMG_source to $DOCKER_SOURCE_IMG_compiled
- Push $DOCKER_SOURCE_IMG_compiled:$DOCKER_TAG to $DOCKER_REPO_HOST
- Upload packaged build as an artifact

5] Cleanup

- Cleanup workspace, remove images

## Image naming convention:

$REPO_NAME-$REPO_BRANCH_cmake.$CMAKE_VERSION_$COMMIT_HASH_$STATE:$DOCKER_TAG

Example:\
c-example-main_24ww24.4_cmake.2.29.6_cg7305a_source:latest\
c-example-main_24ww24.4_cmake.2.29.6_cg7305a_compiled:latest

## Container naming convention:

$REPO_NAME-$REPO_BRANCH:$DOCKER_TAG

Example:\
c-example-main:latest
