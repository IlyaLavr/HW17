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
                self.view.backgroundColor = .black
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
        label.backgroundColor = Metric.labelBackgroundColour
        label.text = Metric.labelText
        label.textColor = Metric.labelTextColour
        label.textAlignment = .center
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.layer.cornerRadius = Metric.labelCornerRadius
        label.layer.shadowColor = Metric.labelShadowColor
        label.layer.shadowOpacity = Metric.labelShadowOpacity
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = Metric.labelShadowRadius
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Metric.textFieldPlaceholder
        textField.textColor = Metric.textFieldTextColour
        textField.backgroundColor = Metric.textFieldBackgroundColor
        textField.textAlignment = .center
        textField.keyboardType = .default
        textField.addTarget(self, action: #selector(textCountTextField), for: .editingChanged)
        textField.layer.cornerRadius = Metric.textFieldCornerRadius
        textField.layer.shadowColor = UIColor.white.cgColor
        textField.layer.shadowOpacity = Metric.textFieldShadowOpacity
        textField.layer.shadowOffset = .zero
        textField.layer.shadowRadius = Metric.textFieldShadowRadius
        return textField
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.isHidden = true
        return indicator
    }()
    
    private lazy var buttonRandomPassword: UIButton = {
        let button = UIButton()
        button.backgroundColor = Metric.buttonRandomPasswordBackgroundColor
        button.setTitle(Metric.buttonRandomPasswordText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Metric.buttonRandomPasswordSizeFont)
        button.addTarget(self, action: #selector(randomPassword), for: .touchUpInside)
        button.layer.cornerRadius = Metric.buttonRandomPasswordCornerRadius
        button.layer.shadowColor = Metric.buttonRandomPasswordShadowColor
        button.layer.shadowOpacity = Metric.buttonRandomPasswordShadowOpacity
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = Metric.buttonRandomPasswordShadowRadius
        return button
    }()
    
    private lazy var buttonStartSearch: UIButton = {
        let button = UIButton()
        button.backgroundColor = Metric.buttonStartBackgroundColor
        button.setTitle(Metric.buttonStartText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Metric.buttonStartSizeFont)
        button.addTarget(self, action: #selector(startSearch), for: .touchUpInside)
        button.layer.cornerRadius = Metric.buttonStartCornerRadius
        button.layer.shadowColor = Metric.buttonStartShadowColor
        button.layer.shadowOpacity = Metric.buttonStartShadowOpacity
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = Metric.buttonStartShadowRadius
        return button
    }()
    
    private lazy var buttonStop: UIButton = {
        let button = UIButton()
        button.backgroundColor = Metric.buttonStopBackgroundColor
        button.setTitle(Metric.buttonStoptText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Metric.buttonStopSizeFont)
        button.addTarget(self, action: #selector(stopSearch), for: .touchUpInside)
        button.layer.cornerRadius = Metric.buttonStopCornerRadius
        button.layer.shadowColor = Metric.buttonStopShadowColor
        button.layer.shadowOpacity = Metric.buttonStopShadowOpacity
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = Metric.buttonStopShadowRadius
        return button
    }()
    
    private lazy var buttonChangeColour: UIButton = {
        let button = UIButton()
        button.backgroundColor = Metric.buttonChangeColourBackgroundColor
        button.setTitle(Metric.buttonChangeColourText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Metric.buttonChangeColourSizeFont)
        button.addTarget(self, action: #selector(changeColour), for: .touchUpInside)
        button.layer.cornerRadius = Metric.buttonChangeColourCornerRadius
        button.layer.shadowColor = Metric.buttonChangeColourShadowColor
        button.layer.shadowOpacity = Metric.buttonChangeColourShadowOpacity
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = Metric.buttonChangeColourShadowRadius
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
        textField.isSecureTextEntry = false
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
        guard let count = textField.text?.count, count > 3 else { return }
        textField.text = ""
        showAllert()
    }
    
    @objc func changeColour() {
        isBlack.toggle()
    }
    
    // MARK: - Functions
    
    private func stopBruteForce() {
        isStopSearch.toggle()
    }
    
    func bruteForce(passwordToUnlock: String) {
        var password: String = ""
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
        
        while password != passwordToUnlock {
            if isStopSearch {
                DispatchQueue.main.async {
                    self.textField.isSecureTextEntry = false
                    self.textField.isEnabled = true
                    self.label.text = "Ваш код \(passwordToUnlock) не взломан!"
                    self.indicator.stopAnimating()
                    self.buttonRandomPassword.isEnabled = true
                }
                return
            }
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            DispatchQueue.main.async { [self] in
                buttonRandomPassword.isEnabled = false
                indicator.isHidden = false
                textField.isEnabled = false
                indicator.startAnimating()
                label.text = password
            }
        }
        DispatchQueue.main.async {
            self.label.text = password
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.textField.isEnabled = true
            self.textField.isSecureTextEntry = false
            self.buttonRandomPassword.isEnabled = true
        }
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

extension ViewController {
    
    // MARK: - Alert
    
    func showAllert() {
        let alert = UIAlertController(title: Metric.allertTitle,
                                      message: Metric.allertMessage,
                                      preferredStyle: .alert)
        let actionOne = UIAlertAction(title: Metric.allertActionTitle,
                                      style: .cancel)
        alert.addAction(actionOne)
        present(alert, animated: true)
    }
    
    func showAllertEmpty() {
        let alert = UIAlertController(title: Metric.allertEmptyTitle,
                                      message: Metric.allertEmptyMessage,
                                      preferredStyle: .alert)
        let actionOne = UIAlertAction(title: Metric.allertEmptyActionTitle,
                                      style: .cancel)
        alert.addAction(actionOne)
        present(alert, animated: true)
    }
    
    // MARK: - Metrics
    
    struct Metric {
        
        // Label
        static let labelText = "Введите пароль в поле ниже или сгененируйте случайным образом"
        static let labelBackgroundColour = UIColor.darkGray
        static let labelTextColour = UIColor.systemGray6
        static let labelCornerRadius: CGFloat = 20
        static let labelShadowColor = UIColor.white.cgColor
        static let labelShadowOpacity: Float = 0.3
        static let labelShadowRadius: CGFloat = 9
        
        // TextField
        static let textFieldPlaceholder = "password"
        static let textFieldTextColour = UIColor.black
        static let textFieldBackgroundColor = UIColor.darkGray
        static let textFieldCornerRadius: CGFloat = 17
        static let textFieldShadowColor = UIColor.white.cgColor
        static let textFieldShadowOpacity: Float = 0.3
        static let textFieldShadowRadius: CGFloat = 9
        
        // ButtonRandomPassword
        static let buttonRandomPasswordBackgroundColor = UIColor.blue
        static let buttonRandomPasswordText = "Случайный пароль"
        static let buttonRandomPasswordSizeFont: CGFloat = 18
        static let buttonRandomPasswordCornerRadius: CGFloat = 17
        static let buttonRandomPasswordShadowColor = UIColor.white.cgColor
        static let buttonRandomPasswordShadowOpacity: Float = 0.3
        static let buttonRandomPasswordShadowRadius: CGFloat = 9
        
        // ButtonStart
        static let buttonStartBackgroundColor = UIColor.blue
        static let buttonStartText = "Старт"
        static let buttonStartSizeFont: CGFloat = 18
        static let buttonStartCornerRadius: CGFloat = 17
        static let buttonStartShadowColor = UIColor.white.cgColor
        static let buttonStartShadowOpacity: Float = 0.3
        static let buttonStartShadowRadius: CGFloat = 9
        
        // ButtonStop
        static let buttonStopBackgroundColor = UIColor.systemRed
        static let buttonStoptText = "Стоп"
        static let buttonStopSizeFont: CGFloat = 18
        static let buttonStopCornerRadius: CGFloat = 17
        static let buttonStopShadowColor = UIColor.white.cgColor
        static let buttonStopShadowOpacity: Float = 0.3
        static let buttonStopShadowRadius: CGFloat = 9
        
        // ButtonChangeColour
        static let buttonChangeColourBackgroundColor = UIColor.orange
        static let buttonChangeColourText = "Цвет"
        static let buttonChangeColourSizeFont: CGFloat = 18
        static let buttonChangeColourCornerRadius: CGFloat = 50
        static let buttonChangeColourShadowColor = UIColor.white.cgColor
        static let buttonChangeColourShadowOpacity: Float = 0.3
        static let buttonChangeColourShadowRadius: CGFloat = 9
        
        // ShowAllert
        static let allertTitle = "Внимание!"
        static let allertMessage =  "Больше 3-х символов искать отказываюсь!"
        static let allertActionTitle = "Исправлюсь!"
        
        // ShowAllertEmpty
        static let allertEmptyTitle = "Эй, человек!"
        static let allertEmptyMessage =  "Ну ты пароль то введи, что я подбирать буду!"
        static let allertEmptyActionTitle = "Окееей!"
    }
}
