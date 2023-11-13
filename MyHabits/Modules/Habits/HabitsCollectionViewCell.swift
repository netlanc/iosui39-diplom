import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    weak var progressBarUpdateDelegete: ProgressBarUpdateDelegate?
    
    private var currentHabit = Habit(name: "", date: Date(), color: UIColor())
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let noteTimeLabel: UILabel = {
        let noteTimeLabel = UILabel()
        
        noteTimeLabel.textColor = .systemGray2
        noteTimeLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        noteTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return noteTimeLabel
    }()
    
    private let countLabel: UILabel = {
        let countLabel = UILabel()
        
        countLabel.text = "Cчетчик "
        countLabel.textColor = .systemGray2
        countLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        return countLabel
    }()
    
    private lazy var checkButton: UIButton = {
        let checkButton = UIButton()
        
        checkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        return checkButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCeil()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCeil() {
        
        backgroundColor = .white
        layer.cornerRadius = 6
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(noteTimeLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(checkButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),

            noteTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            noteTimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),

            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkButton.heightAnchor.constraint(equalToConstant: 38),
            checkButton.widthAnchor.constraint(equalToConstant: 38)
        ])
        
    }
    
    private func setImageCheckButton(_ imageName: String) {
        checkButton.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func setupHabit(_ habit: Habit) {
        
        currentHabit = habit
        
        titleLabel.text = currentHabit.name
        titleLabel.textColor = currentHabit.color
        
        noteTimeLabel.text = currentHabit.dateString
        
        countLabel.text? += String(currentHabit.trackDates.count)
        
        checkButton.tintColor = currentHabit.color
        
        if currentHabit.isAlreadyTakenToday {
            setImageCheckButton("checkmark.circle.fill")
        }
    }
    
    @objc private func checkHabit() {
        
        if !currentHabit.isAlreadyTakenToday {
            
            HabitsStore.shared.track(currentHabit)
            HabitsStore.shared.save()
            
            setImageCheckButton("checkmark.circle.fill")
            countLabel.text = "Счётчик: \(currentHabit.trackDates.count)"
            
            self.progressBarUpdateDelegete?.reloadProgressBar()
        }
        
    }
}
