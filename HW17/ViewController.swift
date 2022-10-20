//
//  ViewController.swift
//  HW17
//
//  Created by Илья on 20.10.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Enter password and press Start"
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        return label
    }()

    private lazy var textField: UITextField = {
            let textField = UITextField()
            textField.textColor = .black
            textField.backgroundColor = .gray
            textField.textAlignment = .center
            textField.placeholder = "Введите пароль или сгененируйте случайным образом"
            textField.layer.cornerRadius = 17
            textField.layer.shadowColor = UIColor.black.cgColor
            textField.layer.shadowOpacity = 0.3
            textField.layer.shadowOffset = .zero
            textField.layer.shadowRadius = 17
            return textField
        }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.isHidden = true
        return indicator
    }()
    
    private lazy var buttonRandomPassword: UIButton = {
            let button = UIButton()
        button.backgroundColor = .blue
            button.setTitle("Случайный пароль", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: CGFloat(20))
            button.layer.cornerRadius = 17
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.3
            button.layer.shadowOffset = .zero
            button.layer.shadowRadius = 17
            return button
        }()
    
    private lazy var buttonStartSearch: UIButton = {
            let button = UIButton()
        button.backgroundColor = .blue
            button.setTitle("Старт", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: CGFloat(20))
            button.layer.cornerRadius = 17
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.3
            button.layer.shadowOffset = .zero
            button.layer.shadowRadius = 17
            return button
        }()
    
    private lazy var buttonStop: UIButton = {
            let button = UIButton()
        button.backgroundColor = .red
            button.setTitle("Стоп", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: CGFloat(20))
            button.layer.cornerRadius = 17
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.3
            button.layer.shadowOffset = .zero
            button.layer.shadowRadius = 17
            return button
        }()
    
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(indicator)
        view.addSubview(buttonRandomPassword)
        view.addSubview(buttonStartSearch)
        view.addSubview(buttonStop)
    }
    
    private func setupLayout() {
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(150)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(60)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(60)
        }

        buttonRandomPassword.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left).offset(20)
            make.height.equalTo(80)
            make.width.equalTo(180)
        }

        buttonStartSearch.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.right.equalTo(view.snp.right).offset(-20)
            make.left.equalTo(buttonRandomPassword.snp.right).offset(20)
            make.height.equalTo(80)
        }

        buttonStop.snp.makeConstraints { make in
            make.top.equalTo(buttonStartSearch.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.height.equalTo(60)
        }
    }
}

