import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "AppStoreClone"
let organizationName: String = "havi"

let project = Project.project(
    name: projectName,
    organizationName: organizationName,
    product: .app,
    dependencies: [
        .Havi,
        .Chos,
        .Heizel
    ], 
    schemes: []
)
