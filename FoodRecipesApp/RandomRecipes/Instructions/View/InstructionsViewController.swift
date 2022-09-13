//
//  InstructionsViewController.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 12.09.2022.
//

import UIKit

class InstructionsViewController: UIViewController {

    //MARK: - properties
    var presenter: InstructionsOutput!
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var instructionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(instructionTextView)
        view.addSubview(doneButton)
        setConstraints()
    }
    
    //MARK: - private methods
    private func setConstraints() {
        NSLayoutConstraint.activate([
            instructionTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            instructionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            
            doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func doneButtonPressed() {
        dismiss(animated: true)
    }
}

//MARK: - InstructionsInput
extension InstructionsViewController: InstructionsInput {
    func setInstructions(_ instruction: String) {
        instructionTextView.text = instruction
    }
}
