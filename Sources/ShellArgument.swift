import Foundation

public enum ShellArgument: Equatable {
    case quoted(QuotedString)
    case verbatim(String)

    public init(quoted string: some StringProtocol) {
        self = .quoted(.init(.init(string)))
    }

    public init(verbatim string: some StringProtocol) {
        self = .verbatim(.init(string))
    }
}

extension ShellArgument: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .quoted(.init(value))
    }
}

extension ShellArgument: CustomStringConvertible {
    public var description: String {
        switch self {
            case let .quoted(value):
                return value.quoted
            case let .verbatim(string):
                return string
        }
    }
}

extension ShellArgument {
    public static func url(_ url: URL) -> Self { url.absoluteString.verbatim }
}


extension StringProtocol {
    public var quoted: ShellArgument { .init(quoted: self) }
    public var verbatim: ShellArgument { .init(verbatim: self) }
}

extension Sequence<StringProtocol> {
    public var quoted: [ShellArgument] { map(\.quoted) }
    public var verbatim: [ShellArgument] { map(\.verbatim) }
}
