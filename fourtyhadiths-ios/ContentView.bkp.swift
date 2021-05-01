//
//  ContentView.swift
//  fourtyhadiths-ios
//
//  Created by Yasser Elsayed on 4/29/21.
//

import SwiftUI

struct ContentViewBkp: View {
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                CityNameView()
                
                TodayWeatherView()
                
                HStack (spacing: 20) {
                    WeatherDayView(day: "TUE", image: "cloud.sun.fill", temp: 75)
                    WeatherDayView(day: "WED", image: "sun.max.fill", temp: 75)
                    WeatherDayView(day: "THU", image: "wind.snow", temp: 25)
                    WeatherDayView(day: "FRI", image: "sunset.fill", temp: 55)
                    WeatherDayView(day: "SAT", image: "snow", temp: 25)
                }
                
                Spacer()

                ActionButton(text: "Tap Me!")

                Spacer()
            }
        }
    }
}

struct WeatherDayView: View {
    var day: String
    var image: String
    var temp: Int
    
    var body: some View {
        VStack {
            Text(day)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            
            Image(systemName: image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temp)°")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

struct Background: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct CityNameView: View {
    var body: some View {
        Text("Cupertino, CA")
            .font(.system(size: 32, weight: .medium))
            .foregroundColor(.white)
            .padding()
    }
}

struct TodayWeatherView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180)
            
            Text("76°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

struct ActionButton: View {
    var text: String
    
    var body: some View {
        Button {
            print("Tapped!")
        } label : {
            Text(text)
                .frame(width: 280, height: 50)
                .background(Color.accentColor)
                .font(.system(size: 20, weight: .bold, design: .default))
                .cornerRadius(5)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
    }
}
