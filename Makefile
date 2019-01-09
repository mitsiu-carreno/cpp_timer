# Determine the platform
PLATFORM := $(shell uname -s)

#CC
ifeq ($(PLATFORM),Darwin)
	CC := clang++ -arch x86_64
else
	CC := g++
endif

#Folders
SRC_DIR := src
BUILD_DIR := build
APP_DIR := bin

#Target
EXECUTABLE := timeSheet
APP := $(APP_DIR)/$(EXECUTABLE)

#Code Properties
SRC_EXT := cpp
SRC_FILES := $(shell find $(SRC_DIR) -type f -name *.$(SRC_EXT))
OBJ_FILES := 
