import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "Всё получится!"
        titleLabel.textColor = .systemGray
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    var percentLabel: UILabel = {
        let percentLabel = UILabel()
        
        percentLabel.text = "0%"
        percentLabel.textColor = .systemGray
        percentLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        return percentLabel
    }()
    
    var progressBarView: UIProgressView = {
        let progressBarView = UIProgressView()
        
        progressBarView.progress = 0.5
        progressBarView.progressTintColor = .customPurple
        progressBarView.layer.cornerRadius = 3.5
        progressBarView.clipsToBounds = true
        
        progressBarView.translatesAutoresizingMaskIntoConstraints = false
        return progressBarView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 6
        clipsToBounds = true

        contentView.addSubview(titleLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressBarView)
        
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            percentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),

            progressBarView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19),
            progressBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressBarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBarView.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
    
    func setupProgress(_ percent: Float) {
        
        progressBarView.setProgress(percent, animated: true)
        titleLabel.text = (percent == nil) ? "Добавьте первую привычку" : "\(Int(percent * 100))%"
        percentLabel.text = (percent == 1) ? "На сегодня всё!": "Всё получится!"
    }
}
