//
//  LoadingView.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol LoadingViewProtocol {
    func addLoadingView(onView: UIView)
    func removeLoadingView()
}

final class LoadingView: UIView {
    private enum Constants {
        static let backgroundBlackColor = UIColor.black.withAlphaComponent(0.4)
        static let sqaureColor =  UIColor(red: 68 / 255, green: 68 / 255, blue: 68 / 255, alpha: 0.7)
        static let sqaureSize: CGFloat = 80
        static let cornerRadius: CGFloat = 10
    }

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = CGPoint(x: squareView.frame.size.width / 2, y: squareView.frame.size.height / 2);
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()

    private lazy var squareView: UIView = {
        let vista = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: Constants.sqaureSize,
                                         height: Constants.sqaureSize))
        vista.backgroundColor = Constants.sqaureColor
        vista.clipsToBounds = true
        vista.layer.cornerRadius = Constants.cornerRadius
        return vista

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: LoadingViewProtocol implementation
extension LoadingView: LoadingViewProtocol {
    func addLoadingView(onView: UIView) {
        frame = onView.frame
        center = onView.center
        squareView.center = center
        onView.addSubview(self)
    }

    func removeLoadingView() {
        removeFromSuperview()
    }
}

// MARK: Private Methods
private extension LoadingView {
    func setupView() {
        backgroundColor = Constants.backgroundBlackColor
        squareView.addSubview(activityIndicatorView)
        addSubview(squareView)
    }
}
