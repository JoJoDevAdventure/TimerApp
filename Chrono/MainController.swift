//
//  ViewController.swift
//  Chrono
//
//  Created by Youssef Bhl on 07/02/2022.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var restSaveButton: UIButton!
    
    var timerPlaying : Bool!
    var timer : Timer?
    var mSecond : Int = 0
    var second : Int = 0
    var minute : Int = 0
    var savedTimes: [String] = []
    var timeNumber = 0
    var timeNumbers: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialMod()
        tableViewSetup()
    }
    
    func initialMod() {
        timerPlaying = false
        tableView.isHidden = true
        restSaveButton.isHidden = true
        restSaveButton.layer.cornerRadius = restSaveButton.frame.height / 2
        playPauseButton.layer.cornerRadius = playPauseButton.frame.height / 2
        tableView.layer.cornerRadius = 20
    }
    
    //pause timer
    func pauseTimer() {
        //UI Adjustement
        restSaveButton.setImage(UIImage(systemName: "stop.fill")!, for: .normal)
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        timerPlaying.toggle()
        
        //Pause timer
        timer?.invalidate()
    }
    
    //start timer
    func startTimer() {
        //UI Adjustement
        restSaveButton.isHidden = false
        restSaveButton.setImage(UIImage(systemName: "flag.fill")!, for: .normal)
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        timerPlaying.toggle()
        
        //Start timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            self.mSecond += Int(0.01*100)
            if self.mSecond > 99 {
                self.second += 1
                self.mSecond = 0
            }
            if self.second > 59 {
                self.minute += 1
            }
            let curentTime = self.updateTimerLabel()
            self.timeLabel.text = curentTime
        })
    }
    
    //rest all
    func restTimer() {
        //UI Adjust
        restSaveButton.isHidden = true
        tableView.isHidden = true
        timeLabel.textAlignment = .center
        
        //rest
        mSecond = 0
        second = 0
        minute = 0
        timeNumber = 0
        let curentTime = self.updateTimerLabel()
        self.timeLabel.text = curentTime
        savedTimes.removeAll()
        timeNumbers.removeAll()
    }
    
    //save time
    func saveTime() {
        //UI Adjust
        tableView.isHidden = false
        timeLabel.textAlignment = .left
        
        //add to table and reload table view
        let curentTime = self.updateTimerLabel()
        savedTimes.append(curentTime)
        timeNumber += 1
        timeNumbers.append(timeNumber)
        tableView.reloadData()
    }
    
    func updateTimerLabel() -> String {
        let mSecondString = String(format: "%02d", self.mSecond)
        let secondString = String(format: "%02d", self.second)
        let minutesString = String(format: "%02d", self.minute)
        return "\(minutesString):\(secondString):\(mSecondString)"
    }
    
    @IBAction func playPausePressed(_ sender: Any) {
        timerPlaying ? pauseTimer() : startTimer()
    }
     
    @IBAction func restSaveButton(_ sender: UIButton) {
        timerPlaying ? saveTime() : restTimer()
    }
    
    
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        cell.timeText = savedTimes[(savedTimes.count-1) - indexPath.row]
        cell.timeNumber = timeNumbers[(savedTimes.count-1) - indexPath.row]
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
