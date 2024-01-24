//
//  ContentView.swift
//  BestRest
//
//  Created by Jigmet stanzin Dadul on 24/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    
    var body: some View {
        NavigationView {
            
            Form {
                Section("Enter the details") {
                    HStack{
                        Text("Your desired wake up time   ")
                        DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
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
                Button("My rest time") {
                    //
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
            
        }
    }
    
    
    func calculateRestTime(){
        
    }
}

#Preview {
    ContentView()
}
