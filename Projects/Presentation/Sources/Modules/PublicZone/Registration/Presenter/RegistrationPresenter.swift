//
//  RegistrationPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//
// swiftlint:disable:next foundation_using
import Foundation

protocol RegistrationPresenterOutput: AnyObject {
    func registrationDidEnd()
    func checkUserAuthorizeComeWithSuccess()
}

protocol RegistrationPresenterInput: AnyObject {
    var output: RegistrationPresenterOutput? { get set }
}

final class RegistrationPresenter: RegistrationPresenterInput {
    weak var output: RegistrationPresenterOutput?
    
    private unowned let view: RegistrationViewInput
    private let interactor: RegistrationInteractorInput
    
    init(view: RegistrationViewInput, interactor: RegistrationInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - RegistrationViewOutput

extension RegistrationPresenter: RegistrationViewOutput {
    func nameTextFieldValueChanged(value: String) {
        interactor.changeName(value)
    }
    
    func surnameTextFieldValueChanged(value: String) {
        interactor.changeSurname(value)
    }
    
    func passwordSecureFieldValueChanged(value: String) {
        interactor.changePassword(value)
    }
    
    func repeatPasswordSecureFieldValueChanged(value: String) {
        interactor.changeRepeatPassword(value)
    }
    
    func birthdatePickerValueChanged(value: Date) {
        interactor.changeBirthdate(value)
    }
    
    func registrationButtonPressed() {
        interactor.pressButton()
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
}

// MARK: - RegistrationInteractorOutput

extension RegistrationPresenter: RegistrationInteractorOutput {
    func credentialsDidInvalid() {
        view.makeRegistrationButtonDisabled()
    }
    
    func credentialsDidValid() {
        view.makeRegistrationButtonEnabled()
    }
    
    func registrationDidEnd() {
        output?.registrationDidEnd()
    }
    
    func checkUserAuthorizeComeWithSuccess() {
        output?.checkUserAuthorizeComeWithSuccess()
    }
}
