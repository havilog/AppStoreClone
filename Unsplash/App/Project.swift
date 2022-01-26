import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "Unsplash"
let organizationName: String = "havi"

let project = Project.project(
    name: projectName,
    organizationName: organizationName,
    product: .app,
    dependencies: [], // default 
    schemes: []
)
