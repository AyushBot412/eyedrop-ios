

import AVFoundation
import CoreLocation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }

    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }

    func textContainerView(view: UIView, _ image: UIImage, _ textField: UITextField, lineColor: UIColor, hideLine: Bool=false) -> UIView {
        backgroundColor = .clear
        let totalHeight = SizeManager.deviceWidth/7
        let imageHeight = totalHeight - (SizeManager.padding*2)
        
        heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = lineColor
      

        addSubview(imageView)
        imageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, centerY: centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: imageHeight, height: imageHeight)
        imageView.tag = 0

        addSubview(textField)
        textField.anchor(top: topAnchor, left: imageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: SizeManager.padding, paddingBottom: 0, paddingRight: 0)
        textField.tag = 100

        if !hideLine {
            let separatorView = UIView()
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            separatorView.backgroundColor = lineColor.withAlphaComponent(0.87)
            addSubview(separatorView)
            separatorView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.75)
            separatorView.tag = 2
        }
     

        return self
    }

    func pinEdges(to view: UIView, safe: Bool = false, padding: CGFloat = 0) {
        if safe {
            anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding)
        } else {
            anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding)
        }
    }
}

extension UITextField {
    func textField(withPlaceolder placeholder: String?, textColor: UIColor, isSecureTextEntry: Bool, isTextEntry: Bool) -> UITextField {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = Fonts.secondary
        tf.textColor = textColor
        tf.isSecureTextEntry = isSecureTextEntry
        if placeholder != nil {
            tf.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
        tf.autocorrectionType = .no
        if isTextEntry {
            tf.keyboardType = .default
        } else {
            tf.keyboardType = .decimalPad
        }

        return tf
    }
}

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }

    static func blue() -> UIColor {
        return UIColor.rgb(red: 17, green: 154, blue: 237)
    }

    static func purple() -> UIColor {
        return UIColor.rgb(red: 98, green: 0, blue: 238)
    }

    static func pink() -> UIColor {
        return UIColor.rgb(red: 255, green: 148, blue: 194)
    }

    static func teal() -> UIColor {
        return UIColor.rgb(red: 3, green: 218, blue: 197)
    }

    static func mainBlue() -> UIColor {
        return UIColor.rgb(red: 0, green: 150, blue: 255)
    }

    static func googleRed() -> UIColor {
        return UIColor.rgb(red: 220, green: 78, blue: 65)
    }
}

extension UIImage {
    class func resize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio = targetSize.width / image.size.width
        let heightRatio = targetSize.height / image.size.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    class func scale(image: UIImage, by scale: CGFloat) -> UIImage? {
        let size = image.size
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        return UIImage.resize(image: image, targetSize: scaledSize)
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}

class CopyableLabel: UILabel {
    override public var canBecomeFirstResponder: Bool {
        return true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(
            target: self,
            action: #selector(showCopyMenu(sender:))
        ))
    }

    override func copy(_: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }

    @objc func showCopyMenu(sender _: Any?) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }

    override func canPerformAction(_ action: Selector, withSender _: Any?) -> Bool {
        return (action == #selector(copy(_:)))
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }
}

