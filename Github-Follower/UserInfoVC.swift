//
//  USerInfoVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 6.03.2025.
//

import UIKit

protocol UserInfoVCDelegate : AnyObject {
    func didRequestFollowers (for username: String)
    
}

class UserInfoVC: GFDataLoadingVC    {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username : String!
    weak var delegate: UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController () {
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pintoEdges(of: view)
        contentView.pintoEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
        
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func getUserInfo () {
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureUIElements(with: user)
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlertOnMainThread(title: "Something Went Wrong", message: gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
            }
        }
        
        
//        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let user ):
//                DispatchQueue.main.async { self.configureUIElements(with: user) }
//                
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(title: "Smothing went wrong", message: error.rawValue, buttonTitle: "OK")
//            }
//        }
    }
    func configureUIElements(with user : User) {

        
        self.add(childVC: GfRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text =  "Github since \(user.createdAt.convertToDisplayFormat())"
        
    }
    
    func layoutUI() {
        let padding : CGFloat        = 20
        let itemHeight : CGFloat     = 140
        
        itemViews = [headerView , itemViewOne , itemViewTwo , dateLabel]
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            
            NSLayoutConstraint.activate([
            
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -padding)
            
            ])
            
        }
        


        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 60)
        
        ])
        
    }
    
    func add(childVC : UIViewController , to containerView: UIView ) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismisVC() {
        
        dismiss(animated: true)
        
    }

}

extension UserInfoVC : GFRepoITemVCDelegate  {
    func didTapGithubProfile(for user: User) {
        
           guard let url = URL(string: user.htmlUrl) else {
               presentGFAlertOnMainThread(title: "İnvalid URL", message: "The url attached to this user is ivalid.", buttonTitle: "OK")
               return
           }
           presentSafariVC(with: url)
    }
    
    
}

extension UserInfoVC : GFFollowerItemVCDelegate  {
    func didTapGetFollowers(for user: User) {
        
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers. What A shame 😔." , buttonTitle: "So sad")
            return
        }
        
        delegate.didRequestFollowers(for:  user.login)
        dismisVC()
    }
    
}
