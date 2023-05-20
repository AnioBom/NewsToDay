//
//  ProfileViewController.swift
//  NewsToDay
//
//  Created by Артем Орлов on 07.05.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    private let profilelView = NewsToDay.ProfileView()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        profilelView.delegate = self
        addViews()
        addConstraints()
        profilelView.profileImageView.image = getProfileImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUserInfo()
    }
    
    // MARK: - Private Methods
    private func addViews() {
        view.backgroundColor = .white
        view.addSubview(profilelView)
    }
    
    private func addConstraints() {
        profilelView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func updateUserInfo() {
        guard let name = FirebaseManager.shared.getFromUserDefaultsUserInfo()?.name,
              let email = FirebaseManager.shared.getFromUserDefaultsUserInfo()?.email else { return }
        profilelView.nameLabel.text = name
        profilelView.emailLabel.text = email
    }
}

// MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    
    func ProfileView(_ view: ProfileView, languageButtonPressed button: UIButton) {
        let languageVC = LanguageViewController()
        languageVC.modalPresentationStyle = .fullScreen
        languageVC.modalTransitionStyle = .crossDissolve
        self.present(languageVC, animated: true)
    }
    
    func ProfileView(_ view: ProfileView, developerTeamButtonPressed button: UIButton) {
        let developerTeamVC = DeveloperTeamViewController()
        developerTeamVC.modalPresentationStyle = .fullScreen
        developerTeamVC.modalTransitionStyle = .crossDissolve
        self.present(developerTeamVC, animated: true)
    }
    
    func ProfileView(_ view: ProfileView, termsAndConditionsButtonPressed button: UIButton) {
        let termsAndConditionsVC = TermsAndConditionsViewController()
        termsAndConditionsVC.modalPresentationStyle = .fullScreen
        termsAndConditionsVC.modalTransitionStyle = .crossDissolve
        self.present(termsAndConditionsVC, animated: true)
    }
    
    func ProfileView(_ view: ProfileView, signOutButtonPressed button: UIButton) {
        let alertController = UIAlertController(title: NSLocalizedString("PROFILE_ALERT_TITLE", comment: "Sign out"),
                                                message: NSLocalizedString("PROFILE_ALERT_MESSAGE", comment: "Are you sure you want to sign out of your profile?"),
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: NSLocalizedString("PROFILE_ALERT_CANCEL_ACTION", comment: "Cancel"), style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: NSLocalizedString("PROFILE_ALERT_OK_ACTION", comment: "Yes"), style: .default) { (_) in
            self.signOut()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func signOut() {
        FirebaseManager.shared.signOut {
            UserDefaults.standard.set([], forKey: "SavedCategories")
            let onboardingVC = OnboardingViewController()
            onboardingVC.modalPresentationStyle = .fullScreen
            onboardingVC.modalTransitionStyle = .crossDissolve
            self.present(onboardingVC, animated: true)
        }
    }
    
    func getProfileImage() -> UIImage {
        let images = [
            Resources.Profile.profileImage1,
            Resources.Profile.profileImage2,
            Resources.Profile.profileImage3,
            Resources.Profile.profileImage4
        ]
    
        guard let image = images.randomElement()! else { return UIImage(systemName: "person.crop.circle")! }
        return image
    }
}
