# Docker-Compiler-Packager
A CI/CD Pipeline that demonstrates compiling &amp; packaging

## Workflow Steps:

-- Set SHA/hash variables
- Create a $TIMESTAMP with $WORK_WEEK & $COMMIT_HASH variables
- Set Source Repo version control variables
- Attach $TIMESTAMP to $REPO_NAME
- Set the working directory for $REPO_CHECKOUT
- Set CMake Flags

- Checkout 1ndevelopment/Actions-Packager-Example
- Checkout $REPO_CHECKOUT

- Build <<REPO.NAME>>-<<REPO.BRANCH>>_<<WORK.WEEK>>_<<CMAKE.VERSION>>_<<COMMIT.SHA>>_source:<<DOCKER.TAG>>
* uses docker build against ./cmake_gen/Dockerfile

- Push c-example-main_24ww24.4_cmake.2.29.6_cg7305a_source:latest to $DOCKER_REPO_HOST

- Compile $REPO_CHECKOUT in $DOCKER_IMG_NAME container
- Determine Compiling Container for $REPO_CHECKOUT
- Compile $REPO_CHECKOUT in /$REPO_NAME_TIMESTAMP directory
- Commit changes from container to image
- Change Image Name from _source to _compiled

- Push _compiled image to $DOCKER_REPO_HOST

- Upload packaged build as an artifact

- Cleanup workspace, remove images