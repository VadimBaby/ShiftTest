import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: "Workspace",
    projects: Constants.Modules.allPaths(),
    schemes: [.scheme(name: "MAIN", buildAction: .buildAction(targets: [.project(path: "//Projects/ShiftTest", target: "ShiftTest")]))]
)