extension UILabel {
    var actualNumberOfLines: Int {
        let textStorage = NSTextStorage(attributedString: attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = lineBreakMode
        layoutManager.addTextContainer(textContainer)

        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var numberOfLines = 0, index = 0, lineRange = NSMakeRange(0, 1)

        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
}

extension String {
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIStackView {
    func addBackground(color: UIColor, cornerRadius: CGFloat, borderColor: CGColor? = nil, borderWidth: CGFloat? = nil) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.layer.cornerRadius = cornerRadius
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        if borderColor != nil {
            subView.layer.borderColor = borderColor!
            subView.layer.borderWidth = borderWidth!
        }

        insertSubview(subView, at: 0)
    }
}

@IBDesignable class PaddingLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 10.0
    @IBInspectable var bottomInset: CGFloat = 10.0
    @IBInspectable var leftInset: CGFloat = 10.0
    @IBInspectable var rightInset: CGFloat = 10.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    func insets(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        topInset = top
        bottomInset = bottom
        leftInset = left
        rightInset = right
    }

    func blur(_ blurRadius: Double = 2.5) {
        let blurredImage = getBlurryImage(blurRadius)
        let blurredImageView = UIImageView(image: blurredImage)
        blurredImageView.translatesAutoresizingMaskIntoConstraints = false
        blurredImageView.tag = 100
        blurredImageView.contentMode = .center
        blurredImageView.backgroundColor = .white
        addSubview(blurredImageView)
        NSLayoutConstraint.activate([
            blurredImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurredImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func unblur() {
        subviews.forEach { subview in
            if subview.tag == 100 {
                subview.removeFromSuperview()
            }
        }
    }

    private func getBlurryImage(_ blurRadius: Double = 2.5) -> UIImage? {
        UIGraphicsBeginImageContext(bounds.size)
        if let x = UIGraphicsGetCurrentContext() {
            layer.render(in: x)
        } else {
            return nil
        }

        guard let image = UIGraphicsGetImageFromCurrentImageContext(),
              let blurFilter = CIFilter(name: "CIGaussianBlur")
        else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()

        blurFilter.setDefaults()

        blurFilter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        blurFilter.setValue(blurRadius, forKey: kCIInputRadiusKey)

        var convertedImage: UIImage?
        let context = CIContext(options: nil)
        if let blurOutputImage = blurFilter.outputImage,
           let cgImage = context.createCGImage(blurOutputImage, from: blurOutputImage.extent)
        {
            convertedImage = UIImage(cgImage: cgImage)
        }

        return convertedImage
    }
}

extension UITabBarController {
    func createNavigationController(VC: UIViewController, selectedImage: UIImage, unselctedImage: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: VC)
        navController.tabBarItem.image = unselctedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}

extension UIImageView {
    func makeRounded() {
   
        layer.masksToBounds = false
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}

extension UIImage {
    func circularImage(size size: CGSize?) -> UIImage {
        let newSize = size ?? self.size

        let minEdge = min(newSize.height, newSize.width)
        let size = CGSize(width: minEdge, height: minEdge)

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()

        draw(in: CGRect(origin: CGPoint.zero, size: size), blendMode: .copy, alpha: 1.0)

        context!.setBlendMode(.copy)
        context!.setFillColor(UIColor.clear.cgColor)

        let rectPath = UIBezierPath(rect: CGRect(origin: CGPoint.zero, size: size))
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: size))
        rectPath.append(circlePath)
        rectPath.usesEvenOddFillRule = true
        rectPath.fill()

        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return result
    }
}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            if UIApplication.shared.windows.count == 0 {
                // Should never occur, but…
                return false
            }
            let top = UIApplication.shared.windows[0].safeAreaInsets.top
            return top > 20 // That seem to be the minimum top when no notch…
        } else {
            // Fallback on earlier versions
            return false
        }
    }
}

extension UITableView {
    override open var intrinsicContentSize: CGSize {
        return contentSize
    }
}

extension Array {
    func insertionIndexOf(_ elem: Element, isOrderedBefore: (Element, Element) -> Bool) -> Int {
        var lo = 0
        var hi = count - 1
        while lo <= hi {
            let mid = (lo + hi) / 2
            if isOrderedBefore(self[mid], elem) {
                lo = mid + 1
            } else if isOrderedBefore(elem, self[mid]) {
                hi = mid - 1
            } else {
                return mid // found at position mid
            }
        }
        return lo // not found, would be inserted at position lo
    }

    func sumAll() -> Double {
        var sum = 0.0
        for x in self {
            if let d = x as? Double {
                sum += d
            }
        }
        return sum
    }
}

