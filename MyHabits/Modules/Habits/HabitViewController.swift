import UIKit

class HabitViewController: UIViewController {
    
    weak var habitsDelegate: HabitsDelegate?
    weak var habitDetailsDelegate: HabitDetailsDelegate?
    
    private var index: Int?
    private var titleHabit: String?
    private var colorHabit: UIColor
    private var date: Date?
    private var defaultColor = UIColor.orange
    private var currentHabit: Habit?
    
    private lazy var borderView: UIView = {
        
        let border = UIView()
        
        border.backgroundColor = .systemGray2
        border.translatesAutoresizingMaskIntoConstraints = false
        
        return border
    }()
    
    private lazy var contentView: UIView = {
        
        let border = UIView()
        
        border.backgroundColor = .white
        border.translatesAutoresizingMaskIntoConstraints = false
        
        return border
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "НАЗВАНИЕ"
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var titleTextField: UITextField = {
        let titleTextField = UITextField()
        
        titleTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        titleTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        return titleTextField
    }()
    
    private lazy var colorLabel: UILabel = {
        let colorLabel = UILabel()
        
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        return colorLabel
    }()
    
    private lazy var colorButton: UIButton = {
        let colorButton = UIButton()
        
        colorButton.backgroundColor = defaultColor
        colorButton.layer.cornerRadius = 15
        colorButton.clipsToBounds = true
        colorButton.addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
        
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        return colorButton
    }()
    
    private lazy var colorPicker: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = .orange
        colorPicker.delegate = self
        return colorPicker
    }()
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    private let noteTimeLabel: UILabel = {
        let noteTimeLabel = UILabel()
        
        noteTimeLabel.text = "Каждый день в"
        noteTimeLabel.font = .systemFont(ofSize: 17, weight: .regular)
        
        noteTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return noteTimeLabel
    }()
    
    private var selectTimeLabel: UILabel = {
        let selectTimeLabel = UILabel()
        
        selectTimeLabel.font = .systemFont(ofSize: 17, weight: .regular)
        selectTimeLabel.textColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        
        selectTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return selectTimeLabel
    }()
    
    private lazy var timePickerView: UIDatePicker = {
        let timePickerView = UIDatePicker()
        
        timePickerView.preferredDatePickerStyle = .wheels
        timePickerView.datePickerMode = .time
        timePickerView.date = date ?? Date()
        timePickerView.addTarget(self, action: #selector(setTimeHabit), for: .valueChanged)
        
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        return timePickerView
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.isHidden = true
        deleteButton.addTarget(self, action: #selector(openAlertDeleteHabit), for: .touchUpInside)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()
    
    private lazy var messageDeleteAlertController = UIAlertController(
        title: "Удалить привычку",
        message: "Вы хотите удалить привычку_title_habbit_?",
        preferredStyle: .alert
    )
    
    private func messageDeleteAlertButtons() {
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) {_ in
            self.deleteHabit(self.index!)
        }
        messageDeleteAlertController.addAction(cancelAction)
        messageDeleteAlertController.addAction(deleteAction)
    }
    
    private lazy var messageSaveAlertController = UIAlertController(
        title: "Ошибка",
        message: "Заполните название привычки",
        preferredStyle: .alert
    )
    
    private func messageSaveAlertButtons() {
        let okAction = UIAlertAction(title: "Ok", style: .default)
        messageSaveAlertController.addAction(okAction)
    }
    
    init(habit: Habit?, index: Int?) {
        
        self.index = index
        self.titleHabit = habit?.name
        self.colorHabit = habit?.color ?? self.defaultColor
        self.date = habit?.date
        
        if index != nil {
            self.currentHabit = habit!
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageDeleteAlertButtons()
        messageSaveAlertButtons()
        
        setTimeHabit() 
        
        setupFields()
        setupFormHabit()
        setupNavigation()
        setupConstraints()
    }
    
    private func setupFields() {
        deleteButton.isHidden = index == nil ? true: false
        titleTextField.text = titleHabit
        colorButton.backgroundColor = colorHabit
    }
    
    private func setupFormHabit() {
        
        view.backgroundColor = #colorLiteral(red: 0.9686273932, green: 0.9686273932, blue: 0.9686273932, alpha: 1)
        
        view.addSubview(borderView)
        view.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorButton)
        contentView.addSubview(timeLabel)
        contentView.addSubview(noteTimeLabel)
        contentView.addSubview(selectTimeLabel)
        contentView.addSubview(deleteButton)
        contentView.addSubview(timePickerView)
        
    }
    
    private func setupNavigation() {
        
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(closeHabit))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveHabit))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            borderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            titleTextField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 46),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
//            titleTextField.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            colorLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 83),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
//            colorLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            colorButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 108),
            colorButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
//            colorButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 153),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
//            timeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            noteTimeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 178),
            noteTimeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
//            noteTimeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            selectTimeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 178),
            selectTimeLabel.leadingAnchor.constraint(equalTo: noteTimeLabel.trailingAnchor, constant: 5),
//            noteTimeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            timePickerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            timePickerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            timePickerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 215),
//            timePickerView.heightAnchor.constraint(equalToConstant: 216),
            timePickerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -36),
            
//            deleteButton.topAnchor.constraint(greaterThanOrEqualTo: pickerView.bottomAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: borderView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    
    @objc private func setTimeHabit() {
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "HH:mm a"
        selectTimeLabel.text = formatDate.string(from: timePickerView.date)
    }
    
    @objc private func openColorPicker() {
        present(colorPicker, animated: true)
    }
    
    @objc private func openAlertDeleteHabit() {
        if let textHabit = titleTextField.text {
            messageDeleteAlertController.message = messageDeleteAlertController.message?.replacingOccurrences(of: "_title_habbit_", with: (textHabit != "") ? "\n\"\(textHabit)\"": "")
        }
        self.present(messageDeleteAlertController, animated: true)
    }
    
    @objc private func deleteHabit(_ index: Int) {
        self.dismiss(animated: true)
        HabitsStore.shared.habits.remove(at: index)
        habitDetailsDelegate?.habitDetailDelete(at: index)
    }
    
    @objc private func saveHabit() {
        guard titleTextField.text != "" else {
            self.present(messageSaveAlertController, animated: true)
            return
        }
        
        let storeHabits = HabitsStore.shared
        
        self.dismiss(animated: true)
        
        if self.index == nil {
            
            let newHabit = Habit(
                name: titleTextField.text!,
                date: timePickerView.date,
                color: colorButton.backgroundColor!
            )
            
            storeHabits.habits.append(newHabit)
            
            habitsDelegate?.habitCreate()
            
        } else {
            
            currentHabit?.name = titleTextField.text!
            currentHabit?.date = timePickerView.date
            currentHabit?.color = colorButton.backgroundColor!
            
            storeHabits.habits[index!] = currentHabit!
            
            habitDetailsDelegate?.habitDetailUpdate(habit: currentHabit!, at: index!)
            
        }
    }
    
    @objc private func closeHabit() {
        self.dismiss(animated: true)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorButton.backgroundColor = color
        titleTextField.textColor = color
    }
}
