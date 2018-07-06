//
//  ViewController.swift
//  SoundCloud
//
//  Created by Administrator on 21/05/2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {
    
    var Sounds : [String] = ["Sound1", "Sound2", "Sound3", "Sound4", "Sound5", "Sound6", "Sound7"]
    var Music = [AVAudioPlayer]()
    var Selected : [Bool] = [false, false, false, false, false, false, false]
    var CurrentSong : Int = 0
    @IBOutlet weak var PlayingLbl: UILabel!
    
    @IBAction func StopBtn(_ sender: Any) {
        Music[CurrentSong].stop()
        Music[CurrentSong].currentTime = 0
        CurrentSong = 0
    }
    @IBAction func PauseBtn(_ sender: Any) {
        Music[CurrentSong].pause()
     
    }
    @IBAction func btn(_ sender: Any) {
        for i in CurrentSong..<Music.count {
            CurrentSong = i
            if(Selected[i]){
                PlaySong(SongIndex: CurrentSong)
                break
            }
        }
        

    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        for i in (CurrentSong + 1)..<Music.count {
            CurrentSong = i
            if(Selected[i]){
                PlaySong(SongIndex: CurrentSong)
                break
            }
        }
    }
    func PlaySong(SongIndex: Int){
        Music[SongIndex].play()
        PlayingLbl.text = Sounds[SongIndex] + " is Playing"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = Sounds[indexPath.row]
        if(Selected[indexPath.row]){
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        if (Selected[indexPath.row]){
            Selected[indexPath.row] = false
        }
        else {
            Selected[indexPath.row] = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "SoundCloud";
        
        for i in 0..<Sounds.count {
            let url = Bundle.main.url(forResource: Sounds[i], withExtension: "mp3")

            do {
                Music.append(try AVAudioPlayer(contentsOf: url!))
                Music[i].delegate = self as? AVAudioPlayerDelegate
                Music[i].prepareToPlay()
                Music[i].currentTime = 0
            }
            catch {
                print("Error")
            }
        }
        
//            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){_ in
//                self.lblInfo.text = "\(String(describing: self.audioPlayer?.currentTime))"
//            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

