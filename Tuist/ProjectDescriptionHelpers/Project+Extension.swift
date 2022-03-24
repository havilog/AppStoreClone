import ProjectDescription

extension DeploymentTarget {
    public static let defaultDeployment: DeploymentTarget = .iOS(targetVersion: "15.0", devices: .iphone)
}

// BuildSettings Key
public extension String {
    static let marketVersion = "MARKETING_VERSION"
    static let currentProjectVersion = "CURRENT_PROJECT_VERSION"
    static let codeSignIdentity = "CODE_SIGN_IDENTITY"
    static let codeSigningStyle = "CODE_SIGNING_STYLE"
    static let codeSigningRequired = "CODE_SIGNING_REQUIRED"
    static let developmentTeam = "DEVELOPMENT_TEAM"
    static let bundleIdentifier = "Baycon_Bundle_Identifier"
    static let bundleName = "Havi_Bundle_Name"
    static let provisioningProfileSpecifier = "PROVISIONING_PROFILE_SPECIFIER"
    static let swiftVersion = "SWIFT_VERSION"
    static let developmentAssetPaths = "DEVELOPMENT_ASSET_PATHS"
}

extension TargetDependency {
    public struct SPM {
    }
}

// dependencies
public extension TargetDependency.SPM {
    static let Moya = TargetDependency.package(product: "Moya")
    static let ComposableArchitecture = TargetDependency.package(product: "ComposableArchitecture")
}

public extension Package {
    static let Moya = Package.remote(url: "https://github.com/Moya/Moya", requirement: .exact("15.0.0"))
    static let ComposableArchitecture = Package.remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .exact("0.34.0"))
}
