//
//  GraphVC.swift
//  VampÏr
//
//  Created by 60436 on 4/13/18.
//  Copyright © 2018 Spencer Crow. All rights reserved.
//

import UIKit
import Charts
import ObjectMapper
class GraphVC: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    var minutes: [Double]!
    
    @IBOutlet weak var lblCurrent: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hour = Calendar.current.component(.hour, from: Date())
        let parameters = ["message":UserDefaults.standard.object(forKey: "message") as! String,"hour":hour] as [String : Any]
        var readings:[Double]?
        let minutes = [0.0, 5.0, 10.0, 15.0]
        NetworkCallManager.baseURLRequest(urlString: Endpoints.base + Endpoints.predict, parameters: parameters, method: .post, completion: {json in
            let map = Map(mappingType: MappingType.fromJSON, JSON: json)
            let prediction = Prediction(map: map)
            readings = prediction?.prediction
            self.lblCurrent.text = String(format:"%.0f", readings![0]) + " mg/dL"
            self.setChart(dataPoints: minutes, values: readings!)
        }, errorHandler: {_ in
            UserDefaults.standard.set(nil, forKey: "message")
            self.performSegue(withIdentifier: "Failed", sender: self)
        })

    }

    func setChart(dataPoints: [Double], values: [Double]) {
        lineChartView.noDataText = "Failed to retrieve data from Dexcom"
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: dataPoints[i], y: values[i])
            dataEntries.append(dataEntry)
        }
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.axisMinimum = 50
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.enabled = false
        let bottomAxis = lineChartView.xAxis
        bottomAxis.drawAxisLineEnabled = false
        bottomAxis.drawGridLinesEnabled = false
        bottomAxis.labelPosition = XAxis.LabelPosition.bottom
        bottomAxis.labelTextColor = UIColor.white
        bottomAxis.labelCount = dataEntries.count-1
        bottomAxis.labelFont = UIFont(name: "Helvetica Neue", size: 20)!
        bottomAxis.avoidFirstLastClippingEnabled = true
        bottomAxis.granularity = 5
        bottomAxis.axisMinimum = -0.5
        bottomAxis.axisMaximum = 15.5
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.highlightPerTapEnabled = false
        lineChartView.highlightPerDragEnabled = false
        lineChartView.legend.enabled = false
        
        let line1 = LineChartDataSet(values: dataEntries, label: "Blood Glucose Level")
        let valueformatter = NumberFormatter()
        valueformatter.numberStyle = .none
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: valueformatter)
        line1.valueFormatter = valuesNumberFormatter
        line1.setColor(NSUIColor.white)
        line1.setCircleColor(NSUIColor.white)
        line1.valueTextColor = UIColor.white
        line1.valueFont = UIFont(name:"Helvetica Neue", size: 15)!
        line1.lineWidth = 2.75
        line1.circleRadius = 5
        line1.fillColor = hexStringToUIColor(hex: "#233842")
        line1.drawFilledEnabled = true
        line1.cubicIntensity = 0.1
        line1.mode = LineChartDataSet.Mode.cubicBezier
        let chartData = LineChartData(dataSet: line1)
        lineChartView.data = chartData
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class ChartValueFormatter: NSObject, IValueFormatter {
        fileprivate var numberFormatter: NumberFormatter?
        
        convenience init(numberFormatter: NumberFormatter) {
            self.init()
            self.numberFormatter = numberFormatter
        }
        
        func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            guard let numberFormatter = numberFormatter
                else {
                    return ""
            }
            return numberFormatter.string(for: value)!
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
