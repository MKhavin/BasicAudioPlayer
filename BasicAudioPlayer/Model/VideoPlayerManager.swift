import AVFoundation

class VideoPlayerManager {
    //MARK: - Sub properties
    let youtubeVideos = [
        VideoDataModel(title: "Macbook Air 2022", imageName: "photo", url: URL(string: "https://rr2---sn-4g5ednse.googlevideo.com/videoplayback?expire=1659093958&ei=Zm_jYqbaGI3s7ASQnKz4Bw&ip=185.31.164.48&id=o-ALWs_g68cYYkZ4mKIscqa7RiNEhonlH7sD0VbZGTSXo0&itag=22&source=youtube&requiressl=yes&pcm2=no&spc=lT-KhmFrlnHL6tnX09EwtVNcJLd9TJLSNqYDIUAdkmMR&vprv=1&mime=video%2Fmp4&ns=sHuyEMi2tUv8hAd-N2jPbTkH&cnr=14&ratebypass=yes&dur=900.028&lmt=1658559575071466&fexp=24001373,24007246&c=WEB&rbqsm=fr&txp=5432434&n=YRvBP7__xvHk0g&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cpcm2%2Cspc%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRAIgR7PPlV5q0h2TArkxE-IJ-C4fxakzJL1dx8ixg_uWUKgCIBLLvdSfuI0y-fHEA3lr3U7FE0ZxDXLeYd-Gyt69eDU3&redirect_counter=1&cm2rm=sn-n8vdred&req_id=d4d08a38af14a3ee&cms_redirect=yes&cmsv=e&mh=83&mip=185.42.127.125&mm=34&mn=sn-4g5ednse&ms=ltu&mt=1659072998&mv=m&mvi=2&pl=23&lsparams=mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRQIhAKsYCoRx8OHcvRnoyy5UbYTP5uredxKRFw5T9qyDccKAAiAGhEiH5WwYgtpVLTmTWKXHWLSBVL7NPzk5W3_hhW52lQ%3D%3D")),
        VideoDataModel(title: "Mac Os Monterey 12.5", imageName: "photo", url: URL(string: "https://rr5---sn-n8v7znlr.googlevideo.com/videoplayback?expire=1659094979&ei=Y3PjYqqjLJiPv_IPz4mjmA4&ip=185.31.164.48&id=o-AKfB18BRDjrg_POvCP4vCE4V7lcQby7j5IimrYH4vRHp&itag=22&source=youtube&requiressl=yes&mh=J8&mm=31%2C29&mn=sn-n8v7znlr%2Csn-n8v7kn7y&ms=au%2Crdu&mv=m&mvi=5&pl=23&pcm2=no&initcwndbps=1540000&spc=lT-KhujiBn3ul1Eyn_Igt1jWII7Vg6Pg8E-Kf-6s0u6Z&vprv=1&mime=video%2Fmp4&ns=AffJOjJ2ZdXaD-X_fS45lVsH&cnr=14&ratebypass=yes&dur=406.836&lmt=1658463973273959&mt=1659073017&fvip=14&fexp=24001373%2C24007246&c=WEB&rbqsm=fr&txp=5532434&n=56KhztJPDsnitQ&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cpcm2%2Cspc%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIhAOqTxnfAK1gmHLnW2A0HZauuuUOBU1HVwCVmQBgANUM0AiBPg2NBy3FHnjV0DbPmCQfx1QiIbfVIHIZ-rgB5OroC2A%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgSXen5QLUgNe_YmtyyA0r8Vv4VfGA_z4BkEJSMTu6oGYCIQCdUA8EKj3X4uTHmvnUUFkf-lQxE18usQKHBIPIivC9HA%3D%3D")),
        VideoDataModel(title: "Swift UI Example", imageName: "photo", url: URL(string: "https://rr1---sn-n8v7znsd.googlevideo.com/videoplayback?expire=1659095575&ei=t3XjYpuNGtXh7QTRgbnYBA&ip=185.31.164.48&id=o-AJQsHM1U2_4pSdmJRWnwlsKg4nS366KFY_TefdZtwzSS&itag=22&source=youtube&requiressl=yes&mh=4k&mm=31%2C26&mn=sn-n8v7znsd%2Csn-5goeenes&ms=au%2Conr&mv=m&mvi=1&pl=23&pcm2=no&initcwndbps=1623750&spc=lT-KhoxkoP9dcP88c92BrCnrHxxjD-FKeXYI66oKsA_k&vprv=1&mime=video%2Fmp4&ns=C6Frl26Mt5n0CEFsGuF54cwH&cnr=14&ratebypass=yes&dur=909.572&lmt=1659046480687652&mt=1659073735&fvip=1&fexp=24001373%2C24007246&c=WEB&rbqsm=fr&txp=6318224&n=BXaV3RdhW1NsBg&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cpcm2%2Cspc%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAI7JSRlEid84EFw-7h0c1KNyV6jLryOeDJYx3CnEEHKvAiEAjW9YC5uPMHDGNJGXCanWOVWr0Vp9nG-KqlUGb2RRZmo%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhAIWbIURS4-6LIKpkVp7IK5aE8oakRZK7wgL4NWXvUMK7AiAIbo0L8gXERF9ykgWLN9REF3CjU7jrvQVixc__fTHhMQ%3D%3D")),
        VideoDataModel(title: "Hacking with Swift", imageName: "photo", url: URL(string: "https://rr3---sn-n8v7znsy.googlevideo.com/videoplayback?expire=1659095626&ei=6XXjYp7UNojP7AT75JDYAw&ip=185.31.164.48&id=o-ACXs9NFPRitlejr_7hsJQNcuGIv5DKxIUZggVP-maYJH&itag=22&source=youtube&requiressl=yes&mh=SW&mm=31%2C29&mn=sn-n8v7znsy%2Csn-n8v7kn7e&ms=au%2Crdu&mv=m&mvi=3&pl=23&pcm2=no&initcwndbps=1623750&spc=lT-KhtPXKlL-VYYPY-7Ax6RCxdvRnoA_PwcwuyaY7kHU&vprv=1&mime=video%2Fmp4&ns=dQG-2U6qpRNIZmQ6WMnxC6EH&cnr=14&ratebypass=yes&dur=3814.690&lmt=1654780944488057&mt=1659073735&fvip=2&fexp=24001373%2C24007246&c=WEB&rbqsm=fr&txp=5432434&n=XTzcjFj96kr8jQ&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cpcm2%2Cspc%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRAIgCqihwv8m_vjJTDEnAAwa9kkKVf4HLrufIGkWVlMA8ysCIAyEaovnPJJ9ICVCD5Edue8stxHdTZHAqGyEmMYassaL&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgbn9zT3ABwNCA1dYBzzcEMbH_PcM_YjQWFEDe51ao_28CIQDkC0IjvW19PcdVrJE-iwFXbZPHZoAkvd5-AfZbHNteoA%3D%3D"))
    ]
    private var videoPlayer: AVPlayer?
    
    //MARK: - Sub properties
    func setUpVideoPlayer(with videoId: Int) -> AVPlayerLayer? {
        guard let url = youtubeVideos[videoId].url else {
            return nil
        }
        
        videoPlayer = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.videoGravity = .resizeAspect
        
        return playerLayer
    }
    
    //MARK: - Player functions
    func play() {
        videoPlayer?.play()
    }
    
    func stop() {
        videoPlayer?.pause()
        videoPlayer = nil
    }
}
