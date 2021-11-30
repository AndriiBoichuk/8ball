// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Answers {
    /// Hardcoded answers
    internal static let title = L10n.tr("Localizable", "answers.title")
  }

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

  internal enum Counter {
    /// Counter -
    internal static let title = L10n.tr("Localizable", "counter.title")
  }

  internal enum Error {
    internal enum Internet {
      /// Check Internet
      internal static let title = L10n.tr("Localizable", "error.internet.title")
    }
  }

  internal enum Image {
    /// gearshape
    internal static let settings = L10n.tr("Localizable", "image.settings")
    /// iphone.radiowaves.left.and.right
    internal static let shakeIphone = L10n.tr("Localizable", "image.shakeIphone")
    /// dot.radiowaves.left.and.right
    internal static let tabIcon1 = L10n.tr("Localizable", "image.tabIcon1")
    /// character.book.closed
    internal static let tabIcon2 = L10n.tr("Localizable", "image.tabIcon2")
    /// wifi.slash
    internal static let wifi = L10n.tr("Localizable", "image.wifi")
  }

  internal enum Key {
    /// hardcodedAnswer
    internal static let answer = L10n.tr("Localizable", "key.answer")
  }

  internal enum PersistentContainer {
    /// 8-ball
    internal static let name = L10n.tr("Localizable", "persistentContainer.name")
  }

  internal enum Placeholder {
    /// Type something...
    internal static let title = L10n.tr("Localizable", "placeholder.title")
  }

  internal enum SaveButton {
    /// Save
    internal static let title = L10n.tr("Localizable", "saveButton.title")
  }

  internal enum Settings {
    /// Settings
    internal static let title = L10n.tr("Localizable", "settings.title")
  }

  internal enum Shake {
    /// Shake the device
    internal static let title = L10n.tr("Localizable", "shake.title")
  }

  internal enum Shaking {
    /// Shaking
    internal static let title = L10n.tr("Localizable", "shaking.title")
  }

  internal enum Tabbar {
    /// Shake
    internal static let title1 = L10n.tr("Localizable", "tabbar.title1")
    /// Answers
    internal static let title2 = L10n.tr("Localizable", "tabbar.title2")
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
