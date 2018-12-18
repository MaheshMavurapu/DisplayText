//
//  GSKDisplayText.swift
//  DisplayText
//
//  Created by Mahesh Mavurapu on 18/12/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

import Foundation
//
//  GSKDisplayText.swift
//  DisplayText
//
//  Created by Ashish Ranjan (Digital) on 13/12/18.
//  Copyright © 2018 Ashish Ranjan (Digital). All rights reserved.
//

import UIKit
/// GSK Display Text class, having different variations of Display Text available in GSK.
@IBDesignable public class GSKDisplayText: UILabel {
    //swiftlint:disable identifier_name
    ///Enums for different types of Display Text
    public enum DisplayTextStyle: String {
        /// type headline1
        case h1
        
        /// type headline2
        case h2
        
        /// type headline3
        case h3
        
        /// type headline4
        case h4
        
        /// type headline5
        case h5
        
        /// type headline6
        case h6
        
        /// type subtitle
        case subtitle
        
        /// type body1
        case body1
        
        /// type body2
        case body2
        
        /// type small title
        case smalltitle
        
        /// type caption
        case caption
        
        /// type text button
        case textbutton
    }
    //swiftlint:enable identifier_name
    
    ///User can set the type of displayText using this property. By default, it is set to "headline4"
    @IBInspectable var styleAdaptor: String = DisplayTextStyle.h4.rawValue {
        didSet {
            let type = DisplayTextStyle(rawValue: styleAdaptor)
            style = type ?? .h4
        }
    }
    // swiftlint:disable line_length
    /// Character spacing on the text of Display Text. While setting the character spacing programatically, user should first set the text of the Display Label then he should set the spacing property for that Display Text.
    @IBInspectable var characterSpacing: CGFloat = 0.5 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text ?? "")
            attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
    }
    //swiftlint:enable line_length
    
    /// Display Text Style Selected
    public var style: DisplayTextStyle = .h4 {
        didSet {
            commonConfiguration()
        }
    }
    
    /// Overriding base class designated initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonConfiguration()
    }
    /// Overriding base class designated initializer
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonConfiguration()
    }
    
    ///Called when a designable object is created in Interface Builder.
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    /// Changes the height of Display text based on the size of the text
    /// user must have to set the text of the display label before calling the optimal height function.
    /// - Returns:  height of Display text based on the size of the text
    public func optimalHeight() -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = self.lineBreakMode
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }
    
    /// Common setups for GSK Display Text.
    private func commonConfiguration() {
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.setFontStyling()
        self.frame.size.height = optimalHeight()
    }
    /// Sets the font name based on the type of display text selected
    private func setFontStyling() {
        switch style {
        case .h1 :
            self.font = UIFont(name: "CollabApp-Light", size: 56.0)
        case .h2, .h3, .h4, .h5, .h6, .body1, .body2, .smalltitle :
            setFontSize(fontName: "CollabApp-Regular")
        case .subtitle, .caption, .textbutton:
            setFontSize(fontName: "CollabApp-Bold")
        }
    }
    /// Sets the font size based on font name
    private func setFontSize(fontName: String) {
        if style == .h2 {
            self.font = UIFont(name: fontName, size: 48.0)
        } else if style == .h3 {
            self.font = UIFont(name: fontName, size: 32.0)
        } else if style == .h4 {
            self.font = UIFont(name: fontName, size: 24.0)
        } else if style == .h5 {
            self.font = UIFont(name: fontName, size: 20.0)
        } else if style == .h6 {
            self.font = UIFont(name: fontName, size: 18.0)
        } else if style == .body1 {
            self.font = UIFont(name: fontName, size: 16.0)
        } else if style == .body2 {
            self.font = UIFont(name: fontName, size: 14.0)
        } else if style == .smalltitle {
            self.font = UIFont(name: fontName, size: 12.0)
        } else if style == .subtitle {
            self.font = UIFont(name: fontName, size: 16.0)
        } else if style == .caption {
            self.font = UIFont(name: fontName, size: 12.0)
        } else {
            self.font = UIFont(name: fontName, size: 12.0)
        }
    }
}

