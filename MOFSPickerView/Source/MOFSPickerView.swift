//
//  MOFSPickerView.swift
//  MOFSPickerView
//
//  Created by luoyuan on 16/4/18.
//  Copyright © 2016年 luoyuan. All rights reserved.
//

import UIKit

//let UISCREEN_WIDTH = UIScreen.mainScreen().bounds.width;
//let UISCREEN_HEIGHT = UIScreen.mainScreen().bounds.height;

protocol MOFSPickerViewDelegate {
    func mofsDelegate_selectedString(string:String);
    func mofsDelegate_pickerViewCancelSelected();
}


class MOFSPickerView: UIPickerView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var mofsDelegate:MOFSPickerViewDelegate!;

    var toolBar = UIToolbar();
    var containerView = UIView(); //背景View
    var commitBar:UIBarButtonItem!; //确定UIBarButtonItem
    var cancelBar:UIBarButtonItem!; //取消UIBarButtonItem
    
    var datas:Array<String> = Array();
    
    var selectedIndex:Int = 0;
    
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
        self.delegate = self;
        self.dataSource = self;
       
        self.initToolBar();
        self.initContainerView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - pickerViewShow
    func showWithArray(array:Array<String>) {
        self.datas = array;
        self.selectedIndex = 0;
        self.reloadAllComponents();
        self.selectRow(0, inComponent: 0, animated: false);
        let window = UIApplication.sharedApplication().keyWindow;
        window?.addSubview(containerView);
        window?.addSubview(self);
        window?.addSubview(toolBar);
    }
    
    //MARK: - initToolBar
    func initToolBar() {
        toolBar.frame = CGRectMake(0, UISCREEN_HEIGHT - self.frame.height - 44, UISCREEN_WIDTH, 44);
        
        commitBar = UIBarButtonItem(title: "    完成    ", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MOFSPickerView.commitAction));
        commitBar.tintColor = UIColor(hexString: "0079fe");
        
        cancelBar = UIBarButtonItem(title: "    取消    ", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MOFSPickerView.cancelAction));
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
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MOFSPickerView.cancelAction)));
    }

    //MARK: - commitAction
    func commitAction() {
        toolBar.removeFromSuperview();
        containerView.removeFromSuperview();
        self.removeFromSuperview();
        if (mofsDelegate != nil) {
            mofsDelegate.mofsDelegate_selectedString(datas[selectedIndex]);
        }
    }
    
    //MARK: - cancelAction
    func cancelAction() {
        toolBar.removeFromSuperview();
        containerView.removeFromSuperview();
        self.removeFromSuperview();
        if (mofsDelegate != nil) {
            mofsDelegate.mofsDelegate_pickerViewCancelSelected();
        }
    }

    
    //MARK: - UIPickerViewDelegate,UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datas.count;
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datas[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row;
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
