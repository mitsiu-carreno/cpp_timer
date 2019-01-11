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
OBJ_FILES := $(patsubst $(SRC_DIR)/%, $(BUILD_DIR)/%, $(SRC_FILES:.$(SRC_EXT)=.o))

#Headers path
INC_DIR := $(shell find include/* \( -name '*.hpp' -o -name '*.h' \) -exec dirname {} \; | sort | uniq)
INC_LIST := $(patsubst include/%, -I include/%, $(INC_DIR))
BUILD_LIST := $(patsubst include/%, $(BUILD_DIR)/%, $(INC_DIR))

CMD_INC := -I $(INC_LIST)
#CMD_FRAMEWORKS := -framework Foundation
CMD_LIB := -lstdc++ -lboost_filesystem -lboost_system

CFLAGS := -c -std=c++1z -Wall -Werror -g

$(APP_DIR): $(OBJ_FILES)
	@mkdir -p $(APP_DIR)
	@echo "Linking..."
	@echo "	Linking $(APP_DIR)"
	@echo "		$(CC) $^ -o $(APP) $(CMD_LIB)"; $(CC) $^ -o $(APP) $(CMD_LIB);
	@echo "Build complete, executing..."
	@echo ""
	./$(APP)


$(BUILD_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT)
	@mkdir -p $(BUILD_LIST)
	@echo "Compiling $<..."
	@echo "$(CC) $(CFLAGS) $(CMD_INC) $< -o $@"; $(CC) $(CFLAGS) $(CMD_INC) $< -o $@


run:
	./$(APP)


clean:
	@echo "Cleaning $(APP) ..."; $(RM) -r $(APP)


hardclean:
	@echo "Cleaning $(APP) and $(BUILD_DIR)/*..."; $(RM) -r $(BUILD_DIR)/* $(APP)
