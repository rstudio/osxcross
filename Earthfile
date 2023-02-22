VERSION --wait-block --use-cache-command 0.6

ubuntu:
  FROM ubuntu:jammy
  WORKDIR /workspace
  ENV DEBIAN_FRONTEND=noninteractive
  RUN apt update
  RUN apt install -y build-essential wget curl git sudo cmake unzip zip

# clone osxcross and install dependencies
osxcross.deps:
  ARG --required sdk_version
  FROM +ubuntu
  WORKDIR osxcross
  COPY tools/get_dependencies.sh tools/get_dependencies.sh
  RUN tools/get_dependencies.sh
  COPY . .

# runs the build.sh script
osxcross.build:
  ARG --required sdk_version
  FROM +osxcross.deps --sdk_version=$sdk_version
  ENV UNATTENDED=1
  ENV SDK_VERSION=$sdk_version
  ENV TARGET_DIR=/osxcross
  CACHE /osxcross/build
  RUN ./build.sh
  SAVE ARTIFACT /osxcross
  ENV PATH=$PATH:/osxcross/bin

# runs the build_gcc.sh script
osxcross.gcc.amd64:
  ARG --required sdk_version
  ARG gcc_version=12.2.0
  FROM +osxcross.build --sdk_version=$sdk_version
  RUN apt install -y gcc g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev
  ENV GCC_VERSION=$gcc_version
  ENV ENABLE_FORTRAN=1
  ENV TARGET_DIR=/osxcross
  CACHE /osxcross/build
  RUN ./build_gcc.sh
  SAVE ARTIFACT /osxcross
  ENV PATH=$PATH:/osxcross/bin

osxcross.gcc.arm64:
  ARG --required sdk_version
  ARG gcc_version=13.0.1
  FROM +osxcross.build --sdk_version=$sdk_version
  RUN apt install -y gcc g++ zlib1g-dev libmpc-dev libmpfr-dev libgmp-dev
  ENV GCC_VERSION=$gcc_version
  ENV ENABLE_FORTRAN=1
  ENV TARGET_DIR=/osxcross
  CACHE /osxcross/build
  RUN ./build_gcc.sh
  SAVE ARTIFACT /osxcross
  ENV PATH=$PATH:/osxcross/bin
