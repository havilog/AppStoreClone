import Foundation
import ProjectDescription

struct XCConfig {
    private struct Path {
        static var framework: ProjectDescription.Path { .relativeToRoot("Configurations/iOS/iOS-Framework.xcconfig") }
        static var example: ProjectDescription.Path { .relativeToRoot("Configurations/iOS/iOS-Example.xcconfig") }
        static var tests: ProjectDescription.Path { .relativeToRoot("Configurations/iOS/iOS-Tests.xcconfig") }
        static func project(_ config: String) -> ProjectDescription.Path { .relativeToRoot("Configurations/Base/Projects/Project-\(config).xcconfig") }
    }
    
    static let framework: [Configuration] = [
        .debug(name: "Development", xcconfig: Path.framework),
        .release(name: "Production", xcconfig: Path.framework),
    ]
    
    static let project: [Configuration] = [
        .debug(name: "Development", xcconfig: Path.project("Development")),
        .release(name: "Production", xcconfig: Path.project("Production")),
    ]
}
