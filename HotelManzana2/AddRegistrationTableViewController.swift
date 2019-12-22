//
//  AddRegistrationTableViewController.swift
//  HotelManzana2
//
//  Created by Marc Batete on 11/12/19.
//  Copyright © 2019 Marc Batete. All rights reserved.
//

import UIKit
//Step one nav cont
//step 2 add this File
class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    //start
    //step 26
    @IBOutlet var roomTypeLabel: UILabel!
    var roomType: RoomType?
    //page 719
    
    //step 27
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    //step 14
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    
    //step 30
    var registration: Registration? {
    
        guard let roomType = roomType else { return nil }
    
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
    
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi)
    }
    
  //step 15
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    // step 16
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    //step 18
    @IBOutlet var wifiSwitch: UISwitch!
    
    //step 19
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        //implemented later
    }

    
    //step 11
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    
    //step 5
        @IBOutlet var checkInDateLabel: UILabel!
        @IBOutlet var checkInDatePicker: UIDatePicker!
        @IBOutlet var checkOutDateLabel: UILabel!
        @IBOutlet var checkOutDatePicker: UIDatePicker!
    //Step 3 outlets
        @IBOutlet var firstNameTextField: UITextField!
        @IBOutlet var lastNameTextField: UITextField!
        @IBOutlet var emailTextField: UITextField!
    
    //step 4 add button and connect to action outlet
//    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
//        let firstName = firstNameTextField.text ?? ""
//        let lastName = lastNameTextField.text ?? ""
//        let email = emailTextField.text ?? ""
//        let checkInDate = checkInDatePicker.date
//        let checkOutDate = checkOutDatePicker.date
//        let numberOfAdults = Int(numberOfAdultsStepper.value)
//        let numberOfChildren = Int(numberOfChildrenStepper.value)
//        let hasWifi = wifiSwitch.isOn
//        let roomChoice = roomType?.name ?? "Not Set"
//       
//    
//        print("DONE TAPPED")
//        print("firstName: \(firstName)")
//        print("lastName: \(lastName)")
//        print("email: \(email)")
//        print("checkIn: \(checkInDate)")
//        print("checkOut: \(checkOutDate)")
//        print("numberOfAdults: \(numberOfAdults)")
//        print("numberOfChildren: \(numberOfChildren)")
//        print("wifi: \(hasWifi)")
//        print("roomType: \(roomChoice)")
//    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    //step 6 page 703
    func updateDateViews(){
    //step 8
        checkOutDatePicker.minimumDate =
        checkInDatePicker.date.addingTimeInterval(86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
          
       
    }
    //step 9
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //step 7
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        //step 10
        updateDateViews()
        //step 17
        updateNumberOfGuests()
        //page 705
        updateRoomType() //page 720
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    //step 12
 
    override func tableView(_ tableView: UITableView, heightForRowAt
     indexPath: IndexPath) -> CGFloat {
         switch indexPath {
         case checkInDatePickerCellIndexPath:
     
             if isCheckInDatePickerShown {
                 return 216.0
             } else {
                 return 0.0
             }
         case checkOutDatePickerCellIndexPath:
             if isCheckOutDatePickerShown {
                 return 216.0
             } else {
                 return 0.0
             }
         default:
             return 44.0
         }
     }
    
     //step 13
     override func tableView(_ tableView: UITableView, didSelectRowAt
     indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
     
         switch indexPath {
         case checkInDateLabelCellIndexPath:
     
             if isCheckInDatePickerShown {
                 isCheckInDatePickerShown = false
             } else if isCheckOutDatePickerShown {
                 isCheckOutDatePickerShown = false
                 isCheckInDatePickerShown = true
             } else {
                 isCheckInDatePickerShown = true
             }
     
             tableView.beginUpdates()
             tableView.endUpdates()
     
         case checkOutDateLabelCellIndexPath:
             if isCheckOutDatePickerShown {
                 isCheckOutDatePickerShown = false
             } else if isCheckInDatePickerShown {
                 isCheckInDatePickerShown = false
                 isCheckOutDatePickerShown = true
             } else {
                 isCheckOutDatePickerShown = true
             }
     
             tableView.beginUpdates()
             tableView.endUpdates()
     
         default:
             break
         }
     }
   
    
    //step 29
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as?
            SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
*/
    
    //step 28
    func didSelect(roomType: RoomType) {
            self.roomType = roomType
            updateRoomType()
        }
}