extension UIImage {
    func resizedImage(pixelSize: (width: Int, height: Int)) -> UIImage? {
        let size = CGSize(width: CGFloat(pixelSize.width) / UIScreen.main.scale, height: CGFloat(pixelSize.height) / UIScreen.main.scale)

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UIImage {
    func alpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        print("\(Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0) year diff")
        return abs(Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0)
    }

    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        print("\(Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0) month diff")
        return abs(Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0)
    }

    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        print("\(Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0) week diff")
        return abs(Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0)
    }

    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        print("\(Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0) day diff")
        return abs(Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0)
    }

    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        print("\(Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0) hour diff")
        return abs(Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0)
    }

    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        print("\(Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0) minute diff")
        return abs(Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0)
    }

    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        print("\(Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0) second diff")
        return abs(Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0)
    }

    /// Returns the amount of seconds from another date
    func nanoseconds(from date: Date) -> Int {
//        print("\(Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0) nanosecond diff")
        return abs(Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0)
    }

    func castToLocal() -> Date {
//        initTimeZone: TimeZone(identifier: "UTC")!, timeZone: NSTimeZone.local
        let delta = TimeInterval(NSTimeZone.local.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
    
    func castToUTC() -> Date {
        let delta = -(TimeInterval(NSTimeZone.local.secondsFromGMT(for: self)))
        return addingTimeInterval(delta)
    }
    

    
    func unixTimeStampMillis() -> Int {
        return Int(self.timeIntervalSince1970) * 1000
    }
    

    
  

}

public extension UIColor {
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x0000_00FF) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

enum wordType {
    case hashtag
    case mention
}

// A custom text view that allows hashtags and @ symbols to be separated from the rest of the text and triggers actions upon selection
class AttrTextView: UITextView {
    var textString: NSString?
    var attrString: NSMutableAttributedString?
    var callBack: ((String, wordType) -> Void)?
    var otherCallBack: ((Bool, UITableViewCell) -> Void)?
    var isCaption: Bool!
    weak var cell: UITableViewCell?
    var attrTap: UITapGestureRecognizer!

    public func setText(text: String, withHashtagColor hashtagColor: UIColor, andMentionColor mentionColor: UIColor, andCallBack callBack: @escaping (String, wordType) -> Void, andOtherCallBack otherCallBack: ((Bool, UITableViewCell) -> Void)? = nil, andIsCaption isCaption: Bool?=nil, andCell cell: UITableViewCell?=nil, normalFont: UIFont, hashTagFont: UIFont, mentionFont: UIFont) {
        self.callBack = callBack
        self.otherCallBack = otherCallBack
        self.isCaption = isCaption
        self.cell = cell
        
        attrString = NSMutableAttributedString(string: text)
        textString = NSString(string: text)

        // Set initial font attributes for our string
        attrString?.addAttribute(NSAttributedString.Key.font, value: normalFont, range: NSRange(location: 0, length: (textString?.length)!))
        attrString?.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: (textString?.length)!))

        // Call a custom set Hashtag and Mention Attributes Function
        setAttrWithName(attrName: "Hashtag", wordPrefix: "#", color: hashtagColor, text: text, font: hashTagFont)
        setAttrWithName(attrName: "Mention", wordPrefix: "@", color: mentionColor, text: text, font: mentionFont)

        // Add tap gesture that calls a function tapRecognized when tapped
        attrTap =  UITapGestureRecognizer(target: self, action: #selector(tapRecognized(tapGesture:)))
        addGestureRecognizer(attrTap)
    }

    private func setAttrWithName(attrName: String, wordPrefix: String, color: UIColor, text: String, font: UIFont) {
        // Words can be separated by either a space or a line break
        let charSet = CharacterSet(charactersIn: " \n")
        let words = text.components(separatedBy: charSet)

        // Filter to check for the # or @ prefix
        for word in words.filter({ $0.hasPrefix(wordPrefix) }) {
            let range = textString!.range(of: word)
            attrString?.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            attrString?.addAttribute(NSAttributedString.Key(rawValue: attrName), value: 1, range: range)
            attrString?.addAttribute(NSAttributedString.Key(rawValue: "Clickable"), value: 1, range: range)
            attrString?.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
        attributedText = attrString
    }

    @objc func tapRecognized(tapGesture: UITapGestureRecognizer) {
        var wordString: String? // The String value of the word to pass into callback function
        var char: NSAttributedString! // The character the user clicks on. It is non optional because if the user clicks on nothing, char will be a space or " "
        var word: NSAttributedString? // The word the user clicks on
        var isHashtag: AnyObject?
        var isAtMention: AnyObject?

        // Gets the range of the character at the place the user taps
        let point = tapGesture.location(in: self)
        let charPosition = closestPosition(to: point)
        let charRange = tokenizer.rangeEnclosingPosition(charPosition!, with: .character, inDirection: UITextDirection(rawValue: 1))

        // Checks if the user has tapped on a character.
        if charRange != nil {
            let location = offset(from: beginningOfDocument, to: charRange!.start)
            let length = offset(from: charRange!.start, to: charRange!.end)
            let attrRange = NSMakeRange(location, length)
            char = attributedText.attributedSubstring(from: attrRange)

            // If the user has not clicked on anything, exit the function
            if char.string == " " {
                print("User clicked on nothing")
                // Tapped on non-tagged text
                if let cell = self.cell {
                    self.otherCallBack?(self.isCaption, cell)
                }
                return
            }

            // Checks the character's attribute, if any
            isHashtag = char?.attribute(NSAttributedString.Key(rawValue: "Hashtag"), at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, char!.length)) as AnyObject?
            isAtMention = char?.attribute(NSAttributedString.Key(rawValue: "Mention"), at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, char!.length)) as AnyObject?
        }

        // Gets the range of the word at the place user taps
        let wordRange = tokenizer.rangeEnclosingPosition(charPosition!, with: .word, inDirection: UITextDirection(rawValue: 1))

        /*
         Check if wordRange is nil or not. The wordRange is nil if:
         1. The User clicks on the "#" or "@"
         2. The User has not clicked on anything. We already checked whether or not the user clicks on nothing so 1 is the only possibility
         */
        if wordRange != nil {
            // Get the word. This will not work if the char is "#" or "@" ie, if the user clicked on the # or @ in front of the word
            let wordLocation = offset(from: beginningOfDocument, to: wordRange!.start)
            let wordLength = offset(from: wordRange!.start, to: wordRange!.end)
            let wordAttrRange = NSMakeRange(wordLocation, wordLength)
            word = attributedText.attributedSubstring(from: wordAttrRange)
            wordString = word!.string
        } else {
            /*
             Because the user has clicked on the @ or # in front of the word, word will be nil as
             tokenizer.rangeEnclosingPosition(charPosition!, with: .word, inDirection: 1) does not work with special characters.
             What I am doing here is modifying the x position of the point the user taps the screen. Moving it to the right by about 12 points will move the point where we want to detect for a word, ie to the right of the # or @ symbol and onto the word's text
             */
            var modifiedPoint = point
            modifiedPoint.x += 12
            let modifiedPosition = closestPosition(to: modifiedPoint)
            let modifedWordRange = tokenizer.rangeEnclosingPosition(modifiedPosition!, with: .word, inDirection: UITextDirection(rawValue: 1))
            if modifedWordRange != nil {
                let wordLocation = offset(from: beginningOfDocument, to: modifedWordRange!.start)
                let wordLength = offset(from: modifedWordRange!.start, to: modifedWordRange!.end)
                let wordAttrRange = NSMakeRange(wordLocation, wordLength)
                word = attributedText.attributedSubstring(from: wordAttrRange)
                wordString = word!.string
            }
        }

        if let stringToPass = wordString {
            // Runs callback function if word is a Hashtag or Mention
            if isHashtag != nil, callBack != nil {
                callBack!(stringToPass, wordType.hashtag)
            } else if isAtMention != nil, callBack != nil {
                callBack!(stringToPass, wordType.mention)
            } else {
                // Tapped on non-tagged text
                if let cell = self.cell {
                    self.otherCallBack?(self.isCaption, cell)
                }
            }
        }
    }
}

