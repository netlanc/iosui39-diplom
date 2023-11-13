import UIKit

class HabitDetailsCollectionViewCell: UITableViewCell {    
    
    private let formatter = DateFormatter()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        tintColor = .customPurple
        
        formatter.dateFormat = "dd MMMM YYYY"
        formatter.locale = .init(identifier: "ru_RU")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ indexCell: Int, _ indexHabit: Int) {
        
        let dateHabit: [Date] = HabitsStore.shared.dates.reversed()
        
        accessoryType = HabitsStore.shared.habit(
            HabitsStore.shared.habits[indexHabit],
            isTrackedIn: dateHabit[indexCell]
        ) ? .checkmark : .none

        switch indexCell {
            case 0: textLabel?.text = "Сегодня"
            case 1: textLabel?.text = "Вчера"
            case 2: textLabel?.text = "Позавчера"
            default: textLabel?.text = formatter.string(from: dateHabit[indexCell])
        }
        
    }
    
}
