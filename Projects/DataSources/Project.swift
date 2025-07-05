import ProjectDescription
import ProjectDescriptionHelpers

fileprivate let NAME_PROJECT = Constants.Modules.DataSources.title

let project = Project(
    name: NAME_PROJECT,
    organizationName: Constants.ORGANIZATION_NAME,
    packages: [
        Constants.Packages.MyCommon.package
    ],
    targets: [
        .createTarget(
            type: .dynamicFramework,
            name: NAME_PROJECT,
            dependencies: [
                Constants.Packages.MyCommon.dependency,
                Constants.Modules.Domain.dependency,
                Constants.Modules.Data.dependency,
                Constants.Modules.Networking.dependency
            ]
        ),
        .createTarget(
            type: .unitTests,
            name: "DataSourcesTests",
            dependencies: [
              //  Constants.Modules.DataSources.dependency
                .target(name: NAME_PROJECT)
            ]
        )
    ]
)
