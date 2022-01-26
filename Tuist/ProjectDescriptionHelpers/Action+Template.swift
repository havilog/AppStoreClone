import ProjectDescription

public extension TargetScript {
    static let swiftlint = TargetScript.pre(
        path: .relativeToRoot("Scripts/SwiftLintRunScript.sh"), 
        name: "SwiftLint"
    )
}
