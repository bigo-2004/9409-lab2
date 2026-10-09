# update these paths if your project uses different directories !!!
SOURCE_DIR := $(CURDIR)/dirs/MalcFolder
QUARANTINE_DIR := $(CURDIR)/dirs/Quarantine
INTERVAL := 5

.PHONY: all antivirus restore quarantine

all: quarantine
	./antivirusd.sh "$(SOURCE_DIR)" "$(QUARANTINE_DIR)" "$(INTERVAL)"

restore: quarantine
	./restore.sh "$(SOURCE_DIR)" "$(QUARANTINE_DIR)"

# create the quarantine directory if it does not exist !
quarantine:
	mkdir -p "$(QUARANTINE_DIR)"