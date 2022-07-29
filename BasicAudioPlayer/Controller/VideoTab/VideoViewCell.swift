import UIKit

class VideoViewCell: UITableViewCell {
    //MARK: - UI Elements
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    //MARK: - Sub functions
    func setCell(data: VideoDataModel) {
        videoTitleLabel.text = data.title
        videoImageView.image = UIImage(systemName: data.imageName)
    }
}
