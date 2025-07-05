//
//  RegistrationInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 03.07.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//
// swiftlint:disable:next foundation_using
import Foundation
import MyCommon
import Domain

protocol RegistrationInteractorOutput: AnyObject {
    func credentialsDidInvalid()
    func credentialsDidValid()
    func registrationDidEnd()
    func checkUserAuthorizeComeWithSuccess()
}

protocol RegistrationInteractorInput: AnyObject {
    var output: RegistrationInteractorOutput? { get set }
    
    func changeName(_ name: String)
    func changeSurname(_ surname: String)
    func changeBirthdate(_ birthdate: Date)
    func changePassword(_ password: String)
    func changeRepeatPassword(_ repeatPassword: String)
    func pressButton()
    func viewDidLoad()
}

final class RegistrationInteractor: RegistrationInteractorInput {
    weak var output: RegistrationInteractorOutput?
    
    private let setUserUseCase: SetUserUseCaseProtocol
    private let checkUserIsAuthorizeUseCase: CheckUserIsAuthorizeUseCaseProtocol
    
    public init(
        setUserUseCase: SetUserUseCaseProtocol,
        checkUserIsAuthorizeUseCase: CheckUserIsAuthorizeUseCaseProtocol
    ) {
        self.setUserUseCase = setUserUseCase
        self.checkUserIsAuthorizeUseCase = checkUserIsAuthorizeUseCase
    }
    
    private var name: String?
    private var surname: String?
    private var birthdate: Date?
    private var password: String?
    private var repeatPassword: String?
    
    func viewDidLoad() {
        Task {
            do {
                if try await checkUserIsAuthorizeUseCase.execute() {
                    await MainActor.run {
                        output?.checkUserAuthorizeComeWithSuccess()
                    }
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func changeName(_ name: String) {
        defer { checkCredentials() } 
        
        if name.count > 1 {
            self.name = name
            return
        }
        
        self.name = nil
    }
    
    func changeSurname(_ surname: String) {
        defer { checkCredentials() }
        
        if surname.count > 2 {
            self.surname = surname
            return
        }
        
        self.surname = nil
    }
    
    func changeBirthdate(_ birthdate: Date) {
        self.birthdate = birthdate
        checkCredentials()
    }
    
    func changePassword(_ password: String) {
        defer { checkCredentials() }
        
        if password.isValidPassword() {
            self.password = password
            return
        }
        
        self.password = nil
    }
    
    func changeRepeatPassword(_ repeatPassword: String) {
        self.repeatPassword = repeatPassword
        checkCredentials()
    }
    
    func pressButton() {
        guard credentialsIsValid(), let name = name, let surname = surname, let birthdate = birthdate else { return }
        
        Task {
            do {
                let user = User(name: name, surname: surname, birthdate: birthdate)
                try await setUserUseCase.execute(user: user)
            } catch {
                debugPrint(error.localizedDescription)
            }
            
            await MainActor.run {
                output?.registrationDidEnd()
            }
        }
    }
}

// MARK: - Private Methods

private extension RegistrationInteractor {
    func checkCredentials() {
        if credentialsIsValid() {
            output?.credentialsDidValid()
            return
        }
        
        output?.credentialsDidInvalid()
    }
    
    func credentialsIsValid() -> Bool {
        name.isNotNil && surname.isNotNil && birthdate.isNotNil && password.isNotNil && password == repeatPassword
    }
}
