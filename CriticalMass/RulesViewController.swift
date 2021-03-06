//
//  RulesViewController.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 12/17/18.
//

import UIKit

enum Rule: String, CaseIterable {
    case cork
    case contraflow
    case gently
    case brake
    case green
    case stayLoose
    case haveFun

    var title: String {
        return NSLocalizedString("rules.title.\(rawValue)", comment: "")
    }

    var text: String {
        return NSLocalizedString("rules.text.\(rawValue)", comment: "")
    }

    var artwork: UIImage? {
        return UIImage(named: rawValue.prefix(1).uppercased() + rawValue.dropFirst())
    }
}

class RulesViewController: UITableViewController {
    private let cellIdentifier = "CellIdentifier"
    private let rules = Rule.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        registerCell()
    }

    private func configureNavigationBar() {
        title = NSLocalizedString("rules.title", comment: "")
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

    private func registerCell() {
        tableView.register(UINib(nibName: "RuleTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: UITableViewDataSource

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return rules.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RuleTableViewCell
        cell.label?.text = rules[indexPath.row].title
        if #available(iOS 10.0, *) {
            cell.label.adjustsFontForContentSizeCategory = true
        }
        cell.label?.textColor = .rulesOverViewCell
        return cell
    }

    // MARK: UITableViewDataDelegate

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rule = rules[indexPath.row]
        let detailViewController = RulesDetailViewController(rule: rule)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