extension String {
    func words() -> [String] {
        var words = [String]()
        var currWord = ""
        var nextWord = false
        var encounteredNonWhiteSpace = false
        for char in self {
            if char.isWhitespace {
                if !currWord.isEmpty {
                    words.append(currWord)
                }

                words.append("\(char)")
                currWord = ""
                encounteredNonWhiteSpace = false
            } else {
                currWord.append(char)
                encounteredNonWhiteSpace = true
            }
        }
        return words + [currWord]
    }

    //
    //        func words() -> [String] {
    //
    //            var words = [String]()
    //            var currWord = ""
    //            var nextWord = false
    //            var encounteredNonWhiteSpace = false
    //            for char in self {
    //                if (!char.isWhitespace || !encounteredNonWhiteSpace) {
    //                    currWord.append(char)
    //    //                nextWord = false
    //                } else {
    //    //                nextWord = true
    //                    words.append(currWord)
    //                    currWord = ""
    //                }
    //
    //                if char.isWhitespace {
    //                    encounteredNonWhiteSpace = false
    //                } else {
    //                    encounteredNonWhiteSpace = true
    //                }
    //            }
    //            return words + [currWord]
    //        }
}

class TriangleView: UIView {
    var color: UIColor!
    var borderWidth: CGFloat?
    var borderColor: UIColor?
    
