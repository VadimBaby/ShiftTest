import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.App.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    packages: [
        Constants.Packages.MyCommon.package
    ],
    targets: [
        .createTarget(
            type: .app,
            name: NAME_PROJECT,
            dependencies: [
                Constants.Packages.MyCommon.dependency,
                Constants.Modules.Domain.dependency,
                Constants.Modules.Data.dependency,
                Constants.Modules.Presentation.dependency,
                Constants.Modules.DataSources.dependency,
                Constants.Modules.Networking.dependency
            ],
            resources: Constants.DEFAULT_LOCATE_RESOURCES
        )
    ]
)
