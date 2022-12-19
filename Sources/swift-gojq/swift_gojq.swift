import GOJQBinding

public struct swift_gojq {
    public private(set) var text: String

    public init() {
        self.text = GOJQBindingGreetings("World")
    }
}
