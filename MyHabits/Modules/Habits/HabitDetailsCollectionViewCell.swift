import UIKit

class HabitDetailsCollectionViewCell: UITableViewCell {    
    
    private let formatter = DateFormatter()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        
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
        
        let today = Calendar.current.startOfDay(for: Date())
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today) ?? Date()
        let dayBeforeYesterday = Calendar.current.date(byAdding: .day, value: -1, to: yesterday) ?? Date()
        
        let habitDate = dateHabit[indexCell]

        if Calendar.current.isDateInToday(habitDate) {
            textLabel?.text = "Сегодня"
        } else if Calendar.current.isDateInYesterday(habitDate) {
            textLabel?.text = "Вчера"
        } else if Calendar.current.isDate(dayBeforeYesterday, inSameDayAs: habitDate) {
            textLabel?.text = "Позавчера"
        } else {
            textLabel?.text = formatter.string(from: habitDate)
        }
        
    }
    
}
