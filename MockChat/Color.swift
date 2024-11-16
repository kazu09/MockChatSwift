//
//  Color.swift
//  MockChat
//
//  Created by kazu on 2024/11/16.
//

import UIKit

extension UIColor {
    // HexカラーコードからUIColorを生成
        static func fromHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0
            Scanner(string: hexSanitized).scanHexInt64(&rgb)

            let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgb & 0x0000FF) / 255.0

            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }

        // カスタムカラー定義
        static let deepskyblue = UIColor.fromHex("#00bfff")
        static let azure = UIColor.fromHex("#f0ffff")
        static let gainsboro = UIColor.fromHex("#dcdcdc")
}
