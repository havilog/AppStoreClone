import ProjectDescription

public extension TargetDependency {
    static let Chos: TargetDependency = .project(
        target: "Chos", 
        path: .relativeToRoot("AppStoreClone/Features/Chos")
    )
    
    static let Heizel: TargetDependency = .project(
        target: "Heizel", 
        path: .relativeToRoot("AppStoreClone/Features/Heizel")
    )
    
    static let Havi: TargetDependency = .project(
        target: "Havi", 
        path: .relativeToRoot("AppStoreClone/Features/Havi")
    )
    
    static let ThirdPartyManager: TargetDependency = .project(
        target: "ThirdPartyManager", 
        path: .relativeToRoot("AppStoreClone/Modules/ThirdPartyManager")
    )
}
