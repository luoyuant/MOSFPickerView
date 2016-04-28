//
//  MOFSDatePickerView.swift
//  MOFSDatePickerView
//
//  Created by luoyuan on 16/4/18.
//  Copyright © 2016年 luoyuan. All rights reserved.
//

import UIKit

let UISCREEN_WIDTH = UIScreen.mainScreen().bounds.width;
let UISCREEN_HEIGHT = UIScreen.mainScreen().bounds.height;

protocol MOFSDatePickerViewDelegate {
    func mofsDelegate_selectedDate(date:String);
    func mofsDelegate_datePickerViewCancelSelected();
}

class MOFSDatePickerView: UIDatePicker {
    
    var mofsDelegate:MOFSDatePickerViewDelegate!;

    var toolBar = UIToolbar();
    var containerView = UIView(); //背景View
    var commitBar:UIBarButtonItem!; //确定UIBarButtonItem
    var cancelBar:UIBarButtonItem!; //取消UIBarButtonItem
    var dateFormatter:NSDateFormatter! = NSDateFormatter();
    
    /*
     *pickerView高度
     *默认216；
     */
    var height:CGFloat! {
        didSet {
            self.frame = CGRectMake(0, UISCREEN_HEIGHT - height, UISCREEN_WIDTH, height);
            toolBar.frame = CGRectMake(0, UISCREEN_HEIGHT - height - 44, UISCREEN_WIDTH, 44);
            containerView.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT - height - 44);
        }
    }
    
    /*
     *cancelBar的title
     *默认为“取消”
     */
    var cancelBarTitle:String! {
        didSet {
            cancelBar.title = cancelBarTitle;
        }
    }
    
    /*
     *cancelBar的文字颜色
     *默认UIColor(hexString: "0079fe")
     */
    var cancelBarColor:UIColor! {
        didSet {
            cancelBar.tintColor = cancelBarColor;
        }
    }
    
    /*
     *commitBar的title
     *默认为“确定”
     */
    var commitBarTitle:String! {
        didSet {
            commitBar.title = commitBarTitle;
        }
    }
    
    /*
     *commitBar的文字颜色
     *默认UIColor(hexString: "0079fe")
     */
    var commitBarColor:UIColor! {
        didSet {
            commitBar.tintColor = commitBarColor;
        }
    }
    
    /*
     *日期格式
     *默认yyyy-MM-dd
     */
    var dateFormat:String! = "yyyy-MM-dd" {
        didSet {
            dateFormatter.dateFormat = dateFormat;
        }
    }

    /*
     *最小日期
     *默认无
     */
    var minDate:NSDate! {
        didSet {
            self.minimumDate = minDate;
        }
    }
    
    /*
     *最大日期
     *默认无
     */
    var maxDate:NSDate! {
        didSet {
            self.maximumDate = maxDate;
        }
    }
    
    /*
     *一开始显示的日期
     *默认当天
     */
    var currentDate:NSDate! {
        didSet {
            self.date = currentDate;
        }
    }
    
    //MARK: - self.init
    override init(frame: CGRect) {
        var initialFrame:CGRect!;
        
        if (CGRectIsEmpty(frame)) {
            initialFrame = CGRectMake(0, UISCREEN_HEIGHT - 216, UISCREEN_WIDTH, 216);
        } else {
            initialFrame = frame;
        }
        initialFrame = CGRectMake(0, UISCREEN_HEIGHT - initialFrame.height, UISCREEN_WIDTH, initialFrame.height);
        super.init(frame: initialFrame);
        self.backgroundColor = UIColor(hexString: "#F6F6F6");
        self.datePickerMode = UIDatePickerMode.Date;
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        
        self.initToolBar();
        self.initContainerView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - showDatePickerView;
    func show() {
        let window = UIApplication.sharedApplication().keyWindow;
        window?.addSubview(self);
        window?.addSubview(toolBar);
        window?.addSubview(containerView);
    }
    
    //MARK: - initToolBar
    func initToolBar() {
        toolBar.frame = CGRectMake(0, UISCREEN_HEIGHT - self.frame.height - 44, UISCREEN_WIDTH, 44);
        
        commitBar = UIBarButtonItem(title: "    完成    ", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MOFSDatePickerView.commitAction));
        commitBar.tintColor = UIColor(hexString: "0079fe");
        
        cancelBar = UIBarButtonItem(title: "    取消    ", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MOFSDatePickerView.cancelAction));
        cancelBar.tintColor = UIColor(hexString: "0079fe");
        
        let nullBar = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil);
        
        toolBar.items = [cancelBar,nullBar,commitBar];
        toolBar.backgroundColor = self.backgroundColor;
        
        let lineView = UIView(frame: CGRectMake(0, 43.5, UISCREEN_WIDTH, 0.5));
        lineView.backgroundColor = UIColor(hexString: "#D3D3D3");
        
        toolBar.addSubview(lineView);
        toolBar.bringSubviewToFront(lineView);
    }
    
    //MARK: - initContainerView
    func initContainerView() {
        containerView.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT - self.frame.height - 44)
        containerView.backgroundColor = UIColor.blackColor();
        containerView.alpha = 0.4;
        containerView.userInteractionEnabled = true;
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MOFSDatePickerView.cancelAction)));
    }
    
    //MARK: - commitAction
    func commitAction() {
        toolBar.removeFromSuperview();
        containerView.removeFromSuperview();
        self.removeFromSuperview();
        if (mofsDelegate != nil) {
            mofsDelegate.mofsDelegate_selectedDate(handlerTime(self.date));
        }
    }
    
    //MARK: - cancelAction
    func cancelAction() {
        toolBar.removeFromSuperview();
        containerView.removeFromSuperview();
        self.removeFromSuperview();
        if (mofsDelegate != nil) {
            mofsDelegate.mofsDelegate_datePickerViewCancelSelected();
        }
    }
    
    //MARK: - handlerTime
    func handlerTime(date:NSDate) -> String{
        dateFormatter.dateFormat = dateFormat;
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN");
        return dateFormatter.stringFromDate(date)
    }
    
}
