//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 한상진 on 2022/02/04.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Network",
    packages: [
        .Moya
    ],
    dependencies: [
        .SPM.Moya
    ]
)
