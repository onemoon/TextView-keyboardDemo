//
//  ViewController.swift
//  TextView&keyboardDemo
//
//  Created by Jimmy.Liu on 16/3/15.
//  Copyright © 2016年 lpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var textView: UITextView!
    @IBAction func likeButton(sender: AnyObject) {
        print("🐶🐱")
    }
    @IBOutlet var textViewInput: UITextView!
    @IBAction func sendMessage(sender: AnyObject) {
        //显示输入内容
        textView.text! += textViewInput.text!
        //发送后输入框里的内容消失
        textViewInput.text = ""
        //发送后键盘隐藏
        textViewInput.resignFirstResponder()
        print(textViewInput.frame)

    }
    @IBAction func clearButton(sender: AnyObject) {
        textView.text = ""
    }
    @IBOutlet weak var toolbarView: UIView!
    
    var heightText: Double?
    //字体名称和大小
    let dict = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 20)!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //设置圆角
        textView.layer.cornerRadius = 6
        textViewInput.layer.cornerRadius = 6
        //边框宽度和颜色
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.grayColor().CGColor
        //自定义选择后的菜单
        let mail = UIMenuItem(title: "邮件", action: "onMail")
        let weixin = UIMenuItem(title: "微信", action: "onWeiXin")
        let menu = UIMenuController()
        //将item添加到menu里
        menu.menuItems = [mail, weixin]
        //给文字中的电话号码和网址\地址\日历自动加链接
        //textView.dataDetectorTypes = UIDataDetectorTypes.None //都不加链接
        //textView.dataDetectorTypes = UIDataDetectorTypes.Address //只有地址加链接
        //textView.dataDetectorTypes = UIDataDetectorTypes.CalendarEvent //只有日历事件加链接
        //textView.dataDetectorTypes = UIDataDetectorTypes.Link //只有网站加链接
        //textView.dataDetectorTypes = UIDataDetectorTypes.PhoneNumber // 只有电话号码加链接
        //textView.dataDetectorTypes = UIDataDetectorTypes.All //全部都加链接
        
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillChange:",
            name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        //动态改变textViewInput的高度, 但是view的高度没有改变
        textViewInput.scrollEnabled = false
        let fixedWidth = CGFloat(263)
        let newSize = textViewInput.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = textViewInput.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textViewInput.frame = newFrame
    }
    
    func onMail() {
        print("发邮件")
    }
    
    func onWeiXin() {
        print("分享到微信")
    }
    
    func keyboardWillChange(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
                
                let frame = value.CGRectValue()
                let intersection = CGRectIntersection(frame, self.view.frame)
                
                //改变下约束
                self.bottomConstraint.constant = CGRectGetHeight(intersection)
                
                UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: curve), animations: { _ in
                    
                    self.view.layoutIfNeeded()
                    
                    }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

