// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  public enum Main {
    /// Главный экран
    public static let systemTitle = Strings.tr("Localizable", "main.systemTitle", fallback: "Главный экран")
    public enum Alert {
      public enum Hello {
        /// Привет
        public static let description = Strings.tr("Localizable", "main.alert.hello.description", fallback: "Привет")
        /// OK
        public static let ok = Strings.tr("Localizable", "main.alert.hello.ok", fallback: "OK")
        /// Приветствие
        public static let title = Strings.tr("Localizable", "main.alert.hello.title", fallback: "Приветствие")
      }
    }
    public enum Button {
      /// Приветствие
      public static let hello = Strings.tr("Localizable", "main.button.hello", fallback: "Приветствие")
    }
  }
  public enum Registration {
    /// Регистрация
    public static let systemTitle = Strings.tr("Localizable", "registration.systemTitle", fallback: "Регистрация")
    public enum Button {
      /// Зарегестрироваться
      public static let registration = Strings.tr("Localizable", "registration.button.registration", fallback: "Зарегестрироваться")
    }
    public enum Label {
      /// Дата рождения
      public static let birthday = Strings.tr("Localizable", "registration.label.birthday", fallback: "Дата рождения")
    }
    public enum Textfield {
      /// Введите имя
      public static let name = Strings.tr("Localizable", "registration.textfield.name", fallback: "Введите имя")
      /// Введите пароль
      public static let password = Strings.tr("Localizable", "registration.textfield.password", fallback: "Введите пароль")
      /// Повторите пароль
      public static let repeatPassword = Strings.tr("Localizable", "registration.textfield.repeatPassword", fallback: "Повторите пароль")
      /// Введите фамилие
      public static let surname = Strings.tr("Localizable", "registration.textfield.surname", fallback: "Введите фамилие")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
