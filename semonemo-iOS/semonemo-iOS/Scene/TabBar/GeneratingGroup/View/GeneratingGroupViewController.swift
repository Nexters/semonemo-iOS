import SnapKit
import Then
import UIKit

final class GeneratingGroupViewController: UIViewController {
    // MARK: - PickerType
    enum Picker: Int {
        case date
        case time
        
        var componentCount: Int {
            switch self {
            case .date:
                return 3
            case .time:
                return 6
            }
        }
    }
    
    // MARK: - Properties
    private let container = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 30
    }
    
    private let dateContainer = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    private let dateTitleLabel = UILabel().then {
        $0.text = "날짜 *"
        $0.font = UIFont.pretendardWithDefaultSize(family: .semiBold)
        
        let titleText = $0.text as? NSString
        let range = titleText?.range(of: "*")
        let attributes = NSMutableAttributedString(string: $0.text ?? "")
        attributes.addAttributes(
            [
                NSAttributedString.Key.font: UIFont.pretendard(family: .regular, size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.customBlue
            ],
            range: range ?? NSRange()
        )
        $0.attributedText = attributes
    }
    private let dateTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "모임날짜",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray5,
                NSAttributedString.Key.font: UIFont.pretendardWithDefaultSize(family: .regular)
            ]
        )
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray5.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.addLeftPadding()
        $0.clearButtonMode = .always
    }
    private let datePicker = UIDatePicker()
    private let timeTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "모임 시작 시간 - 모임 종료 시간",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray5,
                NSAttributedString.Key.font: UIFont.pretendardWithDefaultSize(family: .regular)
            ]
        )
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray5.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.addLeftPadding()
        $0.clearButtonMode = .always
    }
    private let ampmList: [String] = ["오전", "오후"]
    private let hourList: [String] = [
        "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"
    ]
    private let minuteList: [String] = ["00", "15", "30", "45"]
    private var selectedStartAMPM = ""
    private var selectedStartHour = ""
    private var selectedStartMinute = ""
    private var selectedEndAMPM = ""
    private var selectedEndHour = ""
    private var selectedEndMinute = ""
    
    private let locationContainer = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    private let locationTitleLabel = UILabel().then {
        $0.text = "장소 *"
        $0.font = UIFont.pretendardWithDefaultSize(family: .semiBold)
        
        let titleText = $0.text as? NSString
        let range = titleText?.range(of: "*")
        let attributes = NSMutableAttributedString(string: $0.text ?? "")
        attributes.addAttributes(
            [
                NSAttributedString.Key.font: UIFont.pretendard(family: .regular, size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.customBlue
            ],
            range: range ?? NSRange()
        )
        $0.attributedText = attributes
    }
    private let locationNameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "장소 이름",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray5,
                NSAttributedString.Key.font: UIFont.pretendardWithDefaultSize(family: .regular)
            ]
        )
        $0.font = UIFont.pretendardWithDefaultSize(family: .regular)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray5.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.addLeftPadding()
        $0.clearButtonMode = .always
        $0.returnKeyType = .done
    }
    private let locationDetailTextFiled = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "상세주소",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray5,
                NSAttributedString.Key.font: UIFont.pretendardWithDefaultSize(family: .regular)
            ]
        )
        $0.font = UIFont.pretendardWithDefaultSize(family: .regular)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray5.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.addLeftPadding()
        $0.clearButtonMode = .always
        $0.returnKeyType = .done
    }
    
    private let locationLinkContainer = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    private let locationLinkTitleLabel = UILabel().then {
        $0.text = "장소 링크"
        $0.font = UIFont.pretendardWithDefaultSize(family: .semiBold)
    }
    private let locationLinkTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "장소 이름",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray5,
                NSAttributedString.Key.font: UIFont.pretendardWithDefaultSize(family: .regular)
            ]
        )
        $0.font = UIFont.pretendardWithDefaultSize(family: .regular)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray5.cgColor
        $0.layer.cornerRadius = 5
        $0.addLeftPadding()
        $0.clearButtonMode = .always
        $0.returnKeyType = .done
        $0.clipsToBounds = true
    }
    
    private let generatingGroupButton = UIButton().then {
        $0.backgroundColor = UIColor.customBlue
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.setTitle("모임 만들기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendardWithDefaultSize(family: .medium)
    }
    
    // MARK: - Initializers
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        configureTabBar()
        configureDatePicker()
        configureTimePicker()
        configureTextField()
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        render()
    }
    
    // MARK: - Methods
    private func configureTabBar() {
        self.tabBarItem.image = UIImage(named: "icon_add")
        self.tabBarItem.selectedImage = UIImage(named: "icon_add_selected")
    }
    
    private func configureDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil
        )
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel, target: nil, action: #selector(cancelButtonTapped)
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTapped)
        )
        
        toolbar.setItems([flexibleSpace, cancelButton, doneButton], animated: true)
        
        datePicker.tag = 0
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    private func configureTimePicker() {
        let timePicker = UIPickerView()
        timePicker.tag = 1
        timePicker.delegate = self
        timePicker.dataSource = self
        timeTextField.tintColor = .clear
        timeTextField.inputView = timePicker
    }
    
    private func configureTextField() {
        locationNameTextField.delegate = self
        locationDetailTextFiled.delegate = self
        locationLinkTextField.delegate = self
    }
    
    @objc
    private func doneButtonTapped() {
        // TODO: dateFormatter 분리
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        dateTextField.attributedText = NSAttributedString(
            string: dateFormatter.string(from: datePicker.date),
            attributes: [
                NSAttributedString.Key.font: UIFont.pretendardWithDefaultSize(family: .regular)
            ]
        )
        view.endEditing(true)
    }
    
    @objc
    private func cancelButtonTapped() {
        view.endEditing(true)
    }
    
    private func render() {
        view.addSubview(container)
        view.addSubview(generatingGroupButton)
        container.addArrangedSubview(dateContainer)
        container.addArrangedSubview(locationContainer)
        container.addArrangedSubview(locationLinkContainer)
        
        dateContainer.addArrangedSubview(dateTitleLabel)
        dateContainer.addArrangedSubview(dateTextField)
        dateContainer.addArrangedSubview(timeTextField)
        locationContainer.addArrangedSubview(locationTitleLabel)
        locationContainer.addArrangedSubview(locationNameTextField)
        locationContainer.addArrangedSubview(locationDetailTextFiled)
        locationLinkContainer.addArrangedSubview(locationLinkTitleLabel)
        locationLinkContainer.addArrangedSubview(locationLinkTextField)
        
        container.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            
        }
        
        dateTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        timeTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        locationNameTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        locationDetailTextFiled.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        locationLinkTextField.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        generatingGroupButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(48)
        }
    }
}

extension GeneratingGroupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let componentCount = Picker(rawValue: pickerView.tag)?.componentCount else {
            return 0
        }
        
        return componentCount
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0, 3:
            return ampmList.count
        case 1, 4:
            return hourList.count
        case 2, 5:
            return minuteList.count
        default:
            return 0
        }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        switch component {
        case 0, 3:
            return "\(ampmList[row])"
        case 1, 4:
            return "\(hourList[row]) : "
        case 2, 5:
            return "\(minuteList[row])"
        default:
            return ""
        }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        switch component {
        case 0:
            selectedStartAMPM = ampmList[row]
        case 1:
            selectedStartHour = hourList[row]
        case 2:
            selectedStartMinute = minuteList[row]
        case 3:
            selectedEndAMPM = ampmList[row]
        case 4:
            selectedEndHour = hourList[row]
        case 5:
            selectedEndMinute = minuteList[row]
        default:
            break
        }
    }
}

extension GeneratingGroupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.attributedText = NSAttributedString(
            string: textField.text ?? "",
            attributes: [
                NSAttributedString.Key.font: UIFont.pretendardWithDefaultSize(family: .regular)
            ]
        )
        return true
    }
}
