import UIKit

class HabitsViewController: UIViewController {
    
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
    
    // todo: временно, не забыть удалить
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "Болванка"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customGrayLite
        self.title = "Привычки"
        
        
        view.addSubview(borderView)
        view.addSubview(scrollView)
        view.addSubview(borderBottomView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel);
        
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

