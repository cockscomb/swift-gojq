import GOJQBinding

enum QueryError: Error {
    case conversionError
    case unknown
}

public struct Query {
    private let binding: GOJQBindingQuery

    public init(_ query: String) throws {
        var error: NSError?
        guard let binding = GOJQBindingNewQuery(query, &error) else {
            throw error ?? QueryError.unknown
        }
        self.binding = binding
    }

    public func run(_ input: Data) throws -> AsyncThrowingStream<Data, any Error> {
        let iter = try binding.run(input)
        return AsyncThrowingStream { continuation in
            while true {
                do {
                    let data = try iter.next()
                    continuation.yield(data)
                } catch {
                    if error.localizedDescription != "EOF" {
                        continuation.finish(throwing: error)
                    } else {
                        continuation.finish()
                    }
                    return
                }
            }
        }
    }

    public func run(_ input: String) throws -> AsyncThrowingMapSequence<(AsyncThrowingStream<Data, any Error>), String> {
        guard let data = input.data(using: .utf8) else {
            throw QueryError.conversionError
        }
        return (try run(data)).map { data in
            guard let string = String(bytes: data, encoding: .utf8) else {
                throw QueryError.conversionError
            }
            return string
        }
    }
}
