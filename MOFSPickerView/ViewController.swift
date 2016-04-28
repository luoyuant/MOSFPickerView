//
//  ViewController.swift
//  MOFSPickerView
//
//  Created by luoyuan on 16/4/28.
//  Copyright © 2016年 luoyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MOFSPickerViewDelegate,MOFSDatePickerViewDelegate {

    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var jobLb: UILabel!
    @IBOutlet weak var typeLb: UILabel!
    
    var jodArr = ["搬砖工","卖切糕贩子","城管","包工头"];
    
    var typeArr = ["瘦小","一般","强壮"];
    
    var isSelectedJod = false;
    
    var isSelectedType = false;
    
    var datePickerView:MOFSDatePickerView!;
    
    var pickerView:MOFSPickerView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerView = MOFSDatePickerView();
        datePickerView.mofsDelegate = self;
        pickerView = MOFSPickerView();
        pickerView.mofsDelegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dateSelectAction(sender: UITapGestureRecognizer) {
        switch (sender.view?.tag)! {
        case 1001:
            datePickerView.show();
        case 1002:
            isSelectedJod = true;
            pickerView.showWithArray(jodArr);
        case 1003:
            isSelectedType = true;
            pickerView.showWithArray(typeArr);
        default:
            break;
        }
    }

    func setFlagFalse() {
        isSelectedType = false;
        isSelectedJod = false;
    }
    
    //MARK: - MOFSPickerViewDelegate
    func mofsDelegate_pickerViewCancelSelected() {
        setFlagFalse();
    }
    
    func mofsDelegate_selectedString(string: String) {
        if (isSelectedJod) {
            jobLb.text = string;
        }
        if (isSelectedType) {
            typeLb.text = string;
        }
        setFlagFalse();
    }
    
    //MARK: - MOFSDatePickerViewDelegate
    func mofsDelegate_selectedDate(date: String) {
        dateLb.text = date;
    }
    
    func mofsDelegate_datePickerViewCancelSelected() {
        
    }
    
    
}

