.PHONY: xcframework
xcframework:
	gomobile bind -target=ios,iossimulator,macos,maccatalyst -iosversion 14 -prefix GOJQ -o Frameworks/GOJQBinding.xcframework github.com/cockscomb/swift-gojq/binding
