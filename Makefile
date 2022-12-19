.PHONY: install-tools
install-tools:
	go install golang.org/x/mobile/cmd/gomobile@latest
	gomobile init

.PHONY: xcframework zip
xcframework: install-tools
	gomobile bind -target=ios,iossimulator,macos,maccatalyst -iosversion 14 -prefix GOJQ -o Frameworks/GOJQBinding.xcframework github.com/cockscomb/swift-gojq/binding

zip: xcframework
	zip -X -r Frameworks/GOJQBinding.xcframework.zip Frameworks/GOJQBinding.xcframework/
