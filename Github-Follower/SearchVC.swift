//
//  SearchVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 18.02.2025.
//

import UIKit  

class SearchVC: GFDataLoadingVC {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(color: .systemGreen, title: "Get Followers", systemImageName: "person.3.fill")

    
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubsviews(views: logoImageView , usernameTextField , callToActionButton )
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismisKeyboardTapGesture()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismisKeyboardTapGesture() {
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        
        guard isUsernameEntered  else { 
            
            presentGFAlertOnMainThread(title: "Epmpty Username", message: "Please enter a username. We need to know who to look for  🙂", buttonTitle: "OK")
            return
            
            }
        
        usernameTextField.resignFirstResponder()
        
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
        
    }
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant : CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 80) ,
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView .widthAnchor.constraint(equalToConstant: 200)
        
        ])
    }
    
    func  configureTextField() {
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
