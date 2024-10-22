# Install script for directory: /Users/cpoliver/code/keyboards/zmk/zephyr/drivers

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

# Set path to fallback-tool for dependency-resolution.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Users/cpoliver/.local/zephyr-sdk-0.16.3/arm-zephyr-eabi/bin/arm-zephyr-eabi-objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/disk/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/interrupt_controller/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/misc/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/pcie/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/usb/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/usb_c/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/adc/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/clock_control/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/display/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/entropy/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/flash/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/gpio/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/hwinfo/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/i2c/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/kscan/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/pinctrl/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/sensor/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/spi/cmake_install.cmake")
  include("/Users/cpoliver/code/keyboards/zmk-config/build/2024-10-22--21-47-12/zephyr/drivers/timer/cmake_install.cmake")

endif()

