//
//  Calendar.swift
//  Moodscraper
//
//  Created by Yaroslav Samoylov on 5/8/23.
//

import SwiftUI



struct CalendarView:View {
    @State var currentDate = Date()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)

    private var items: FetchedResults<Item>
    @Binding var newCity: CGFloat

    var tableHeader: some View {
        HStack(spacing: -1){
            Text("DEPRESSED")
                .frame(width: 72)
                .modifier(TableTitleStyle())
            Text("UNSTABLE")
                .frame(width: 72)
                .modifier(TableTitleStyle())
            Text("FEEL GOOD")
                .frame(width: 72)
                .modifier(TableTitleStyle())
        }
    }
    
    var todayBtn: some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation {
                    currentDate = Date()
                }
            }) {
                Text("Today")
            }
            .padding()
        }
        
    }
    
    var body: some View {
        let currentMonth = getCurrentMonth(currentDate)
        let currentMonthDays = getNumberOfDaysInCurrentMonth(currentDate)
        VStack {
            todayBtn
            
            Text("\(currentMonth)")
                .font(.system(size:34))
                .fontWeight(.semibold)
                .padding(.bottom, 40)
            
            tableHeader
            
            //        ForEach(items) { item in
            //            VStack{
            //                Text(item.daynote ?? "note")
            //                Text("\(item.stateofmind)")
            //                Text(item.timestamp?.formatted() ?? "date")
            //            }
            //            .contextMenu(ContextMenu(menuItems: {
            //                Button(action: {
            //                    viewContext.delete(item)
            //                    do {
            //                        try? viewContext.save()
            //                    }
            //                }, label: {
            //                    Text("Delete")
            //                })
            //            }))
            //        }
            
            
            //        calendar grid
            VStack(spacing:-1){
                HStack(alignment: .top) {
                    //            go back
                    
                    Button(action: {
                        monthControl(-1, currentDate)
                    }, label: {
                        Image(systemName: "arrow.left")
                            .frame(width: 48, height: 48, alignment: .center)
                            .font(.system(size: 20, weight: Font.Weight.regular, design: .rounded))
                            .foregroundColor(.black)
                    })
                    .padding(.top, 180)
                    .padding(.trailing, 100)
                    .buttonStyle(.borderless)
                    //            number of days
                    VStack(alignment: .trailing, spacing: -1) {
                        NumberOfDays(days: currentMonthDays)
                    }
                    //            Cells
                    VStack(alignment: .leading, spacing:-1) {
                        ForEach(1..<currentMonthDays+1, id: \.self) { day in
                            HStack(spacing:-1) {
                                DayRow(items: items, currentDate: currentDate, currentMonth: currentMonth, currentDay: day)
                            }
                        }
                    }
                    //            go further
                    Button(action: {monthControl(1, currentDate)}, label: {
                        Image(systemName: "arrow.right")
                            .frame(width: 48, height: 48, alignment: .center)
                            .font(.system(size: 20, weight: Font.Weight.regular, design: .rounded))
                            .foregroundColor(.black)
                        
                    })
                    .buttonStyle(.borderless)
                    .padding(.top, 180)
                    .padding(.leading, 120)
                }
                Rectangle()
                    .frame(width: 688, height: 1)
                    .foregroundColor(.black)
                    .padding(.bottom, 40)
                
            }
        }
    }
    
    
    func monthControl(_ control: Int, _ date: Date) {
        withAnimation(.easeOut(duration: 0.15)) {
            newCity = CGFloat.random(in: 100...110)
            let newMonth = Calendar.current.date(byAdding: .month, value: control, to: date)
            currentDate = newMonth!
        }
        
    }
}


func getCurrentMonth(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter.string(from: date)
}

func getNumberOfDaysInCurrentMonth(_ date: Date) -> Int {
    let calendar = Calendar.current
    let range = calendar.range(of: .day, in: .month, for: date)
    guard let numberOfDays = range?.count else {
        return 0
    }
    return numberOfDays
}


struct NumberOfDays: View {
    var days: Int
    var body: some View {
        ForEach(1..<days, id: \.self) { day in
            Text("\(day)")
                .font(.system(size: 9, weight: .medium, design: .default))
                .tracking(1)
                .frame(minWidth: 10, minHeight: 20)
                .foregroundColor(day == 1 ? .black : (day % 5 == 0 ? .black : .clear))
        }
    }
}


struct TableTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
 
#if os(macOS)
    if #available(macOS 13.0, *) {
        // Code that should only run on macOS 13.0 or later
        content
            .tracking(1)
            .font(.system(size: 8, weight: .medium, design: .default))
            .multilineTextAlignment(.center)
    } else {
        content
            .font(.system(size: 8, weight: .medium, design: .default))
            .multilineTextAlignment(.center)
    }
#endif

    }
    
}

