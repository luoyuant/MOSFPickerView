# MOSFPickerView
1.初始化

datePickerView = MOFSDatePickerView();

datePickerView.mofsDelegate = self;

pickerView = MOFSPickerView();

pickerView.mofsDelegate = self;

2.调用

show方法

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

3.协议

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