    func setup(color: UIColor, borderWidth: CGFloat?=nil, borderColor: UIColor?=nil) {
        self.color = color
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX / 2.0, y: rect.minY))
        context.closePath()
        
        
       
//        context.addCurve(to: CGPoint(x: rect.maxX / 2.0, y: rect.minY), control1: CGPoint(x: rect.minX, y: rect.maxY), control2: CGPoint(x: rect.maxX, y: rect.maxY))
        
        if let borderWidth = self.borderWidth, let borderColor = self.borderColor  {
            context.setLineWidth(borderWidth)
            context.setStrokeColor(borderColor.cgColor)
            context.setFillColor(color.cgColor)
            context.drawPath(using: .fillStroke) // Fill and strokeWidth = self.borderWidth {
            
        } else {
            context.setFillColor(color.cgColor)
            context.fillPath()
        }

        
        
     


    }
}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: size.width + insets.left + insets.right,
                   height: size.height + insets.top + insets.bottom), false, scale
        )
        _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}

extension Int {
    func beautify(abr: Bool = true) -> String {
        var normalized = ""

        if abr {
            var mod = 0
            if self < 1000 {
                return "\(self)"
            } else if self < 1_000_000 {
                normalized = "\(Int(self / 1000))"
                mod = Int((self % 1000) / 100)
                if mod > 0 {
                    normalized.append(".\(mod)K")
                } else {
                    normalized.append("K")
                }
            } else {
                normalized = "\(Int(self / 1_000_000))"
                mod = Int((self % 1_000_000) / 100_000)
                if mod > 0 {
                    normalized.append(".\(mod)M")
                } else {
                    normalized.append("M")
                }
            }
            return normalized
        } else {
            let num = String(self)

            var count = 1
            for char in num.reversed() {
                normalized.append(char)
                if count == 3 {
                    normalized += ","
                    count = 1
                } else {
                    count += 1
                }
            }

            if normalized.last == "," {
                normalized.removeLast()
            }
            return String(normalized.reversed())
        }
    }
}

extension URL {
    func generateThumbnail() -> UIImage? {
        do {
            let asset = AVURLAsset(url: self, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            print(thumbnail)
            return thumbnail
        } catch {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
}

extension UIImage {
    func convertToGrayScale() -> UIImage {
        // Create image rectangle with current image width/height
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        // Grayscale color space
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = size.width
        let height = size.height

        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(cgImage!, in: imageRect)
        let imageRef = context!.makeImage()

        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef!)

        return newImage
    }
}

class UIButtonSpinner: UIButton, SpinnerDelegate {
    var realBackgroundColor: UIColor?
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.alpha = 1
        spinner.isHidden = true
        return spinner
    }()

    func startAnimatingSpinner() {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = false
            if self.realBackgroundColor == nil {
                self.realBackgroundColor  = self.backgroundColor
            }

            self.spinner.isHidden = false
            self.titleLabel?.alpha = 0
            self.titleLabel?.textColor = self.titleLabel?.textColor.withAlphaComponent(0)
            self.tintColor = self.tintColor.withAlphaComponent(0)
            self.imageView?.alpha = 0
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0)
        }
    }

    func stopAnimatingSpinner() {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = true

            self.spinner.isHidden = true
            self.titleLabel?.alpha = 1
            self.titleLabel?.textColor = self.titleLabel?.textColor.withAlphaComponent(1)
            self.tintColor = self.tintColor.withAlphaComponent(1)
            self.imageView?.alpha = 1
            if self.backgroundColor != UIColor.clear {
                self.backgroundColor = self.realBackgroundColor
            }
        }
    }

    func configureSpinner(color: UIColor = UIColor.darkGray) {
        addSubview(spinner)
        spinner.pinEdges(to: self)
        spinner.color = color
    }
}

