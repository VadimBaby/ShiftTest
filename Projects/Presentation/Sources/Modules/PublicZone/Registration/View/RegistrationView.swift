//
//  RegistrationView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import MyCommon
import UIKit
import SnapKit

protocol RegistrationViewOutput: AnyObject {
    func nameTextFieldValueChanged(value: String)
    func surnameTextFieldValueChanged(value: String)
    func passwordSecureFieldValueChanged(value: String)
    func repeatPasswordSecureFieldValueChanged(value: String)
    func birthdatePickerValueChanged(value: Date)
    func registrationButtonPressed()
    func viewDidLoad()
}

protocol RegistrationViewInput: AnyObject {
    var output: RegistrationViewOutput? { get set }
    
    func makeRegistrationButtonEnabled()
    func makeRegistrationButtonDisabled()
}

final class RegistrationView: UIViewController, RegistrationViewInput {
    var output: RegistrationViewOutput?
    
    private lazy var nameTextField: UITextField = .primary(placeholder: Strings.Registration.Textfield.name) &> {
        $0.addTarget(self, action: #selector(nameTextFieldValueChanged), for: .editingChanged)
    }
    
    private lazy var surnameTextField: UITextField = .primary(placeholder: Strings.Registration.Textfield.surname) &> {
        $0.addTarget(self, action: #selector(surnameTextFieldValueChanged), for: .editingChanged)
    }
    
    private lazy var birthDateLabel: UILabel = .label(text: Strings.Registration.Label.birthday, font: .headline)
    
    private lazy var birthdatePicker = UIDatePicker() &> {
        $0.datePickerMode = .date
        $0.addTarget(self, action: #selector(birthdatePickerValueChanged), for: .valueChanged)
    }
    
    private lazy var passwordSecureField: UITextField = .securePrimary(placeholder: Strings.Registration.Textfield.password) &> {
        $0.addTarget(self, action: #selector(passwordSecureFieldValueChanged), for: .editingChanged)
    }
    
    private lazy var repeatPasswordSecureField: UITextField = .securePrimary(placeholder: Strings.Registration.Textfield.repeatPassword) &> {
        $0.addTarget(self, action: #selector(repeatPasswordSecureFieldValueChanged), for: .editingChanged)
    }
    
    private lazy var registrationButton: UIButton = .primary(title: Strings.Registration.Button.registration) &> {
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(registrationButtonPressed), for: .touchUpInside)
    }
    
    private var registrationButtonBottomConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        setupRootView()
        addSubviews()
        setupConstraints()
        setupGestures()
        setBirthday()
    }
    
    func makeRegistrationButtonEnabled() {
        registrationButton.isEnabled = true
    }
    
    func makeRegistrationButtonDisabled() {
        registrationButton.isEnabled = false
    }
}

// MARK: - Private Methods

private extension RegistrationView {
    @objc
    func nameTextFieldValueChanged(_ sender: UITextField) {
        guard let value = sender.text else { return }
        output?.nameTextFieldValueChanged(value: value)
    }
    
    @objc
    func surnameTextFieldValueChanged(_ sender: UITextField) {
        guard let value = sender.text else { return }
        output?.surnameTextFieldValueChanged(value: value)
    }
    
    @objc
    func birthdatePickerValueChanged(_ sender: UIDatePicker) {
        let date = sender.date
        output?.birthdatePickerValueChanged(value: date)
    }
    
    @objc
    func passwordSecureFieldValueChanged(_ sender: UITextField) {
        guard let value = sender.text else { return }
        output?.passwordSecureFieldValueChanged(value: value)
    }
    
    @objc
    func repeatPasswordSecureFieldValueChanged(_ sender: UITextField) {
        guard let value = sender.text else { return }
        output?.repeatPasswordSecureFieldValueChanged(value: value)
    }
    
    func setBirthday() {
        let date = birthdatePicker.date
        output?.birthdatePickerValueChanged(value: date)
    }
    
    @objc
    func registrationButtonPressed() {
        output?.registrationButtonPressed()
    }
    
    @objc
    func mainViewTapped() {
        view.endEditing(true)
    }
}

// MARK: - Subviews

private extension RegistrationView {
    func setupRootView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = Strings.Registration.systemTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addSubviews() {
        view.addSubviews(nameTextField, surnameTextField, birthdatePicker, passwordSecureField, repeatPasswordSecureField, registrationButton, birthDateLabel)
    }
    
    func setupConstraints() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(AppConstants.Padding.default)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.Padding.default)
            make.height.equalTo(AppConstants.TextField.height)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(AppConstants.Padding.default)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.Padding.default)
            make.height.equalTo(AppConstants.TextField.height)
        }
        
        birthDateLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdatePicker.snp.top)
            make.bottom.equalTo(birthdatePicker.snp.bottom)
            make.leading.equalToSuperview().inset(AppConstants.Padding.default)
        }
        
        birthdatePicker.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(AppConstants.Padding.default)
            make.trailing.equalToSuperview().inset(AppConstants.Padding.default)
        }
        
        passwordSecureField.snp.makeConstraints { make in
            make.top.equalTo(birthdatePicker.snp.bottom).offset(AppConstants.Padding.default)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.Padding.default)
            make.height.equalTo(AppConstants.TextField.height)
        }
        
        repeatPasswordSecureField.snp.makeConstraints { make in
            make.top.equalTo(passwordSecureField.snp.bottom).offset(AppConstants.Padding.default)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.Padding.default)
            make.height.equalTo(AppConstants.TextField.height)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(AppConstants.Padding.default)
            make.height.equalTo(AppConstants.Button.height)
        }
    }
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainViewTapped))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Preview

#if DEBUG && canImport(SwiftUI)
import SwiftUI
struct RegistrationViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: RegistrationAssembly.createMock()
        ).asPreview()
    }
}
#endif
