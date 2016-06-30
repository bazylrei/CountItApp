EDITOR=vim

WORKSPACE = ClickerApp.xcworkspace
SCHEME = ClickerApp
CONFIGURATION = Debug
APP_NAME = ClickerApp

APP_PLIST = App/Info.plist
PLIST_BUDDY = /usr/libexec/PlistBuddy
BUNDLE_VERSION = $(shell $(PLIST_BUDDY) -c "Print CFBundleVersion" $(APP_PLIST))
GIT_COMMIT = $(shell git log -n1 --format='%h')
DEVICE_HOST = "platform=iOS Simulator,OS=9.2,name=iPhone 6s"

BUNDLER := $(shell command -v bundler 2>/dev/null)

all: check bundle drive

drive: 
	bundle exec fastlane test

check: BUNDLER-exists
BUNDLER-exists: ; @which bundler > /dev/null

HELP_FUNC = \
    %help; \
    while(<>) { \
        if(/^([a-z0-9_-]+):.*\#\#(?:@(\w+))?\s(.*)$$/) { \
            push(@{$$help{$$2}}, [$$1, $$3]); \
        } \
    }; \
    print "usage: make [target]\n\n"; \
    for ( sort keys %help ) { \
        print "$$_:\n"; \
        printf("  %-20s %s\n", $$_->[0], $$_->[1]) for @{$$help{$$_}}; \
        print "\n"; \
    }

help: ## This help dialog.
	@IFS=$$'\n' ; \
		help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
		printf '\033[33m'; \
		printf "%-30s %s\n" "Action" "Description" ; \
		printf "%-30s %s\n" "------" "------------" ; \
		for help_line in $${help_lines[@]}; do \
			IFS=$$':' ; \
			help_split=($$help_line) ; \
			help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
			help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
			printf '\033[36m'; \
			printf "%-30s %s" $$help_command ; \
			printf '\033[0m'; \
			printf "%s\n" $$help_info; \
		done

bootstrap: check phony_bootstrap ## Bootstraps the project so it's ready to be compiled
phony_bootstrap: bundle pod

bundle: check phony_bundle ## Retrieves all the GEMS listed on the Gemfile and installs the resulting bundle at \033[35m`./.vendor`
phony_bundle: 
	bundle install --path="./.vendor"

synx: check phony_synx ## Executes the synx gem to make the Xcode files/groups architecture match in the file system
phony_synx: 
	bundle exec synx ClickerApp.xcodeproj

pod: check phony_pod ## Executes the bundled gem \033[35m`cocoapods` \033[0mcommand \033[35m`pod install`. \033[0mInstalls missings pods to the Workspace
phony_pod: 
	bundle exec pod install

deintegrate: check phony_deintegrate ## Runs \033[35m`bundle exec pod deintegrate`\033[0m on every project of the workspace (sans the Pods projects)
phony_deintegrate:
	bundle exec pod deintegrate ClickerApp.xcodeproj

clean_cache: check phony_cc ## Runs \033[35mbundle exec pod cache clean --all\033[0m to clean any pods cache.
phony_cc:
	bundle exec pod cache clean --all

build: check phony_build ## Builds the project.
phony_build:
	set -o pipefail && xcodebuild -workspace '$(WORKSPACE)' -scheme '$(SCHEME)' -configuration '$(CONFIGURATION)' -sdk iphonesimulator -destination $(DEVICE_HOST) build | bundle exec xcpretty -c

clean: check phony_clean ## Cleans the project (deletes derived data). Forces next build to be a «cold» build.
phony_clean:
	xcodebuild -workspace '$(WORKSPACE)' -scheme '$(SCHEME)' -configuration '$(CONFIGURATION)' clean | xcpretty -c

test: check phony_test ## Runs the test suite on the project.
phony_test:
	set -o pipefail && xcodebuild -verbose -workspace '$(WORKSPACE)' -scheme '$(SCHEME)' -configuration '$(CONFIGURATION)' test -sdk iphonesimulator -destination $(DEVICE_HOST) | xcpretty -c