class UIImageViewSpinner: UIImageView, SpinnerDelegate {
    var hideImage = false
    var highAlphaImg: UIImage?
    var associatedView: UIView?
    var interactionAlwaysEnabled = false
    var interactionEnabled = true

    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.alpha = 1
        spinner.isHidden = true
        spinner.contentMode = .scaleAspectFit
        return spinner
    }()

    func startAnimatingSpinner() {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = self.interactionAlwaysEnabled ? true : false
            self.associatedView?.isUserInteractionEnabled = false
            self.spinner.isHidden = false

            if self.highAlphaImg == nil {
                self.highAlphaImg = self.image
            }
            self.image = self.image?.alpha(self.hideImage ? 0 : 0.7)
        }
    }

    func stopAnimatingSpinner() {
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = self.interactionEnabled
            self.associatedView?.isUserInteractionEnabled = true

            self.spinner.isHidden = true

            if self.highAlphaImg != nil {
                self.image = self.highAlphaImg
            }
        }
    }

    func configureSpinner(color: UIColor = UIColor.darkGray, style: UIActivityIndicatorView.Style = .medium, withShadow: Bool = true, hideImage: Bool = false, interactionAlwaysEnabled: Bool = false, interactionEnabled: Bool = true) {
        addSubview(spinner)
        spinner.pinEdges(to: self)
        spinner.color = color
        spinner.style = style
        self.hideImage = hideImage
        self.interactionAlwaysEnabled = interactionAlwaysEnabled
        self.interactionEnabled = interactionEnabled

        if withShadow {
            spinner.layer.shadowColor = UIColor.black.cgColor
            spinner.layer.shadowOffset = .zero
            spinner.layer.shadowOpacity = 100
            spinner.layer.shadowRadius = 1.5
        }
        spinner.clipsToBounds = false
        spinner.layer.masksToBounds = true
    }
}

