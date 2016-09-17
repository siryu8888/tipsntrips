/*
* Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*	*	Redistributions of source code must retain the above copyright notice, this
*		list of conditions and the following disclaimer.
*
*	*	Redistributions in binary form must reproduce the above copyright notice,
*		this list of conditions and the following disclaimer in the documentation
*		and/or other materials provided with the distribution.
*
*	*	Neither the name of Material nor the names of its
*		contributors may be used to endorse or promote products derived from
*		this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


@objc(TextViewDelegate)
public protocol TextViewDelegate : UITextViewDelegate {}

@IBDesignable
@objc(TextView)
open class TextView: UITextView {
	/**
	This property is the same as clipsToBounds. It crops any of the view's
	contents from bleeding past the view's frame.
	*/
	@IBInspectable open var masksToBounds: Bool {
		get {
			return layer.masksToBounds
		}
		set(value) {
			layer.masksToBounds = value
		}
	}
	
	/// A property that accesses the backing layer's backgroundColor.
	@IBInspectable open override var backgroundColor: UIColor? {
		didSet {
			layer.backgroundColor = backgroundColor?.cgColor
		}
	}
	
	/// A property that accesses the layer.frame.origin.x property.
	@IBInspectable open var x: CGFloat {
		get {
			return layer.frame.origin.x
		}
		set(value) {
			layer.frame.origin.x = value
		}
	}
	
	/// A property that accesses the layer.frame.origin.y property.
	@IBInspectable open var y: CGFloat {
		get {
			return layer.frame.origin.y
		}
		set(value) {
			layer.frame.origin.y = value
		}
	}
	
	/// A property that accesses the layer.frame.size.width property.
	@IBInspectable open var width: CGFloat {
		get {
			return layer.frame.size.width
		}
		set(value) {
			layer.frame.size.width = value
		}
	}
	
	/// A property that accesses the layer.frame.size.height property.
	@IBInspectable open var height: CGFloat {
		get {
			return layer.frame.size.height
		}
		set(value) {
			layer.frame.size.height = value
		}
	}
	
	/// A property that accesses the backing layer's shadowColor.
	@IBInspectable open var shadowColor: UIColor? {
		didSet {
			layer.shadowColor = shadowColor?.cgColor
		}
	}
	
	/// A property that accesses the backing layer's shadowOffset.
	@IBInspectable open var shadowOffset: CGSize {
		get {
			return layer.shadowOffset
		}
		set(value) {
			layer.shadowOffset = value
		}
	}
	
	/// A property that accesses the backing layer's shadowOpacity.
	@IBInspectable open var shadowOpacity: Float {
		get {
			return layer.shadowOpacity
		}
		set(value) {
			layer.shadowOpacity = value
		}
	}
	
	/// A property that accesses the backing layer's shadowRadius.
	@IBInspectable open var shadowRadius: CGFloat {
		get {
			return layer.shadowRadius
		}
		set(value) {
			layer.shadowRadius = value
		}
	}
	
	/// A property that accesses the backing layer's shadowPath.
	@IBInspectable open var shadowPath: CGPath? {
		get {
			return layer.shadowPath
		}
		set(value) {
			layer.shadowPath = value
		}
	}
	
	/// Enables automatic shadowPath sizing.
	@IBInspectable open var shadowPathAutoSizeEnabled: Bool = true {
		didSet {
			if shadowPathAutoSizeEnabled {
				layoutShadowPath()
			}
		}
	}
	
	/**
	A property that sets the shadowOffset, shadowOpacity, and shadowRadius
	for the backing layer. This is the preferred method of setting depth
	in order to maintain consitency across UI objects.
	*/
	open var depth: MaterialDepth = .none {
		didSet {
			let value: MaterialDepthType = MaterialDepthToValue(depth)
			shadowOffset = value.offset
			shadowOpacity = value.opacity
			shadowRadius = value.radius
			layoutShadowPath()
		}
	}
	
	/// A property that sets the cornerRadius of the backing layer.
	open var cornerRadiusPreset: MaterialRadius = .none {
		didSet {
			if let v: MaterialRadius = cornerRadiusPreset {
				cornerRadius = MaterialRadiusToValue(v)
			}
		}
	}
	
	/// A property that accesses the layer.cornerRadius.
	@IBInspectable open var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set(value) {
			layer.cornerRadius = value
			layoutShadowPath()
		}
	}
	
	/// A preset property to set the borderWidth.
	open var borderWidthPreset: MaterialBorder = .none {
		didSet {
			borderWidth = MaterialBorderToValue(borderWidthPreset)
		}
	}
	
	/// A property that accesses the layer.borderWith.
	@IBInspectable open var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set(value) {
			layer.borderWidth = value
		}
	}
	
	/// A property that accesses the layer.borderColor property.
	@IBInspectable open var borderColor: UIColor? {
		get {
			return nil == layer.borderColor ? nil : UIColor(cgColor: layer.borderColor!)
		}
		set(value) {
			layer.borderColor = value?.cgColor
		}
	}
	
	/// A property that accesses the layer.position property.
	@IBInspectable open var position: CGPoint {
		get {
			return layer.position
		}
		set(value) {
			layer.position = value
		}
	}
	
	/// A property that accesses the layer.zPosition property.
	@IBInspectable open var zPosition: CGFloat {
		get {
			return layer.zPosition
		}
		set(value) {
			layer.zPosition = value
		}
	}
	
	/**
	The title UILabel that is displayed when there is text. The 
	titleLabel text value is updated with the placeholderLabel
	text value before being displayed.
	*/
	open var titleLabel: UILabel? {
		didSet {
			prepareTitleLabel()
		}
	}
	
	/// The color of the titleLabel text when the textView is not active.
	@IBInspectable open var titleLabelColor: UIColor? {
		didSet {
			titleLabel?.textColor = titleLabelColor
		}
	}
	
	/// The color of the titleLabel text when the textView is active.
	@IBInspectable open var titleLabelActiveColor: UIColor?
	
	/**
	A property that sets the distance between the textView and
	titleLabel.
	*/
	@IBInspectable open var titleLabelAnimationDistance: CGFloat = 8
	
	/// Placeholder UILabel view.
	open var placeholderLabel: UILabel? {
		didSet {
			preparePlaceholderLabel()
		}
	}
	
	/// An override to the text property.
	@IBInspectable open override var text: String! {
		didSet {
			handleTextViewTextDidChange()
		}
	}
	
	/// An override to the attributedText property.
	open override var attributedText: NSAttributedString! {
		didSet {
			handleTextViewTextDidChange()
		}
	}
	
	/**
	Text container UIEdgeInset preset property. This updates the 
	textContainerInset property with a preset value.
	*/
	open var textContainerInsetPreset: MaterialEdgeInset = .none {
		didSet {
			textContainerInset = MaterialEdgeInsetToValue(textContainerInsetPreset)
		}
	}
	
	/// Text container UIEdgeInset property.
	open override var textContainerInset: UIEdgeInsets {
		didSet {
			reloadView()
		}
	}
	
	/**
	An initializer that initializes the object with a NSCoder object.
	- Parameter aDecoder: A NSCoder instance.
	*/
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		prepareView()
	}
	
	/**
	An initializer that initializes the object with a CGRect object.
	If AutoLayout is used, it is better to initilize the instance
	using the init() initializer.
	- Parameter frame: A CGRect instance.
	- Parameter textContainer: A NSTextContainer instance.
	*/
	public override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		prepareView()
	}
	
	/**
	A convenience initializer that is mostly used with AutoLayout.
	- Parameter textContainer: A NSTextContainer instance.
	*/
	public convenience init(textContainer: NSTextContainer?) {
		self.init(frame: CGRect.zero, textContainer: textContainer)
	}
	
	/** Denitializer. This should never be called unless you know
	what you are doing.
	*/
	deinit {
		removeNotificationHandlers()
	}
	
	/// Overriding the layout callback for subviews.
	open override func layoutSubviews() {
		super.layoutSubviews()
		layoutShadowPath()
		placeholderLabel?.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2
		titleLabel?.frame.size.width = bounds.width
	}
	
	/**
	A method that accepts CAAnimation objects and executes them on the
	view's backing layer.
	- Parameter animation: A CAAnimation instance.
	*/
	open func animate(_ animation: CAAnimation) {
		animation.delegate = self
		if let a: CABasicAnimation = animation as? CABasicAnimation {
			a.fromValue = (nil == layer.presentation() ? layer : layer.presentation() as! CALayer).value(forKeyPath: a.keyPath!)
		}
		if let a: CAPropertyAnimation = animation as? CAPropertyAnimation {
			layer.add(a, forKey: a.keyPath!)
		} else if let a: CAAnimationGroup = animation as? CAAnimationGroup {
			layer.add(a, forKey: nil)
		} else if let a: CATransition = animation as? CATransition {
			layer.add(a, forKey: kCATransition)
		}
	}
	
	/**
	A delegation method that is executed when the backing layer starts
	running an animation.
	- Parameter anim: The currently running CAAnimation instance.
	*/
	open override func animationDidStart(_ anim: CAAnimation) {
		(delegate as? MaterialAnimationDelegate)?.materialAnimationDidStart?(anim)
	}
	
	/**
	A delegation method that is executed when the backing layer stops
	running an animation.
	- Parameter anim: The CAAnimation instance that stopped running.
	- Parameter flag: A boolean that indicates if the animation stopped
	because it was completed or interrupted. True if completed, false
	if interrupted.
	*/
	open override func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		if let a: CAPropertyAnimation = anim as? CAPropertyAnimation {
			if let b: CABasicAnimation = a as? CABasicAnimation {
				if let v: AnyObject = b.toValue as AnyObject? {
					if let k: String = b.keyPath {
						layer.setValue(v, forKeyPath: k)
						layer.removeAnimation(forKey: k)
					}
				}
			}
			(delegate as? MaterialAnimationDelegate)?.materialAnimationDidStop?(anim, finished: flag)
		} else if let a: CAAnimationGroup = anim as? CAAnimationGroup {
			for x in a.animations! {
				animationDidStop(x, finished: true)
			}
		}
	}
	
	/// Reloads necessary components when the view has changed.
	internal func reloadView() {
		if let p = placeholderLabel {
			removeConstraints(constraints)
			layout(p).edges(
				top: textContainerInset.top,
				left: textContainerInset.left + textContainer.lineFragmentPadding,
				bottom: textContainerInset.bottom,
				right: textContainerInset.right + textContainer.lineFragmentPadding)
		}
	}
	
	/// Notification handler for when text editing began.
	internal func handleTextViewTextDidBegin() {
		titleLabel?.textColor = titleLabelActiveColor
	}
	
	/// Notification handler for when text changed.
	internal func handleTextViewTextDidChange() {
		if let p = placeholderLabel {
			p.isHidden = !(true == text?.isEmpty)
		}
		
		if 0 < text?.utf16.count {
			showTitleLabel()
		} else if 0 == text?.utf16.count {
			hideTitleLabel()
		}
	}
	
	/// Notification handler for when text editing ended.
	internal func handleTextViewTextDidEnd() {
		if 0 < text?.utf16.count {
			showTitleLabel()
		} else if 0 == text?.utf16.count {
			hideTitleLabel()
		}
		titleLabel?.textColor = titleLabelColor
	}
	
	/// Sets the shadow path.
	internal func layoutShadowPath() {
		if shadowPathAutoSizeEnabled {
			if .none == depth {
				shadowPath = nil
			} else if nil == shadowPath {
				shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
			} else {
				animate(MaterialAnimation.shadowPath(UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath, duration: 0))
			}
		}
	}
	
	/**
	Prepares the view instance when intialized. When subclassing,
	it is recommended to override the prepareView method
	to initialize property values and other setup operations.
	The super.prepareView method should always be called immediately
	when subclassing.
	*/
	open func prepareView() {
		contentScaleFactor = MaterialDevice.scale
		textContainerInset = MaterialEdgeInsetToValue(.none)
		backgroundColor = MaterialColor.white
		masksToBounds = false
		removeNotificationHandlers()
		prepareNotificationHandlers()
		reloadView()
	}
	
	/// prepares the placeholderLabel property.
	fileprivate func preparePlaceholderLabel() {
		if let v: UILabel = placeholderLabel {
			v.font = font
			v.textAlignment = textAlignment
			v.numberOfLines = 0
			v.backgroundColor = MaterialColor.clear
			addSubview(v)
			reloadView()
			handleTextViewTextDidChange()
		}
	}
	
	/// Prepares the titleLabel property.
	fileprivate func prepareTitleLabel() {
		if let v: UILabel = titleLabel {
			v.isHidden = true
			addSubview(v)
			if 0 < text?.utf16.count {
				showTitleLabel()
			} else {
				v.alpha = 0
			}
		}
	}
	
	/// Shows and animates the titleLabel property.
	fileprivate func showTitleLabel() {
		if let v: UILabel = titleLabel {
			if v.isHidden {
				if let s: String = placeholderLabel?.text {
                    v.text = s
				}
				let h: CGFloat = ceil(v.font.lineHeight)
				v.frame = CGRect(x: 0, y: -h, width: bounds.width, height: h)
				v.isHidden = false
				UIView.animate(withDuration: 0.25, animations: { [weak self] in
					if let s: TextView = self {
						v.alpha = 1
						v.frame.origin.y = -v.frame.height - s.titleLabelAnimationDistance
					}
				})
			}
		}
	}
	
	/// Hides and animates the titleLabel property.
	fileprivate func hideTitleLabel() {
		if let v: UILabel = titleLabel {
			if !v.isHidden {
				UIView.animate(withDuration: 0.25, animations: {
					v.alpha = 0
					v.frame.origin.y = -v.frame.height
				}, completion: { _ in
					v.isHidden = true
				}) 
			}
		}
	}
	
	/// Prepares the Notification handlers.
	fileprivate func prepareNotificationHandlers() {
		NotificationCenter.default.addObserver(self, selector: #selector(handleTextViewTextDidBegin), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleTextViewTextDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleTextViewTextDidEnd), name: NSNotification.Name.UITextViewTextDidEndEditing, object: nil)
	}
	
	/// Removes the Notification handlers.
	fileprivate func removeNotificationHandlers() {
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidBeginEditing, object: nil)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: nil)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidEndEditing, object: nil)
	}
}
