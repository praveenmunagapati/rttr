####################################################################################
#                                                                                  #
#  Copyright (c) 2014, 2015 Axel Menzel <info@axelmenzel.de>                       #
#                                                                                  #
#  This file is part of RTTR (Run Time Type Reflection)                            #
#  License: MIT License                                                            #
#                                                                                  #
#  Permission is hereby granted, free of charge, to any person obtaining           #
#  a copy of this software and associated documentation files (the "Software"),    #
#  to deal in the Software without restriction, including without limitation       #
#  the rights to use, copy, modify, merge, publish, distribute, sublicense,        #
#  and/or sell copies of the Software, and to permit persons to whom the           #
#  Software is furnished to do so, subject to the following conditions:            #
#                                                                                  #
#  The above copyright notice and this permission notice shall be included in      #
#  all copies or substantial portions of the Software.                             #
#                                                                                  #
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      #
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        #
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     #
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER          #
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   #
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE   #
#  SOFTWARE.                                                                       #
#                                                                                  #
####################################################################################

# setup version numbers
set(RTTR_VERSION_MAJOR 0)
set(RTTR_VERSION_MINOR 9)
set(RTTR_VERSION_PATCH 0)
set(RTTR_VERSION ${RTTR_VERSION_MAJOR}.${RTTR_VERSION_MINOR}.${RTTR_VERSION_PATCH})
set(RTTR_VERSION_STR "${RTTR_VERSION_MAJOR}.${RTTR_VERSION_MINOR}.${RTTR_VERSION_PATCH}")
math(EXPR RTTR_VERSION_CALC "${RTTR_VERSION_MAJOR}*1000 + ${RTTR_VERSION_MINOR}*100 + ${RTTR_VERSION_PATCH}")
set(RTTR_PRODUCT_NAME "RTTR")
message("Project version: ${RTTR_VERSION_STR}")

# files
set(README_FILE "${CMAKE_SOURCE_DIR}/README")
set(LICENSE_FILE "${CMAKE_SOURCE_DIR}/LICENSE")

# dirs where the binaries should be placed, installed
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
set(CMAKE_EXECUTABLE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
set(RTTR_INSTALL_DIR "${CMAKE_BINARY_DIR}/install")

#3rd part dependencies dirs
set(RTTR_3RD_PARTY_DIR "${CMAKE_SOURCE_DIR}/3rd-party")

getNameOfDir(CMAKE_LIBRARY_OUTPUT_DIRECTORY RTTR_TARGET_BIN_DIR)
is_vs_based_build(VS_BUILD)
if (VS_BUILD)
  #set(RTTR_BIN_INSTALL_DIR ${RTTR_TARGET_BIN_DIR}/\${CMAKE_INSTALL_CONFIG_NAME})
  set(RTTR_BIN_INSTALL_DIR ${RTTR_TARGET_BIN_DIR})
  set(RTTR_LIB_INSTALL_DIR "lib")
else()
  set(RTTR_BIN_INSTALL_DIR ${RTTR_TARGET_BIN_DIR})
  set(RTTR_LIB_INSTALL_DIR "lib")
endif()

set(CMAKE_DEBUG_POSTFIX "_d")

# detect architecture
if (CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(RTTR_NATIVE_ARCH 64)
else()
    set(RTTR_NATIVE_ARCH 32)
endif()

enable_rtti(BUILD_WITH_RTTI)

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "4.7.0")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
    message(STATUS "added flag -std=c++0x to g++")
  else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    message(STATUS "added flag -std=c++11 to g++")
  endif()
  if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER "4.0.0")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden")
  endif()
endif()

# RelWithDepInfo should have the same option like the Release build
# but of course with Debug informations
if(MSVC)
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELEASE}")
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /Zi /DEBUG")
elseif(CMAKE_COMPILER_IS_GNUCXX )
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELEASE}")
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} -g")
else()
  message(WARNING "Please adjust CMAKE_CXX_FLAGS_RELWITHDEBINFO flags for this compiler!")
endif()

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/CMake/rttr-config-version.cmake"
  VERSION ${RTTR_VERSION_STR}
  COMPATIBILITY AnyNewerVersion
)

install(
  FILES
    "${CMAKE_CURRENT_BINARY_DIR}/CMake/rttr-config-version.cmake"
  DESTINATION
    cmake
  COMPONENT
    Devel
)