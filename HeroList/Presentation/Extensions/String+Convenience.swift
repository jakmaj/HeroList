//
//  String+Convenience.swift
//  HeroList
//
//  Created by Jakub Majdl on 14.01.2023.
//

import Foundation
import UIKit

extension String {

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attributedStringData = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            let attributedString = NSMutableAttributedString(attributedString: attributedStringData)
            let fullRange = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: fullRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: fullRange)

            return attributedString
        } catch {
            return nil
        }
    }

}
