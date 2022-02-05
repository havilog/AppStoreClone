import ProjectDescription

public extension TargetDependency {
    static let BasicSwiftUI: TargetDependency = .project(
        target: "BasicSwiftUI", 
        path: .relativeToRoot("Unsplash/Features/BasicSwiftUI")
    )
    
    static let Network: TargetDependency = .project(
        target: "Network", 
        path: .relativeToRoot("Unsplash/Modules/Network")
    )
}
