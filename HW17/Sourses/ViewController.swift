//
//  ViewController.swift
//  HW17
//
//  Created by Илья on 20.10.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var isStopSearch = Bool()
    
    var isBlack: Bool = false {
            didSet {
                if isBlack {
                    self.view.backgroundColor = .lightGray
                    buttonChangeColour.backgroundColor = .orange
                } else {
                    self.view.backgroundColor = .white
                    buttonChangeColour.backgroundColor = .blue
                }
            }
        }
    
    // MARK: - Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.text = "Введите пароль в поле ниже или сгененируйте случайным образом"
        label.textColor = .systemGray6
        label.textAlignment = .center
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.layer.cornerRadius = 17
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 9
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .darkGray
        textField.textAlignment = .center
        textField.keyboardType = .default
        textField.addTarget(self, action: #selector(textCountTextField), for: .editingChanged)
        textField.placeholder = "password"
        textField.layer.cornerRadius = 17
        textField.layer.shadowColor = UIColor.white.cgColor
        textField.layer.shadowOpacity = 0.3
        textField.layer.shadowOffset = .zero
        textField.layer.shadowRadius = 9
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
        button.titleLabel?.font = .systemFont(ofSize: CGFloat(18))
        button.addTarget(self, action: #selector(randomPassword), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 9
        return button
    }()
    
    private lazy var buttonStartSearch: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Старт", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat(18))
        button.addTarget(self, action: #selector(startSearch), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 9
        return button
    }()
    
    private lazy var buttonStop: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Стоп", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat(18))
        button.addTarget(self, action: #selector(stopSearch), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 9
        return button
    }()
    
    private lazy var buttonChangeColour: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Цвет", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat(18))
        button.addTarget(self, action: #selector(changeColour), for: .touchUpInside)
        button.layer.cornerRadius = 50
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 9
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
        view.addSubview(buttonChangeColour)
    }
    
    private func setupLayout() {
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(200)
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
        
        indicator.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.right.equalTo(textField.snp.right).offset(-30)
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
        
        buttonChangeColour.snp.makeConstraints { make in
            make.top.equalTo(buttonStop.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }
    
    // MARK: - Actions
    
    @objc func randomPassword() {
        label.text = "Новый пароль готов! Нажмите Старт"
        let countCharacters = 3
        let passwordCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
        let randomdPassword = String((0..<countCharacters).compactMap{ _ in passwordCharacters.randomElement() })
        textField.text = randomdPassword
        textField.isSecureTextEntry = true
    }
    
    @objc func startSearch() {
        guard let password = textField.text, password != "" else { return  showAllertEmpty() }
        isStopSearch = false
        textField.isSecureTextEntry = true
        let queue = DispatchQueue(label: "brutQueue", qos: .background, attributes: .concurrent)
        queue.async {
            self.bruteForce(passwordToUnlock: password)
        }
    }
    
    @objc func stopSearch() {
        stopBruteForce()
    }
    
    @objc private func textCountTextField() {
        if textField.text?.count ?? 0 > 3 {
            textField.text = ""
            showAllert()
        } else {
            textField.isSecureTextEntry = true
        }
    }
    
    @objc func changeColour() {
            isBlack.toggle()
        }
    
    private func stopBruteForce() {
        isStopSearch.toggle()
    }
    
    func bruteForce(passwordToUnlock: String) {
        var password: String = ""
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
        
        while password != passwordToUnlock {
            if isStopSearch == true {
                DispatchQueue.main.async {
                    self.textField.isSecureTextEntry = false
                    self.textField.isEnabled = true
                    self.label.text = "Ваш код \(passwordToUnlock) не взломан!"
                    self.indicator.stopAnimating()
                }
                return
            }
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            DispatchQueue.main.async {
                self.indicator.isHidden = false
                self.textField.isEnabled = false
                self.indicator.startAnimating()
                self.label.text = password
            }
        }
        DispatchQueue.main.async {
            self.label.text = password
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.textField.isEnabled = true
            self.textField.isSecureTextEntry = false
        }
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
    : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string
    
    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    } else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
        
        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }
    return str
}

// MARK: - Extensions

extension ViewController {
    
    // MARK: - Alert
    
    func showAllert() {
        let alert = UIAlertController(title: "Внимание!",
                                      message: "Больше 3-х символов искать отказываюсь!",
                                      preferredStyle: .alert)
        let actionOne = UIAlertAction(title: "Исправлюсь!",
                                      style: .cancel)
        alert.addAction(actionOne)
        present(alert, animated: true)
    }
    
    func showAllertEmpty() {
        let alert = UIAlertController(title: "Эй, человек!",
                                      message: "Ну ты пароль то введи, что я подбирать буду!",
                                      preferredStyle: .alert)
        let actionOne = UIAlertAction(title: "Окееей!",
                                      style: .cancel)
        alert.addAction(actionOne)
        present(alert, animated: true)
    }
}