extension String {
    func forURL() -> String {
        var result = ""
        for word in split(separator: " ") {
            result.append(word + "+")
        }
        result.removeLast()
        return result.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

extension UIColor {
    func toUInt() -> UInt? {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0
        if getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            return UInt(rgb)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}



public extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
                switch identifier {
                case "iPod5,1": return "iPod touch (5th generation)"
                case "iPod7,1": return "iPod touch (6th generation)"
                case "iPod9,1": return "iPod touch (7th generation)"
                case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
                case "iPhone4,1": return "iPhone 4s"
                case "iPhone5,1", "iPhone5,2": return "iPhone 5"
                case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
                case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
                case "iPhone7,2": return "iPhone 6"
                case "iPhone7,1": return "iPhone 6 Plus"
                case "iPhone8,1": return "iPhone 6s"
                case "iPhone8,2": return "iPhone 6s Plus"
                case "iPhone8,4": return "iPhone SE"
                case "iPhone9,1", "iPhone9,3": return "iPhone 7"
                case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
                case "iPhone10,1", "iPhone10,4": return "iPhone 8"
                case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
                case "iPhone10,3", "iPhone10,6": return "iPhone X"
                case "iPhone11,2": return "iPhone XS"
                case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
                case "iPhone11,8": return "iPhone XR"
                case "iPhone12,1": return "iPhone 11"
                case "iPhone12,3": return "iPhone 11 Pro"
                case "iPhone12,5": return "iPhone 11 Pro Max"
                case "iPhone12,8": return "iPhone SE (2nd generation)"
                case "iPhone13,1": return "iPhone 12 mini"
                case "iPhone13,2": return "iPhone 12"
                case "iPhone13,3": return "iPhone 12 Pro"
                case "iPhone13,4": return "iPhone 12 Pro Max"
                case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
                case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad (3rd generation)"
                case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad (4th generation)"
                case "iPad6,11", "iPad6,12": return "iPad (5th generation)"
                case "iPad7,5", "iPad7,6": return "iPad (6th generation)"
                case "iPad7,11", "iPad7,12": return "iPad (7th generation)"
                case "iPad11,6", "iPad11,7": return "iPad (8th generation)"
                case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
                case "iPad5,3", "iPad5,4": return "iPad Air 2"
                case "iPad11,3", "iPad11,4": return "iPad Air (3rd generation)"
                case "iPad13,1", "iPad13,2": return "iPad Air (4th generation)"
                case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad mini"
                case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad mini 2"
                case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad mini 3"
                case "iPad5,1", "iPad5,2": return "iPad mini 4"
                case "iPad11,1", "iPad11,2": return "iPad mini (5th generation)"
                case "iPad6,3", "iPad6,4": return "iPad Pro (9.7-inch)"
                case "iPad7,3", "iPad7,4": return "iPad Pro (10.5-inch)"
                case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return "iPad Pro (11-inch) (1st generation)"
                case "iPad8,9", "iPad8,10": return "iPad Pro (11-inch) (2nd generation)"
                case "iPad6,7", "iPad6,8": return "iPad Pro (12.9-inch) (1st generation)"
                case "iPad7,1", "iPad7,2": return "iPad Pro (12.9-inch) (2nd generation)"
                case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return "iPad Pro (12.9-inch) (3rd generation)"
                case "iPad8,11", "iPad8,12": return "iPad Pro (12.9-inch) (4th generation)"
                case "AppleTV5,3": return "Apple TV"
                case "AppleTV6,2": return "Apple TV 4K"
                case "AudioAccessory1,1": return "HomePod"
                case "AudioAccessory5,1": return "HomePod mini"
                case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
                default: return identifier
                }
            #elseif os(tvOS)
                switch identifier {
                case "AppleTV5,3": return "Apple TV 4"
                case "AppleTV6,2": return "Apple TV 4K"
                case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
                default: return identifier
                }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()
}

extension URL {
    func imageFromVideo(at time: TimeInterval, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let asset = AVURLAsset(url: self)

            let assetIG = AVAssetImageGenerator(asset: asset)
            assetIG.appliesPreferredTrackTransform = true
            assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels

            let cmTime = CMTime(seconds: time, preferredTimescale: 60)
            let thumbnailImageRef: CGImage
            do {
                thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
            } catch {
                print("Error: \(error)")
                return completion(nil)
            }

            DispatchQueue.main.async {
                completion(UIImage(cgImage: thumbnailImageRef))
            }
        }
    }
}

extension UIViewController {
    func wasPopped() -> Bool {
        return navigationController == nil
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }

    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }

    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }

    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
              .range(of: string, options: options)
        {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension UIView {
    
    public func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)

    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
        
        
    }
}



class MyDate {
    
    public func now() -> Date {
        return Date().castToLocal()
    }
}




extension CLVisit {
    func getArrivalDate() -> Date? {
        if self.arrivalDate.years(from: Date()) > 10 {
            return nil
        }
        return self.arrivalDate.castToLocal()
    }
    
    func getDepartureDate() -> Date? {
        if self.departureDate.years(from: Date()) > 10 {
            return nil
        }
        return self.departureDate.castToLocal()
    }
}


extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}





extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}


extension UIView
{
   func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
   }
}


public extension UIImage {

