project = BankLogo

test: test-unit test-carthage test-cocoapods

test-unit:
	xcodebuild test -scheme $(project) -sdk iphonesimulator | bundle exec xcpretty

test-carthage:
	echo 'test-carthage'

test-cocoapods:
	echo 'test-cocoapods'

bootstrap:
	bundle install
	# Cannot brew install carthage on Travis-CI
	# brew update
	# brew install carthage
	curl -OL https://github.com/Carthage/Carthage/releases/download/0.7.5/Carthage.pkg
	sudo /usr/sbin/installer -pkg Carthage.pkg -target /

release:
	zip -r -9 $(project).framework.zip Carthage/Build/iOS/*.framework

clean:
	git clean -xfd
	git submodule foreach git clean -xfd
	rm -rf  ~/Library/Developer/Xcode/DerivedData/$(project)-*

carthage-update:
	carthage update --use-submodules --no-build

carthage-build:
	carthage build --platform ios

.PHONY: all clean test test-unit test-carthage test-cocoapods carthage-update carthage-build bootstrap
