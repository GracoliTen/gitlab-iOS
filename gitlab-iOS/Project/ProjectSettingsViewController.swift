//
//  ProjectSettingsViewController.swift
//  gitlab-iOS
//
//  Created by Xplorld on 2016/5/7.
//  Copyright © 2016年 dyweb. All rights reserved.
//

import UIKit
import Eureka

class ProjectSettingsViewController: FormViewController {

    let nameRow = TextRow("name") { $0.title = "Name" }
    let pathRow = LabelRow("path") { $0.title = "Path" }
    let descriptionRow = TextAreaRow("description") { $0.title = "description" }
//    let defaultBranchRow = PickerRow<String>("default_branch") { $0.title = "default_branch" }
    let issuesEnabledRow = SwitchRow("issues_enabled") { $0.title = "issues_enabled" }
    let mergeRequestsEnabledRow = SwitchRow("merge_requests_enabled") { $0.title = "merge_requests_enabled" }
    let buildsEnabledRow = SwitchRow("builds_enabled") { $0.title = "builds_enabled" }
    let wikiEnabledRow = SwitchRow("wiki_enabled") { $0.title = "wiki_enabled" }
    let snippetsEnabledRow = SwitchRow("snippets_enabled") { $0.title = "snippets_enabled" }
    let publicRow = SwitchRow("public") { $0.title = "public" }
    let publicBuildsRow = SwitchRow("public_builds") { $0.title = "public_builds" }
    
    var project:Project! {
        didSet {
            nameRow.value = project.name
            pathRow.value = project.name_with_namespace
            descriptionRow.value = project.description
//            defaultBranchRow
            issuesEnabledRow.value = project.issues_enabled
            mergeRequestsEnabledRow.value = project.merge_requests_enabled
            buildsEnabledRow.value = project.builds_enabled
            wikiEnabledRow.value = project.wiki_enabled
            snippetsEnabledRow.value = project.snippets_enabled
            publicRow.value = project.isPublic
            publicBuildsRow.value = project.public_builds
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Project information")
            <<< nameRow
            <<< pathRow
            <<< descriptionRow
            +++ Section("Permission Control")
            <<< issuesEnabledRow
            <<< mergeRequestsEnabledRow
            <<< buildsEnabledRow
            <<< wikiEnabledRow
            <<< snippetsEnabledRow
            <<< publicRow
            <<< publicBuildsRow
    }
    
}
