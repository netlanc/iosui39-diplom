import UIKit

class InfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var borderView: UIView = {

        let border = UIView()
        
        border.backgroundColor = .systemGray2
        border.translatesAutoresizingMaskIntoConstraints = false
        
        return border
    }()
    
    private lazy var borderBottomView: UIView = {

        let border = UIView()
        
        border.backgroundColor = .systemGray2
        border.translatesAutoresizingMaskIntoConstraints = false
        
        return border
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "Привычка за 21 день"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isScrollEnabled = false
        textView.isEditable = false

        textView.text = """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
"""
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9686273932, green: 0.9686273932, blue: 0.9686273932, alpha: 1)
        self.title = "Инфформация"
        
        view.addSubview(borderView)
        view.addSubview(scrollView)
        view.addSubview(borderBottomView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel);
        contentView.addSubview(textView)
        
        setupConstraints()
    }
    
    // MARK: - Methods

    func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            borderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: borderView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: borderBottomView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            borderBottomView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            borderBottomView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            borderBottomView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            borderBottomView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
        
    }

}

