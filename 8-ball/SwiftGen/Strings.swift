// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Canceled {
    internal enum Error {
      /// Motion cancelled
      internal static let title = L10n.tr("Localizable", "canceled.error.title")
    }
  }

  internal enum Cell {
    /// ItemCell
    internal static let identifier = L10n.tr("Localizable", "cell.identifier")
  }

  internal enum Error {
    internal enum Internet {
      /// Check Internet
      internal static let title = L10n.tr("Localizable", "error.internet.title")
    }
  }

  internal enum Key {
    /// hardcodedAnswer
    internal static let answer = L10n.tr("Localizable", "key.answer")
  }

  internal enum Shake {
    /// Shake the device
    internal static let title = L10n.tr("Localizable", "shake.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