    /**
    Returns the flat colorized version of the image, or self when something was wrong

    - Parameters:
        - color: The colors to user. By defaut, uses the ``UIColor.white`

    - Returns: the flat colorized version of the image, or the self if something was wrong
    */
    func colorized(with color: UIColor = .white) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }


        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        color.setFill()
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: rect, mask: cgImage)
        context.fill(rect)

        guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }

        return colored
    }

    /**
    Returns the stroked version of the fransparent image with the given stroke color and the thickness.

    - Parameters:
        - color: The colors to user. By defaut, uses the ``UIColor.white`
        - thickness: the thickness of the border. Default to `2`
        - quality: The number of degrees (out of 360): the smaller the best, but the slower. Defaults to `10`.

    - Returns: the stroked version of the image, or self if something was wrong
    */

    func stroked(with color: UIColor = .white, thickness: CGFloat = 2, quality: CGFloat = 10) -> UIImage {

        guard let cgImage = cgImage else { return self }

        // Colorize the stroke image to reflect border color
        let strokeImage = colorized(with: color)

        guard let strokeCGImage = strokeImage.cgImage else { return self }

        /// Rendering quality of the stroke
        let step = quality == 0 ? 10 : abs(quality)

        let oldRect = CGRect(x: thickness, y: thickness, width: size.width, height: size.height).integral
        let newSize = CGSize(width: size.width + 2 * thickness, height: size.height + 2 * thickness)
        let translationVector = CGPoint(x: thickness, y: 0)


        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)

        guard let context = UIGraphicsGetCurrentContext() else { return self }

        defer {
            UIGraphicsEndImageContext()
        }
        context.translateBy(x: 0, y: newSize.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.interpolationQuality = .high

        for angle: CGFloat in stride(from: 0, to: 360, by: step) {
            let vector = translationVector.rotated(around: .zero, byDegrees: angle)
            let transform = CGAffineTransform(translationX: vector.x, y: vector.y)

            context.concatenate(transform)

            context.draw(strokeCGImage, in: oldRect)

            let resetTransform = CGAffineTransform(translationX: -vector.x, y: -vector.y)
            context.concatenate(resetTransform)
        }

        context.draw(cgImage, in: oldRect)

        guard let stroked = UIGraphicsGetImageFromCurrentImageContext() else { return self }

        return stroked
    }
}


extension CGPoint {
    /**
    Rotates the point from the center `origin` by `byDegrees` degrees along the Z axis.

    - Parameters:
        - origin: The center of he rotation;
        - byDegrees: Amount of degrees to rotate around the Z axis.

    - Returns: The rotated point.
    */
    func rotated(around origin: CGPoint, byDegrees: CGFloat) -> CGPoint {
        let dx = x - origin.x
        let dy = y - origin.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + byDegrees * .pi / 180.0 // to radians
        let x = origin.x + radius * cos(newAzimuth)
        let y = origin.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}


extension UIViewController {
    func configureNavigationBar(title: String, buttonTitles: [String?]?=nil, buttonImages: [String?]?=nil, selectors: [Selector?]?=nil, colors: [UIColor?]?) {
        let NC = self.navigationController!
        
        NC.setNavigationBarHidden(false, animated: false)
        NC.navigationBar.tintColor = .black
        NC.navigationBar.barTintColor = .white
        NC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title2) ]
        NC.interactivePopGestureRecognizer?.isEnabled = true

        self.title = title
        
        var leftItems = [UIBarButtonItem]()
        var rightItems = [UIBarButtonItem]()
        
        //Create buttons with titles
        if let buttonTitles = buttonTitles {
            for (i, buttonTitle) in buttonTitles.enumerated() {
                guard let buttonTitle = buttonTitle else { continue }
                
                if i == 0 {
                    leftItems.append(Factory.createTextBarItem(VC: self,  text: buttonTitle,  f: selectors![i]!, color: colors![i]!))
                } else {
                    rightItems.append(Factory.createTextBarItem(VC: self, text: buttonTitle, f: selectors![i]!, color: colors![i]!))
                }

            }
        }
        
        //Create buttons with images
        if let buttonImages = buttonImages {
            for (i, buttonImage) in buttonImages.enumerated() {
                guard let buttonImage = buttonImage else { continue }
                
                if i == 0 {
                    leftItems.append(Factory.createImageBarItem(VC: self, image: buttonImage, color: colors![i]!, f: selectors![i]!))
                } else {
                    rightItems.append(Factory.createImageBarItem(VC: self, image: buttonImage, color: colors![i]!, f: selectors![i]!))
                }

            }
        }
        

        self.navigationItem.leftBarButtonItems = leftItems
        self.navigationItem.rightBarButtonItems = rightItems
        

        
    }
}

extension CIImage {
    // Convert CIImage to UIImage
    func convert() -> UIImage {
         let context = CIContext(options: nil)
         let cgImage = context.createCGImage(self, from: self.extent)!
         let image = UIImage(cgImage: cgImage)
         return image
    }
}
