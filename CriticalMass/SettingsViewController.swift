//
//  SettingsViewController.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 1/31/19.
//

import UIKit

class SettingsViewController: UITableViewController {
    enum Section: CaseIterable {
        case preferences
        case github
        case info

        struct Model {
            var title: String?
            var action: Action
        }

        var numberOfRows: Int {
            return models.count
        }

        var secionTitle: String? {
            switch self {
            case .preferences,
                 .github:
                return nil
            case .info:
                return NSLocalizedString("settings.section.info", comment: "")
            }
        }

        var cellClass: UITableViewCell.Type {
            switch self {
            case .preferences:
                return SettingsSwitchTableViewCell.self
            case .github:
                return SettingsGithubTableViewCellTableViewCell.self
            case .info:
                return SettingsInfoTableViewCell.self
            }
        }

        var models: [Model] {
            switch self {
            case .preferences:
                return [Model(title: NSLocalizedString("GPS", comment: ""), action: .none)]
            case .github:
                return [Model(title: nil, action: .open(url: URL(string: "https://github.com/criticalmaps/criticalmaps-ios")!))]
            case .info:
                return [Model(title: NSLocalizedString("settings.website", comment: ""), action: .open(url: URL(string: "https://www.criticalmaps.net")!)),
                        Model(title: NSLocalizedString("settings.twitter", comment: ""), action: .open(url: URL(string: "https://twitter.com/criticalmaps/")!)),
                        Model(title: NSLocalizedString("settings.facebook", comment: ""), action: .open(url: URL(string: "https://www.facebook.com/criticalmaps")!))]
            }
        }

        enum Action {
            case open(url: URL)
            case none
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        for cell in Section.allCases.map({ $0.cellClass }) {
            let name = String(describing: cell)
            tableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
        }
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        title = NSLocalizedString("settings.title", comment: "")
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

    override func numberOfSections(in _: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.allCases[section].secionTitle
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.allCases[section].numberOfRows
    }

    override func tableView(_: UITableView, willDisplayHeaderView view: UIView, forSection _: Int) {
        for subView in view.subviews {
            subView.backgroundColor = .white
            for case let label as UILabel in subView.subviews {
                if #available(iOS 8.2, *) {
                    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section.allCases[indexPath.section]
        let identifier = String(describing: section.cellClass)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = section.models[indexPath.row].title
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let section = Section.allCases[indexPath.section]
        let acttion = section.models[indexPath.row].action

        switch acttion {
        case .none:
            return
        case let .open(url: url):
            UIApplication.shared.openURL(url)
        }
    }
}
