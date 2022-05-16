//
//  HomeVC.swift
//  WoWonderiOS
//
//  Created by Abdul Moid on 09/06/2021.
//  Copyright © 2021 clines329. All rights reserved.
//

import UIKit
import AlamofireImage
import Kingfisher
import SDWebImage
import PaginatedTableView
import Toast_Swift
import ZKProgressHUD
import NVActivityIndicatorView
import WoWonderTimelineSDK
import GoogleMobileAds
import AVFoundation


class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var newsFeedArray = [[String:Any]]()
    var filterFeedArray = [[String:Any]]()
    var suggestedGroupArray = [[String:Any]]()
    var suggestedUserArray = [[String: Any]]()
    var isVideo:Bool? = false
    
    var flag = true
    
    let spinner = UIActivityIndicatorView(style: .gray)
    let pulltoRefresh = UIRefreshControl()
    var storiesArray = [GetStoriesModel.UserDataElement]()
    let status = Reach().connectionStatus()
    var selectedIndex = 0
    var filter = 1
    let playRing = URL(fileURLWithPath: Bundle.main.path(forResource: "click_sound", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
        
//    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: 250, height: 40))
//    let placeholder = NSAttributedString(string: "Search", attributes: [.foregroundColor: UIColor.white])
    
    var off_set = "0"
    var flagTemp = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        if (AppInstance.instance.newsFeed_data.count == 0){
            self.getNewsFeed(access_token: "\("?")\("access_token")\("=")\(UserData.getAccess_Token()!)", limit:15, offset: "0")
        }
        if (AppInstance.instance.newsFeed_data.count == 0){
            self.getNewsFeed(access_token: "\("?")\("access_token")\("=")\(UserData.getAccess_Token()!)", limit:15, offset: "0")
        }
        else{
//            self.activityIndicator.stopAnimating()
            self.newsFeedArray = AppInstance.instance.newsFeed_data
            self.off_set = self.newsFeedArray.last?["post_id"] as? String ?? "0"
            self.tableView.reloadData()
        }
        
        if (AppInstance.instance.suggested_groups.count == 0) {
            self.getSuggestedGroup(type: "groups", limit: 8)
        }
        else {
//            self.activityIndicator.stopAnimating()
            self.suggestedGroupArray = AppInstance.instance.suggested_groups
            self.tableView.reloadData()
        }
        
        if(AppInstance.instance.suggested_users.count == 0) {
            self.getSuggestedUser(type: "users", limit: 8)
            self.tableView.reloadData()
        }
        else {
//            self.activityIndicator.stopAnimating()
            self.suggestedUserArray = AppInstance.instance.suggested_users
            self.tableView.reloadData()
        }
    }
    
    
    private func getSuggestedUser(type: String, limit: Int) {
        GetSuggestedGroupManager.sharedInstance.getGroups(type: type, limit: 8) {
            (success, authError, error) in
            if success != nil {
                for i in success!.data {
                    self.suggestedUserArray.append(i)
                }
                print("----------------")
                print("suggested users")
                print(self.suggestedUserArray.count)
                print("----------------")
                self.tableView.reloadData()
            }
            else if authError != nil {
                self.view.isUserInteractionEnabled = true
                self.view.makeToast(authError?.errors?.errorText)
            }
            else if error  != nil {
                self.view.isUserInteractionEnabled = true
                print(error?.localizedDescription)
            }
        }
    }
    
    
    private func getSuggestedGroup(type: String, limit: Int) {
        GetSuggestedGroupManager.sharedInstance.getGroups(type: type, limit: 8) {
            (success, authError, error) in
            if success != nil {
                for i in success!.data {
                    self.suggestedGroupArray.append(i)
                }
                self.tableView.reloadData()
            }
            else if authError != nil {
                self.view.isUserInteractionEnabled = true
                self.view.makeToast(authError?.errors?.errorText)
            }
            else if error  != nil {
                self.view.isUserInteractionEnabled = true
                print(error?.localizedDescription)
            }
        }
    }
    
    private func getNewsFeed (access_token : String, limit : Int, offset : String) {
        
        switch status {
        case .unknown, .offline:
            ZKProgressHUD.dismiss()
            self.view.makeToast(NSLocalizedString("Internet Connection Failed", comment: "Internet Connection Failed"))
            self.view.isUserInteractionEnabled = true
        case .online(.wwan), .online(.wiFi):
            performUIUpdatesOnMain {
                GetNewsFeedManagers.sharedInstance.get_News_Feed(filter: self.filter, access_token: access_token, limit: limit, off_set: offset) {[weak self] (success, authError, error) in
                    if success != nil {
                        for i in success!.data{
                            self?.newsFeedArray.append(i)
                        }
                        self?.off_set = self?.newsFeedArray.last?["post_id"] as? String ?? "0"
                        for it in self!.newsFeedArray{
                            let boosted = it["is_post_boosted"] as? Int ?? 0
                            self?.newsFeedArray.sorted(by: { _,_ in boosted == 1 })
                        }
//                        let boosted = self?.newsFeedArray["is_post_boosted"] as? Int ?? 0
//                        self?.newsFeedArray.sorted(by: { _,_ in boosted == 1 })
                        self?.spinner.stopAnimating()
                        self?.pulltoRefresh.endRefreshing()
                        self?.tableView.reloadData()
                        self?.view.isUserInteractionEnabled = true
                        self?.loadStories()
//                        self?.activityIndicator.stopAnimating()
                        ZKProgressHUD.dismiss()
                    }
                    else if authError != nil {
                        ZKProgressHUD.dismiss()
                        self?.view.isUserInteractionEnabled = true
                        self?.view.makeToast(authError?.errors.errorText)
                    }
                    else if error  != nil {
                        ZKProgressHUD.dismiss()
                        self?.view.isUserInteractionEnabled = true
                        print(error?.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    private func loadStories(){
        switch status {
        case .unknown, .offline:
            ZKProgressHUD.dismiss()
            self.view.makeToast(NSLocalizedString("Internet Connection Failed", comment: "Internet Connection Failed"))
        case .online(.wwan), .online(.wiFi):
            performUIUpdatesOnMain {
                StoriesManager.sharedInstance.getUserStories(offset: 0, limit: 10) {[weak self] (success, authError, error) in
                    if success != nil {
                        self!.storiesArray = success?.stories ?? []
                        self?.tableView.reloadData()
                        
                    }
                    else if authError != nil {
                        ZKProgressHUD.dismiss()
                        self!.view.makeToast(authError?.errors?.errorText)
                        self!.showAlert(title: "", message: (authError?.errors?.errorText)!)
                    }
                    else if error  != nil {
                        ZKProgressHUD.dismiss()
                        print(error?.localizedDescription)
                        
                    }
                }
            }
        }
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "HomeAddPostCell", bundle: nil), forCellReuseIdentifier: "HomeAddPostCell")
        self.tableView.register(UINib(nibName: "HomeStroyCells", bundle: nil), forCellReuseIdentifier: "HomeStroyCells")
//        self.tableView.register(UINib(nibName: "HomeStroyCells", bundle: nil), forCellReuseIdentifier: "HomeStroyCells")
        self.tableView.register(UINib(nibName: "HomeGreetings", bundle: nil), forCellReuseIdentifier: "HomeGreetings")
        SetUpcells.setupCells(tableView: self.tableView)

    }
    
    @IBAction func searchClicked(_ sender: Any) {
        let Storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = Storyboard.instantiateViewController(withIdentifier: "SearchVC") as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
    func gotoPost(){
        let storyboard = UIStoryboard(name: "AddPost", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPostVC") as! AddPostVC
        vc.isOpenSheet = 1
        self.present(vc, animated: true)
    }
    
    @IBAction func messengerClicked(_ sender: Any) {
        self.openMessenger()
    }
    
    func showStoriesLog(){
        let alert = UIAlertController(title: NSLocalizedString("source", comment: "source"), message: NSLocalizedString("Add new Story", comment: "Add new Story"), preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: NSLocalizedString("Camera", comment: "Camera"), style: .default) { (action) in
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                self.isVideo = false
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                imagePickerController.allowsEditing = false
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
                
            }else{
                let alert  = UIAlertController(title: NSLocalizedString("Warning", comment: "Warning"), message: NSLocalizedString("You don't have camera", comment: "You don't have camera"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        let videos = UIAlertAction(title: NSLocalizedString("Videos", comment: "Videos"), style: .default) { (UIAlertAction) in
            self.isVideo = true
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.mediaTypes = ["public.movie"]
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
        let image = UIAlertAction(title: NSLocalizedString("image", comment: "image"), style: .default) { (action) in
            self.isVideo = false
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePickerController.mediaTypes = ["public.image"]
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel) { (action) in
            print("cancel")
        }
        alert.addAction(image)
        alert.addAction(videos)
        alert.addAction(camera)
        alert.addAction(cancel)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func openMessenger(){
        let appURLScheme = "AppToOpen://"
        guard let appURL = URL(string: appURLScheme) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(appURL) {
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        }
        else {
            self.view.makeToast("Please install WoWonder Messenger App")
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 + self.newsFeedArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeAddPostCell", for: indexPath) as! HomeAddPostCell
            cell.vc = self
            let url = URL(string: UserData.getImage() ?? "")
            cell.userprofileImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "no-avatar"), options: [], completed: nil)
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeStroyCells", for: indexPath) as! HomeStroyCells
//            cell.selectionStyle = .none
            cell.vc = self
            cell.stories = self.storiesArray
//            cell.collectionView.reloadData()
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeGreetings", for: indexPath) as! HomeGreetings
            cell.vc = self
            let url = URL(string: UserData.getImage() ?? "")
            cell.userprofileImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "no-avatar"), options: [], completed: nil)
            return cell
        }else{
            let indxPath = IndexPath(row: indexPath.section - 3, section: 0)
            let index = self.newsFeedArray[indexPath.section - 3]
            var tableViewCells = UITableViewCell()
            var shared_info : [String:Any]? = nil
            var fundDonation: [String:Any]? = nil
            var live = ""
            let postfile = index["postFile"] as? String ?? ""
            let postLink = index["postLink"] as? String ?? ""
            let postYoutube = index["postYoutube"] as? String ?? ""
            let blog = index["blog_id"] as? String ?? "0"
            let group = index["group_recipient_exists"] as? Bool ??  false
            let product = index["product_id"] as? String ?? "0"
            let event = index["page_event_id"] as? String ?? "0"
            let postSticker = index["postSticker"] as? String ?? ""
            let colorId = index["color_id"] as? String ?? "0"
            let multi_image = index["multi_image"] as? String ?? "0"
            let photoAlbum = index["album_name"] as? String ?? ""
            let postOptions = index["poll_id"] as? String ?? "0"
            let postRecord = index["postRecord"] as? String ?? "0"
            if let postType = index["postType"] as? String{
                live = postType
            }
            if let sharedInfo = index["shared_info"] as? [String:Any] {
                shared_info = sharedInfo
            }
            if let fund = index["fund_data"] as? [String:Any]{
                fundDonation = fund
            }
            
            if (shared_info != nil){
                tableViewCells = GetPostShare.sharedInstance.getsharePost(targetController: self, tableView: self.tableView, indexpath: indxPath, postFile: postfile, array: self.newsFeedArray)
            }
            else if (live == "live"){
                let cell = tableView.dequeueReusableCell(withIdentifier: "LiveCell") as! PostLiveCell
                self.tableView.rowHeight = UITableView.automaticDimension
                self.tableView.estimatedRowHeight = 350.0
                cell.bind(index: index, indexPath: indexPath.section - 3)
                cell.vc = self
                tableViewCells = cell
            }
            else if (postfile != "")  {
                let url = URL(string: postfile)
                let urlExtension: String? = url?.pathExtension
                if (urlExtension == "jpg" || urlExtension == "png" || urlExtension == "jpeg" || urlExtension == "JPG" || urlExtension == "PNG"){
                    print("NewsFeed",indexPath.row)
                    tableViewCells = GetPostWithImage.sharedInstance.getPostImage(targetController: self, tableView: tableView, indexpath: indxPath, postFile: postfile, array: self.newsFeedArray, url: url!, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                }
                    
                else if(urlExtension == "wav" ||  urlExtension == "mp3" || urlExtension == "MP3"){
                    tableViewCells = GetPostMp3.sharedInstance.getMP3(targetController: self, tableView: tableView, indexpath: indxPath, postFile: postfile, array: self.newsFeedArray,stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                }
                else if (urlExtension == "pdf") {
                    tableViewCells = GetPostPDF.sharedInstance.getPostPDF(targetControler: self, tableView: self.tableView, indexpath: indxPath, postfile: postfile, array: self.newsFeedArray,stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                    
                }
                    
                else {
                    tableViewCells = GetPostVideo.sharedInstance.getVideo(targetController: self, tableView: tableView, indexpath: indxPath, postFile: postfile, array: self.newsFeedArray, url: url!, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                }
            }
                
            else if (postLink != "") {
                tableViewCells = GetPostWithLink.sharedInstance.getPostLink(targetController: self, tableView: tableView, indexpath: indxPath, postLink: postLink, array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
            }
                
            else if (postYoutube != "") {
                tableViewCells = GetPostYoutube.sharedInstance.getPostYoutub(targetController: self, tableView: tableView, indexpath: indxPath, postLink: postYoutube, array: self.newsFeedArray,stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                
            }
            else if (blog != "0") {
                tableViewCells = GetPostBlog.sharedInstance.GetBlog(targetController: self, tableView: tableView, indexpath: indxPath, postFile: "", array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
            }
                
            else if (group != false){
                tableViewCells = GetPostGroup.sharedInstance.GetGroupRecipient(targetController: self, tableView: tableView, indexpath: indxPath, postFile: "", array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
            }
                
            else if (product != "0") {
                tableViewCells = GetPostProduct.sharedInstance.GetProduct(targetController: self, tableView: tableView, indexpath: indxPath, postFile: "", array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
            }
            else if (event != "0") {
                tableViewCells = GetPostEvent.sharedInstance.getEvent(targetController: self, tableView: tableView, indexpath: indxPath, postFile: "", array:  self.newsFeedArray,stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                
            }
            else if (postSticker != "") {
                tableViewCells = GetPostSticker.sharedInstance.getPostSticker(targetController: self, tableView: tableView, indexpath: indxPath, postFile: postfile, array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
            }
                
            else if (colorId != "0"){
                tableViewCells = GetPostWithBg_Image.sharedInstance.postWithBg_Image(targetController: self, tableView: tableView, indexpath: indxPath, array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
            }
                
            else if (multi_image != "0") {
                tableViewCells = GetPostMultiImage.sharedInstance.getMultiImage(targetController: self, tableView: tableView, indexpath: indxPath, array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                
            }
                
            else if photoAlbum != "" {
                tableViewCells = getPhotoAlbum.sharedInstance.getPhoto_Album(targetController: self, tableView: tableView, indexpath: indxPath, array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
            }
                
            else if postOptions != "0" {
                tableViewCells = GetPostOptions.sharedInstance.getPostOptions(targertController: self, tableView: tableView, indexpath: indxPath, array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
            }
                
            else if postRecord != ""{
                tableViewCells = GetPostRecord.sharedInstance.getPostRecord(targetController: self, tableView: tableView, indexpath: indxPath, array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                
            }
            else if fundDonation != nil{
                tableViewCells = GetDonationPost.sharedInstance.getDonationpost(targetController: self, tableView: tableView, indexpath: indxPath, array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
        
            }
                
            else {
                tableViewCells = GetNormalPost.sharedInstance.getPostText(targetController: self, tableView: self.tableView, indexpath: indxPath, postFile: "", array: self.newsFeedArray, stackViewHeight: 50.0, viewHeight: 22.0, isHidden: false, viewColor: .lightGray)
                
            }
            return tableViewCells
        }
    }
    
    func createLive(){
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = Storyboard.instantiateViewController(identifier: "CreateLiveVC") as! CreateLiveController
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.goToAddPost()
        }
    }
    
    func goToAddPost(){
        let storyboard = UIStoryboard(name: "AddPost", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddPostVC") as! AddPostVC
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 1
        }else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vi = UIView()
        vi.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        return vi
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        }else if indexPath.section == 1 {
            return 180
        }else if indexPath.section == 2 {
            return 120
        }else{
            return UITableView.automaticDimension
        }
    }
}

extension HomeVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
            if self.isVideo! {
                
                let vidURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
                var CreateVideoStoryVC = UIStoryboard(name: "Stories", bundle: nil).instantiateViewController(withIdentifier: "CreateVideoStoryVC") as! CreateVideoStoryVC
                let videoData = try? Data(contentsOf: vidURL)
                CreateVideoStoryVC.videoData1 = videoData
                CreateVideoStoryVC.videoLinkString  = vidURL.absoluteString
                self.navigationController?.pushViewController(CreateVideoStoryVC, animated: true)
                
            }else{
                let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
                
                var CreateImageStoryVC = UIStoryboard(name: "Stories", bundle: nil).instantiateViewController(withIdentifier: "CreateImageStoryVC") as! CreateImageStoryVC
                CreateImageStoryVC.imageLInkString  = FileManager().savePostImage(image: img!)
                CreateImageStoryVC.iamge = img
                CreateImageStoryVC.isVideo = self.isVideo
                self.navigationController?.pushViewController(CreateImageStoryVC, animated: true)
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension HomeVC: createLiveDelegate {
    
    func createLive(name: String) {
        let Storyboards = UIStoryboard(name: "Main", bundle: nil)
        let vc = Storyboards.instantiateViewController(withIdentifier: "LiveVC") as! LiveStreamController
        vc.streamName = name
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
