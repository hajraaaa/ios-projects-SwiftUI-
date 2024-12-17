import SwiftUI

extension Font {
    // MARK: - Satoshi Medium
    static func satoshiMedium(size: CGFloat) -> Font {
        return .custom("Satoshi-Medium", size: size)
    }

    // MARK: - Satoshi Regular
    static func satoshiRegular(size: CGFloat) -> Font {
        return .custom("Satoshi-Regular", size: size)
    }

    // MARK: - Satoshi Bold
    static func satoshiBold(size: CGFloat) -> Font {
        return .custom("Satoshi-Bold", size: size)
    }
}
