//
//  ContentView.swift
//  BestRest
//
//  Created by Jigmet stanzin Dadul on 24/01/24.
//

import SwiftUI
import CoreML


struct ContentView: View {
    @State private var wakeUpTime = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            
            Form {
                Section("Enter the details") {
                    HStack{
                        Text("Your desired wake up time   ")
                        DatePicker("", selection: $wakeUpTime, displayedComponents: .hourAndMinute).labelsHidden()
                    }
                    VStack {
                        Stepper("Desired Amount of Sleep", value: $sleepAmount, in: 1...14, step: 0.25)
                        Spacer(minLength: 10)
                        Text("\(sleepAmount)").bold()
                    }
                    VStack {
                        Stepper("Coffee Intake", value: $coffeeAmount, in: 1...8)
                        Spacer(minLength: 10)
                        Text("\(coffeeAmount)").bold()
                    }
                }
                Button("Get bed Time"){
                    calculateRestTime()
                }
                .padding(10)
                .background(Color.cyan)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .navigationTitle("Better Rest")
            .toolbar {
            
                Button("Reset", action: calculateRestTime)
                    .buttonStyle(.bordered)
                    .tint(.orange)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Re Calculate") {
                    
                }
            } message: {
                Text(alertMessage)
            }
            
        }
    }
    
    
    func calculateRestTime()->Void{
        do{
            let config = MLModelConfiguration()
            let SleepModel = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hours = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            let prediction = try SleepModel.prediction(coffee: Int64(coffeeAmount), estimatedSleep: sleepAmount, wake: Int64(hours + minutes))
            let sleepTime = wakeUpTime - prediction.actualSleep
            alertTitle = "Your bed Time"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "Failure"
            alertMessage = "Sorry, request failed"
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
