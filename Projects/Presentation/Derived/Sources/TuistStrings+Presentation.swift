// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum PresentationStrings: Sendable {

  public enum Main: Sendable {
  /// Главный экран
    public static let systemTitle = PresentationStrings.tr("Localizable", "main.systemTitle")

    public enum Alert: Sendable {

      public enum Hello: Sendable {
      /// Привет
        public static let description = PresentationStrings.tr("Localizable", "main.alert.hello.description")
        /// OK
        public static let ok = PresentationStrings.tr("Localizable", "main.alert.hello.ok")
        /// Приветствие
        public static let title = PresentationStrings.tr("Localizable", "main.alert.hello.title")
      }
    }

    public enum Button: Sendable {
    /// Приветствие
      public static let hello = PresentationStrings.tr("Localizable", "main.button.hello")
    }
  }

  public enum Registration: Sendable {
  /// Регистрация
    public static let systemTitle = PresentationStrings.tr("Localizable", "registration.systemTitle")

    public enum Button: Sendable {
    /// Зарегестрироваться
      public static let registration = PresentationStrings.tr("Localizable", "registration.button.registration")
    }

    public enum Label: Sendable {
    /// Дата рождения
      public static let birthday = PresentationStrings.tr("Localizable", "registration.label.birthday")
    }

    public enum Textfield: Sendable {
    /// Введите имя
      public static let name = PresentationStrings.tr("Localizable", "registration.textfield.name")
      /// Введите пароль
      public static let password = PresentationStrings.tr("Localizable", "registration.textfield.password")
      /// Повторите пароль
      public static let repeatPassword = PresentationStrings.tr("Localizable", "registration.textfield.repeatPassword")
      /// Введите фамилие
      public static let surname = PresentationStrings.tr("Localizable", "registration.textfield.surname")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension PresentationStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
