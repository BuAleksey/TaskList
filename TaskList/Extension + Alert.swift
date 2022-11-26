//
//  Extension + Alert.swift
//  TaskList
//
//  Created by Buba on 26.11.2022.
//

import UIKit

extension UIAlertController {
    static func createAlert(withTitle title: String) -> UIAlertController {
        UIAlertController(title: title, message: "What do you want to do?", preferredStyle: .alert)
    }
    
    func action(task: Task?, complition: @escaping(String) -> Void) {
        let saveAction = UIAlertAction(
            title: "Save",
            style: .default
        ) { [weak self] _ in
            guard let newValue = self?.textFields?.first?.text else { return }
            if !newValue.isEmpty {
                complition(newValue)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        
        addTextField { textField in
            textField.placeholder = "Task"
            textField.text = task?.title
        }
    }
}
