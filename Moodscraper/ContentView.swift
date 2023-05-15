//
//  ContentView.swift
//  Moodscraper
//
//  Created by Yaroslav Samoylov on 5/5/23.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var receivedData: CGFloat = 100.0
    
    
    var cityBackground: some View {
        ZStack(alignment: .bottomLeading){
            HStack(alignment:.bottom, spacing: -1){
                ForEach(0..<8) { _ in
                    var randomWidth: CGFloat { CGFloat.random(in: 40...receivedData) }
                    var randomHeight: CGFloat { CGFloat.random(in: 100...420) }
                    Rectangle()
                        .foregroundColor(Color(red: 235 / 255, green: 232 / 255, blue: 240 / 255))
                        .frame(width: randomWidth, height: randomHeight)
                }
                .padding(.bottom, 40)
            }
            var treeA = CGFloat.random(in: 25...40)
            var treeB = CGFloat.random(in: 30...45)
            //Tree 1
            VStack{
                Circle()
                    .frame(width: treeA, height: treeA)
                    .padding(.bottom, -10)
                Rectangle()
                    .frame(width: 1, height: treeA/2)
                    .padding(.bottom, 40)
            }
            .padding(.leading, 20)
            //tree 2
            VStack{
                Circle()
                    .frame(width: treeA, height: treeA)
                    .padding(.bottom, -10)
                Rectangle()
                    .frame(width: 1, height: treeB/2)
                    .padding(.bottom, 40)
            }
            .padding(.leading, 120)
            //Tree 3
            VStack{
                Circle()
                    .frame(width: treeB, height: treeB)
                    .padding(.bottom, -10)
                Rectangle()
                    .frame(width: 1, height: treeA/2)
                    .padding(.bottom, 40)
            }
            .padding(.leading, 440)
            // bench
            HStack(alignment:.bottom, spacing: -1) {
                Rectangle()
                    .frame(width: 1, height: 14)
                    .padding(.bottom, 40)
                VStack(alignment: .leading, spacing: -1){
                    Rectangle()
                        .frame(width: 40, height: 1)
                        .padding(.bottom, 3)
                    Rectangle()
                        .frame(width: 40, height: 1)
                        .padding(.bottom, 3)
                    Rectangle()
                        .frame(width: 44, height: 1)
                        .padding(.bottom, 45)
                }
                Rectangle()
                    .frame(width: 1, height: 5)
                    .padding(.bottom, 40)
                    .padding(.leading, -40)
                Rectangle()
                    .frame(width: 1, height: 9)
                    .padding(.bottom, 45)
                    .padding(.leading, -3)
                Rectangle()
                    .frame(width: 1, height: 5)
                    .padding(.bottom, 40)
            }
            .padding(.leading, 60)
            //tree 4
            VStack{
                Circle()
                    .frame(width: treeA, height: treeA)
                    .padding(.bottom, -10)
                Rectangle()
                    .frame(width: 1, height: treeB/2)
                    .padding(.bottom, 40)
            }
            .padding(.leading, 530)
//            Circle()
//                .foregroundColor(Color(red: 235 / 255, green: 232 / 255, blue: 240 / 255))
//                .frame(width: 100, height: 100)
//                .padding(.bottom, 480)
        }
    }
    
    var body: some View {
        ScrollView {
            List{}
            ZStack(alignment: .bottom){
                cityBackground
                CalendarView(newCity: $receivedData)
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
