//
//  HistoryViewController + extension.swift
//  RunApp
//
//  Created by Мария Хатунцева on 05.03.2023.
//

import UIKit

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dataSource?.tableView(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: .leastNonzeroMagnitude))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if Run.getAllRuns()?.count == 0 {
            return
        } else {
            guard let run = Run.getAllRuns()?[indexPath.row - 1] else {
                return
            }
            let detailedVC = RunDetailsViewController(run: run)
            present(detailedVC, animated: true)
        }
    }
}
