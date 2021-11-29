// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Counter {
    /// Reset
    internal static let btn = L10n.tr("Localizable", "counter.btn")
    /// Total predictions: 
    internal static let title = L10n.tr("Localizable", "counter.title")
  }

  internal enum Errors {
    internal enum UltimateUnknownError {
      /// Something unknown happened. It really happens not often.
      ///  Congratulations!
      internal static let message = L10n.tr("Localizable", "errors.ultimateUnknownError.message")
      /// Ooops...
      internal static let title = L10n.tr("Localizable", "errors.ultimateUnknownError.title")
    }
  }

  internal enum HardcodedAnswer {
    /// HELL YEAH!
    internal static let _1 = L10n.tr("Localizable", "hardcodedAnswer.1")
    /// NO WAY
    internal static let _2 = L10n.tr("Localizable", "hardcodedAnswer.2")
    /// 50/50, it's up to you
    internal static let _3 = L10n.tr("Localizable", "hardcodedAnswer.3")
  }

  internal enum HardcodedAnswerTitle {
    /// Positive
    internal static let _1 = L10n.tr("Localizable", "hardcodedAnswerTitle.1")
    /// Negative
    internal static let _2 = L10n.tr("Localizable", "hardcodedAnswerTitle.2")
    /// Neutral
    internal static let _3 = L10n.tr("Localizable", "hardcodedAnswerTitle.3")
  }

  internal enum MagicBall {
    /// Shake Your iPhone to ask the GURU
    internal static let subtitle = L10n.tr("Localizable", "magicBall.subtitle")
    /// 🔮
    internal static let title = L10n.tr("Localizable", "magicBall.title")
  }

  internal enum SettingsName {
    /// Straight Predictions
    internal static let straightPredictions = L10n.tr("Localizable", "settingsName.straightPredictions")
  }

  internal enum Titles {
    /// History
    internal static let history = L10n.tr("Localizable", "titles.history")
    /// Magick Ball
    internal static let magicBall = L10n.tr("Localizable", "titles.magicBall")
    /// Settings
    internal static let settings = L10n.tr("Localizable", "titles.settings")
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
